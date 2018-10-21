# This is a shell script, which replicates system on the local linux machine and send the replicas to the server. 
# it is very useful to study dynamical behaviour of the system under various physical parameters.
# In this example we perform molecular dynamics simulations with Gromacs of lipid bilayer under different pressure to compress the system. 
# All simulations are going to be performed in NPT conditions with Nose-Hoover thermostat and Parrinello-Rahman barostat on the typical model of the
# POPC membrane bilayer that has been pre-equilibrated during 120 ns in the same conditions;
# Here is a tutotial for lipid simulations in gromacs, which explains how to build and equilibrate that same system
# http://www.bevanlab.biochem.vt.edu/Pages/Personal/justin/gmx-tutorials/membrane_protein/index.html
# After execution the script takes gro, ndx and topol top files (from ./ref/) and creates input files for GROMACS (mdp)
# as well as input script (run.pbs) to run the simulations on the multi-CPU server ( should be adapted).
# Finally, the script also creates additional *.sh scripts within of the output folder to manage simulations on the server.
# NB! Check the strings 444 and 497 of the script to adapt it for your server and version of gromacs!


#!/bin/bash

home=$(pwd)
output_sys="${home}"/output

# folder with the system which is going to be replicated
ref_folder="${home}"/ref


# set name of the project
project="popc120.compress"
rm -r "${output_sys}"/${project}
mkdir "${output_sys}"/${project}

root="${output_sys}"/${project}

#system info
now=$(date +"%m_%d_%Y") # today date, which may be added as the suffix
cpus='32' # number of cpus, which will be reserved for each simulation on the server
sim_time='1-10:30:00' # time limit of simulation: 1 day, 10 hours and 30 minutes



# this is array with the pressure, which will be applied on Z
mega_array=('10.0' '20.0' '30.0' '40.0' '50.0'); # pressure in bar




# we take an input gro file with the gromacs topology and ndx file and prepare for it MDP files as well as run.pbs file

