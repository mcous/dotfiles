#!/bin/bash

# michael cousins
# july 7, 2013
# shell script to copy my dotfiles to my home directory

# dotfile directory is this one
DOTLOC=~/dotfiles
DOTOLD=~/dotfiles_old
DOTNEW=~

# ignore this script
IGNORE=`basename $0`
# ignore any files with extensions
IGNORE+="|(.+\.[:alnum:]+)"
# also ignore os specific files we don't need
IGNORE+="|(_linux)|(_mac)|(_windows)"
if [[ $OSTYPE =~ "darwin" ]]
    then
    CUT="|(_mac)"
elif [[ $OSTYPE =~ "linux" ]]
    then
    CUT="|(_linux)"
elif [[ $OSTYPE =~ "msys" ]]
    then
    CUT="|(_windows)"
else
    CUT=""
fi
IGNORE=${IGNORE/$CUT/}

# make sure I want to copy new dotfiles in
echo -n "hey man. want some dotfiles? (y/n): "
read r
if [ $r ]
    then
    if [ ${r:0:1} == 'y' ] || [ ${r:0:1} == 'Y' ]
        then
        echo "i knew you were cool; symlinking new dotfiles into $DOTNEW"

        # run through all the files in dotfiles
        NO_OLD=true
        for f in $DOTLOC/*
        do
            # get filename
            FILE=`basename $f`
            # exclude any files we want to exclude
            if [[ ! $FILE =~ $IGNORE ]]
                then
                # check if this dotfile already exists (and is not a symlink)
                if [ -f $DOTNEW/.$FILE ] && [ ! -h $DOTNEW/.$FILE ]
                    then
                    if $NO_OLD
                        then
                        echo "existing dotfiles found and will be backed up to $DOTOLD"
                        # check to make sure there's a dotfiles_old directory
                        if [ ! -d $DOTOLD ]
                            then
                            mkdir $DOTOLD
                        fi
                        NO_OLD=false
                    fi
                    # back up the files
                    mv -f $DOTNEW/.$FILE $DOTOLD/.$FILE
                    echo "backed up .$FILE"
                fi
                # symlink the new one in
                ln -sf $f $DOTNEW/.$FILE
                echo "symlinked $FILE"
            fi
        done
    else
        echo "come back when you wanna have some fun."
    fi
else
    echo "what are you, a cop or something?"
fi
