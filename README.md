# gopath-auto
This script sets GOPATH variable when entering in the tree Go project.

# Install
Source the script into .bashrc or .zshrc 
```script
source gopath-auto.sh
```

# Usage
Into the root directory of your Go project create the file :
```script
touch .gorc
```
That's all.

Now if you go in your project or into subdirectories, GOPATH variable is set where the ".gorc" file is found and command prompt displays the end of GOPATH.
If you leave your project, GOPATH variable is unset.







 
