#/bin/bash
#
# newgit.sh
# create a new directory and clone/fork a repo
# assumes:
#	- a minimal repo already exists on github
#	- an initial README.md file in the repo origin
#	- (Sorry git does not make a ssh create available)
#	- a "git" directory under the $HOME directory
#	- a GIT_USER environment variable exists and is valid for github
#	- the git user configured for ssh key access (without password)
#	- see https://help.github.com/articles/generating-ssh-keys
#
# © 2014 - Robert Strickler - anomalyst@gmail.com
# License: Creative Commons Attribution-Noncommercial-Share Alike 3.0
# http://creativecommons.org/licenses/by-sa/3.0/

if [ $# -eq 0 ]; then echo "No repo name supplied"; exit 1; fi

if [ -z $GIT_USER ]
then
	echo GIT_USER not defined
	exit 1
fi
if true				#change to false to skip executions
then
	cd ~/git
	git clone git@github.com:$GIT_USER/$1 $1
        if [ -e $1 ]		#?-have a matching filename in $HOME
	then
		cd ~/git/$1	#y-move to clone
		cp ~/$1 .	#y-copy it to our clone
				#y-append a horz rule to README
		echo "***" >>README.md
				#y-so commit sees it as changed
		git add --all	#y-include all current files
	fi

fi
echo "use git add to append any new files"
echo "use git commit -m \"commit description\""
echo "use 'git push origin master'"
echo -e "\tto update the $1 repo with the commits"
