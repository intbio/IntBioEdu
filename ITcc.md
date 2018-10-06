# Crash course on IT for IntBio students

## Mastering Linux & Command Line
### Getting access to a Linux Machine
You'll need an acceess to a Linux machine.
- Option 1: Install [Ubuntu](https://www.ubuntu.com) as a Virtual Machine [https://www.virtualbox.org](https://www.virtualbox.org)
- Option 2: Live Ubuntu USB stick https://www.howtogeek.com/howto/linux/create-a-bootable-ubuntu-usb-flash-drive-the-easy-way/
- Option 3: Connect remotely to a server using SSH protocol. Server address, username and password will be provided. Alternatively, you can launch a server in Amazon cloud, see here https://youtu.be/GQCIKXwLudg (is free for the first year, but requires a credit card for registration).
#### Using SSH protocol to connect to a remote Linux machine
- To connect to a Linux machine you'll need its address, username, password or security key.
- On Windows install PuTTy https://www.putty.org  , https://youtu.be/1wQ8wQfa7lw 
- Mac and Linux have built in SSH client
``` ssh username@server_address ``` 
- Forwarding graphics. 
  - On Linux/Mac just add ```-X``` option to ssh command. Mac install XQuartz beforehand https://www.xquartz.org .
  - On Windows - install X server https://sourceforge.net/projects/xming/ , launch, in PuTTy enable X11 forwarding.   
  Type ```xclock``` in terminal to check if it works.
#### Using SCP protocol to transfer files
- Windows: Install WinSCP https://winscp.net/eng/download.php
- Linux/Mac: use ```scp``` command or Mindnight Commander https://midnight-commander.org .

#### Using SSH key authentication
- Here is an exmaple [public key](https://github.com/intbio/IntBioEdu/blob/master/samplekey.pem) in Linux SSH format.
- Converting Linux SSH key format to PuTTy format can be done using PuTTYgen Explained [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console)
- Generating your own SSH keys: Windows - PuTTYgen, Linux/Mac - use ```ssh-keygen``` command.
- Connect using SSH key instead of a password:
   - Linux/Mac ``` ssh -i samplekey.pem username@server_address ``` 
   - PuTTy - see [here](https://devops.profitbricks.com/tutorials/use-ssh-keys-with-putty-on-windows/) last image.

#### Using X2GO
- Using X2Go to conntect to a Linux machince that has X2Go installed. [Video (in Russian) on using x2Go.](https://www.youtube.com/watch?v=mUyFPNeZhm4&feature=youtu.be)

, set correct permission before ```chmod 400 samplekey.pem```


### Mastering Linux command line and coreutils
- Mastering Linux Shell http://swcarpentry.github.io/shell-novice/
- [Introduction to Linux](https://stepik.org/course/73) - this course by [Bioinformatics Institute](https://bioinf.me/) will make you familiar with basics of Linux.

## Introduction to Git/ GitHub
- [http://github.com](http://github.com)


 [http://swcarpentry.github.io/git-novice/](http://swcarpentry.github.io/git-novice/)
 
 [Youtube tutorials](https://www.youtube.com/user/GitHubGuides/playlists)
 - GitHub
 
 [GitHub Learning Lab](https://lab.github.com/) - the Learning Lab bot 
 - Making your lab web-page via GitHub, here are [instructions](gitpage_instr.md) (in Russian).
 
 [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

## Literature management
- Literature searching

- Literature reference managers

## Introduction to Python

- Basic Python / Jupiter notebooks http://www.intbio.org/CBsem/19Feb2018_IT.html

[http://swcarpentry.github.io/python-novice-inflammation/](http://swcarpentry.github.io/python-novice-inflammation/)

[http://swcarpentry.github.io/python-novice-gapminder/](http://swcarpentry.github.io/python-novice-gapminder/)

## Data analysis and plotting

## Introduction to R

## Introduction to  LaTeX

## Introduction to  Web technologies



