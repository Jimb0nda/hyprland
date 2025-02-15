#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias find='fzf --preview="bat --color=always {}"'
alias edit='code $(fzf -m --preview="bat --color=always {}")'
alias cdf='cd ~; cd $(fd --type directory --hidden | fzf)'
alias auth='xhost +si:localuser:root'

#Services
#alias service='systemctl'

#Grub Update
alias grubu='sudo grub-mkconfig -o /boot/grub/grub.cfg'

#Package manager
alias pacu='sudo pacman -Syu'
alias pacr='sudo pacman -R'

#Dotnet
alias newProj='dotnet new console -o'

#Cpp
build_cpp() {
    # Ensure build directory exists
    mkdir -p build

    # Run cmake commands from the source directory
    cmake -B build "$@"
    cmake --build build
}

create_lib() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: create_lib <source_name> <library_name>"
        return 1
    fi

    source_file="$1.cpp"
    object_file="$1.o"
    library_file="$2.a"
    lib_dir="lib"

    if [[ ! -f $source_file ]]; then
        echo "Error: Source file '$source_file' does not exist."
        return 1
    fi

    # Compile the source file
    g++ -c "$source_file" -Iinclude -o "$object_file"
    if [[ $? -ne 0 ]]; then
        echo "Error: Compilation failed."
        return 1
    fi

    # Create the library
    ar rcs "$library_file" "$object_file"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to create library."
        rm -f "$object_file"
        return 1
    fi

    # Move the library to the destination directory
    mv "$library_file" "$lib_dir/"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to move library to $lib_dir."
        return 1
    fi
    echo "Library moved to $lib_dir."

    # Clean up
    rm "$object_file" "$source_file"
}

#SSH
alias pc='ssh jpear@192.168.1.113'

#Git
alias add='git add .'
commit() {
    git commit -m "$1"
}
alias push='git push'
clone() {
    git clone git@github.com:Jimb0nda/"$1".git
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
#fastfetch
