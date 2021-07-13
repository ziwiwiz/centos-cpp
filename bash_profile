# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

### local ###
export TZ=Asia/Shanghai
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

### billing ###
export OB_REL=$HOME/ob_rel
export OB_SRC=$HOME/ob_src
export OB_RUN=$OB_REL
export WORK_PATH=$OB_REL
export LD_LIBRARY_PATH=$OB_REL/lib:$LD_LIBRARY_PATH
export PATH=$OB_REL/bin:$PATH

### build ###
export UNITTEST_TOTAL_ON=0
export NEED_DLOPEN_CHECK=1
export NEED_GEN_MAPREDUCE=0

### gcc-5.2.0 ###
export LD_LIBRARY_PATH=/usr/local/gcc-5.2.0/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/gcc-5.2.0/bin:$PATH

### aliases ###
alias cdsrc='cd $OB_SRC'
alias cdrel='cd $OB_REL'
alias cdrating='cd $OB_SRC/rating_billing/rating'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

### others ###
export PATH=.:$PATH
ulimit -c unlimited
#export LD_PRELOAD=$OB_REL/lib/libtcmalloc.so
export ODBCINI=$HOME/odbc.ini
