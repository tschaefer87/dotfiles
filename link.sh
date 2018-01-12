#!/bin/bash
cd $(dirname $0)

# Function that links a file to $HOME, DELETING it there if it exists already

function linkFile() {
    LINK_TO_NAME=$2
    if [ -z $LINK_TO_NAME ]; then
        LINK_TO_NAME=$1
    fi
    if [ -a $HOME/$LINK_TO_NAME ]; then
        #echo "**** Found existing $LINK_TO_NAME, skipping..."
        echo "**** Found existing $LINK_TO_NAME, deleting..."
        rm -rf $HOME/$LINK_TO_NAME
        echo "Linking $1 to $LINK_TO_NAME"
        ln -s $PWD/$1 $HOME/$LINK_TO_NAME
    elif [ -h $HOME/$LINK_TO_NAME ]; then
        echo "Already symlinked $LINK_TO_NAME, skipping..."
    else
        echo "Linking $1 to $LINK_TO_NAME"
        ln -s $PWD/$1 $HOME/$LINK_TO_NAME
    fi
}

# Link files to home and exclude the ones containing certain strings

for F in .zshrc .zprofile .oh-my-zsh .shrc .glob_git_ignore .gitconfig
do 
	linkFile $F
done
