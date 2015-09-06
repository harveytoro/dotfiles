# Aliases 
alias writer="open -a iA\ Writer";
alias sublime="open -a Sublime\ Text\ 2";
alias chrome="open -a Google\ Chrome";
alias firefox="open -a Firefox";
alias safari="open -a Safari";
alias browsers="chrome; firefox; safari;";
alias ls="ls -aG";
alias bashreload="source ~/.bash_profile";

# Screen capture in arg1 seconds, arg2 filename
shot(){

screencapture -T $1 /users/$(logname)/Desktop/$2.jpg;

}

# ls and grep together arg1 grep find
lg(){

ls | grep $1;

}

# quick code testing arg1 filename arg2 if new dir needed
code(){

cd code;

if [ $2 != "" ]; then
    mkdir $2;
    cd $2;
fi

vim $1;

}

# new dropbox folder with symnlink in documents
mkdropboxdir(){

### Get home path
mkdir "/Users/$(logname)/Dropbox/$1";
ln -s "/Users/$(logname)/Dropbox/$1" "/Users/$(logname)/Documents/$1";

}

# java on the command line
jcompile(){

mkdir ./src/classes;
javac -d ./src/classes -cp classes ./src/java/*.java;
cd ./src/classes;
echo "now run java -classpath . package.main";

}

# useful tcpdump command
pckdump(){

echo "tcpdump -xX -vv -i lo0 'port 123' ";
sudo tcpdump -xX -vv -i  $2 "port $1";

}

# create github repo {Not useful with 2FA tokens}
githubcreate(){

# if no args probably forgotten them
if [ -z $1 ]; then
     echo "arg1: repo name, arg2: repo description"
     return;
fi

# default to private reporsitory
private=$3
if [ -z  $3 ]; then
     private="true";
fi
# curl request to the github API
curl -u "$(logname)" https://api.github.com/user/repos -d  '{"name":'\""$1"\"',"description":'\""$2"\"', "private":'"$private"'}'

}

# Process groff man page
manpageview(){

groff -Tascii -man $1;

}

