declare -r file_activation_name=".gorc"
declare prompt_backup=${PS1}

function customize_prompt {
    echo "\[$(tput setaf 2)\]($1)\[$(tput sgr0)\] $prompt_backup"
}

function set_go_path {
    declare current_path=$1
    if [ "$current_path" != "$LAST_GOPATH" ]
    then
	export GOPATH=$current_path
	export LAST_GOPATH=$current_path
	dir=$(basename $LAST_GOPATH)
	PS1=$(customize_prompt $dir)
    fi
}

function unset_go_path {
    unset GOPATH
    unset LAST_GOPATH
    PS1="$prompt_backup"
}

function exists {
    [ -e "$1/$file_activation_name" ]
}

function search {
    if [ $1 != "/" ]
    then
	if (exists $1)
	then
	    set_go_path $1
	else
	    search $(dirname $1)
	fi
    fi
}

function is_higher_than_last_go_path_tree_directory {
    [ -z $(echo $PWD | grep "$LAST_GOPATH") ]
}

function chpwd () {
    if (is_higher_than_last_go_path_tree_directory $PWD) 
    then
     	unset_go_path
    fi
    search $PWD
}

cd () { builtin cd "$@" && chpwd; }
pushd () { builtin pushd "$@" && chpwd; }
popd () { builtin popd "$@" && chpwd; }
