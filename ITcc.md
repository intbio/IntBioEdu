# Crash course on IT for IntBio students

## Mastering Linux & Command Line
### Getting access to a Linux Machine
- How to get access to Linux from Windows?
  - Install [Ubuntu](https://www.ubuntu.com) on  VM [https://www.virtualbox.org](https://www.virtualbox.org)
  - Live USB stick https://www.howtogeek.com/howto/linux/create-a-bootable-ubuntu-usb-flash-drive-the-easy-way/
  - SSH remotely to a lab server or AWS instance
- Launching an instance in Amazon web services https://youtu.be/GQCIKXwLudg (is free for the first year, but requires a credit card for registration)
- To connect to a Linux machine you need its address, username, password or security key.
  - Example, machine to try for today: address (will be provided), username - ubuntu, sample key - [see this file](samplekey.pem).
- SSH: on Windows install PuTTy https://www.putty.org  , https://youtu.be/1wQ8wQfa7lw , before connecting you will need to covert the sample key file in a format recognized by PuTTY, use PuTTYgen and follow these instructions https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console 
- Mac and Linux have built in SSH
``` ssh -i samplekey.pem ubuntu@server_address ``` , set correct permission before ```chmod 400 samplekey.pem```
- Transfer files: Windows - WinSCP https://winscp.net/eng/download.php , Linux/Mac use ```scp``` command or Mindnight Commander https://midnight-commander.org .
- Generating your own SSH keys: Windows - PuTTYgen, Linux/Mac - ```ssh-keygen```
- Forwarding graphics: Windows - install X server https://sourceforge.net/projects/xming/ , launch, in PuTTy enable X11 forwarding.  Linux/Mac just add ```-X``` option to ssh command. Mac install XQuartz beforehand https://www.xquartz.org . Testing type ```xclock``` in terminal.
- Using X2Go to conntect to a Linux machince that has X2Go installed. [Video (in Russian) on using x2Go.](https://www.youtube.com/watch?v=mUyFPNeZhm4&feature=youtu.be)
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