for ref_md in ${ref_folder}/popc_bilayer; do
  ref_title=$(basename "$ref_md")
  echo "System ${ref_title} will be replicated "${#mega_array[*]}" times"
  sleep 2
  server=${output_sys}/${project}/simulations
  output="${server}"
  mkdir  ${root}
  mkdir ${server}
  cd ${server}
for i in "${mega_array[@]}"
do
   cp -r ${ref_md} ${output}/${project}_${i}bar
   cd ${output}/${project}_${i}bar
# print mpd files for the equilibration
  printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 1.0    1.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     1.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = Yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil1.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     2.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil2.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     3.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil3.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     4.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil4.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     6.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil5.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     8.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil6.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     10.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil7.mdp"
printf "integrator              = md
dt                      = 0.002
nsteps                  = 500000
nstlog                  = 5000
nstxout                 = 50000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     12.0
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com" > "${output}/${project}_${i}bar/equil8.mdp"

# print mpd file for the production run 1 ; 50 ns production run
  printf "integrator              = md
dt                      = 0.002
nsteps                  = 25000000 ; 50 ns test production run
nstlog                  = 5000
nstxout                 = 2500000
nstxout-compressed      = 5000
nstvout                 = 5000
nstfout                 = 5000
nstcalcenergy           = 100
nstenergy               = 5000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = MEMB   SOL_ION
tau_t                   = 2.0    2.0
ref_t                   = 310 310
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     ${i}
gen_vel                 = no
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = MEMB   SOL_ION
;
refcoord_scaling        = com
; Deformation is off
; Deform = 0 0 0 0 0 0" > "${output}/${project}_${i}bar/production_${i}bar.mdp"


   # print a input file for server
   # NB! should be adapted for specific server
printf "#PBS -N ${ref_title}_${i}.dynamics
#PBS -l nodes=1:ppn=${cpus}           #один узел, 32 процессора
#PBS -q day
#PBS -V


# equilibrate system step-by-step increasing pressure
gmx grompp -f equil1.mdp -o equil_${i}bar_1.tpr -c System.gro -t System.cpt -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_1
gmx grompp -f equil2.mdp -o equil_${i}bar_2.tpr -c equil_${i}bar_1 -t equil_${i}bar_1 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_2
gmx grompp -f equil3.mdp -o equil_${i}bar_3.tpr -c equil_${i}bar_2 -t equil_${i}bar_2 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_3
gmx grompp -f equil4.mdp -o equil_${i}bar_4.tpr -c equil_${i}bar_3 -t equil_${i}bar_3 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_4
gmx grompp -f equil5.mdp -o equil_${i}bar_5.tpr -c equil_${i}bar_4 -t equil_${i}bar_4 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_5
gmx grompp -f equil6.mdp -o equil_${i}bar_6.tpr -c equil_${i}bar_5 -t equil_${i}bar_5 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_6
gmx grompp -f equil7.mdp -o equil_${i}bar_7.tpr -c equil_${i}bar_6 -t equil_${i}bar_6 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_7
gmx grompp -f equil8.mdp -o equil_${i}bar_8.tpr -c equil_${i}bar_7 -t equil_${i}bar_7 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm equil_${i}bar_8

# run production run for 50 ns
gmx grompp -f production_${i}bar.mdp -o ${project}_${i}bar_0.tpr -c equil_${i}bar_8 -t equil_${i}bar_8 -n System.ndx -p System.top -maxwarn -1
mpirun -np \${NB_TASKS} mdrun_mpi -v -deffnm ${project}_${i}bar_0" > "${output}/${project}_${i}bar/run.pbs"

done

cd -
done

# print additional scripts which are used to manage simulations on server

# this script submit all md jobs in parallel
{
  ## print the header, and substitute our own value for HOME
  printf '#!/bin/bash\n'
  printf "cpus='${cpus}'\n"
  printf "time='${sim_time}'\n"
  ## EVERYTHING BELOW HERE UNTIL THE EOF IS LITERAL
  cat <<'EOF'
output=$(pwd)/simulations
run_file=run.pbs

#run GROMACS for each simulation
for sim in "${output}"/* ; do
 if [[ -d $sim ]]; then
  simulation=$(basename "${sim}")
  cd "${sim}"
  chmod +x "${sim}"/${run_file}
  sbatch -n ${cpus} --time=${time} ompi  "${sim}"/${run_file}
  echo "${simulation} has been submitted!"
  cd -
 fi
done
EOF
} > "${root}/submitter.sh"

# this script takes trajectories and energies for each of the md jobs
{
  ## print the header, and substitute our own value for HOME
  printf '#!/bin/bash\n'
  printf "tit=\'${project}\'\n"
  printf "max=\'${max}\'\n"
  ## EVERYTHING BELOW HERE UNTIL THE EOF IS LITERAL
  cat <<'EOF'
server=$(pwd)
results=${server}/results
output=${server}/simulations

rm -r ${server}/results*
mkdir ${results}

date=$(date +"%m_%d_%Y")
declare -a file_array=()

for sim in "$output"/* ; do
 if [[ -d $sim ]]; then
  for k in $(seq 1 $max); do
  simulation=$(basename "$sim")
  file=( "${sim}"/${tit}*_$k.xtc  )
  file2=( "${sim}"/${tit}*_$k.edr )
  file_name=$(basename "${file}")
  traj_name=${file_name/.xtc/}
  file_name2=$(basename "${file2}")
  (cd "${sim}" && exec cp "${file}" "${results}/${traj_name}.xtc")
  file_array+=( "$file" )
  (cd "${sim}" && exec cp "${file2}" "${results}/${traj_name}.edr")
  echo "${file_name} from ${simulation} has been collected!"
 done
 fi
done

#mv ${results} ${server}/results_${simulation}
#tar -zcvf results_${simulation}.tar.gz ${server}/results_${simulation}

echo "These trajectories have been collected, Sir!"
for i in "${file_array[@]}"
do
    printf "%s\n" $i
done

echo "Total: ${#file_array[*]} trajectories have been collected"
EOF
} >"${root}/collecter.sh"

chmod +x "${root}"/*.sh
# upload simulations on server with your login via SCP protocol
#scp -r "${root}" login@server
