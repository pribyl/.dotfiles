# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="jonathan"
#ZSH_THEME="rkj-repos"
ZSH_THEME="tpr"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# for a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function cfg {
   git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}


alias st='tig status'
alias psg='ps -eo pid,ppid,uname,rss,vsize,pcpu,args,cmd,etime | grep $USER | grep'
alias dff='df -h -x squashfs -x tmpfs -x devtmpfs'

alias gd='git diff '
#alias docker='podman'

export CLION=$HOME/sw/clion/bin/clion.sh
alias ccc='$CLION CMakeCache.txt > /dev/null 2>&1 & disown %1'

alias agg='ag -U -S --hidden -G ".*"'

alias clion=$CLION

function mkcd {
  mkdir -p $1
  cd $1
}

alias -g prj=~/projects
alias git-sub='git submodule update --init --recursive'

alias cdiff='clion diff'
alias bdiff='bcompare'

function cmk {
  rm out.txt 2>/dev/null
  cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release $@ 2>&1 | tee -a out.txt
  ag 'Configuring incomplete' <out.txt &> /dev/null
  if [ $? -ne 0 ]; then
    ccmake .
    ninja
  fi
}

alias cmifd='cmake -C ../cmake/config/linux64-gcc.cmake -C ../cmake/config/devel_linux.cmake -DCMAKE_BUILD_TYPE=Debug ..'
alias cmifr='cmake -C ../cmake/config/linux64-gcc.cmake -C ../cmake/config/devel_linux.cmake -DCMAKE_BUILD_TYPE=Release ..'

#source $HOME/.linuxbrew/share/antigen/antigen.zsh
#antigen bundle soimort/translate-shell

if [[ ! -a /.dockerenv ]]; then
  function dkr {
    imagesAll=(`docker images -a | ag -v none | tail -n +2 | awk '{print $1 ":" $2}'`)

    selected=1
    regexp=''
    modif=0
    images=''

    while [ 1 ]; do
      tput ed
      tput el1
      echo

      if [ ! -z "$regexp" ];
      then
        rgxp=`echo "$regexp" | sed -r 's/(.)/\1.*/g'`
        images=(`printf '%s\n' "${imagesAll[@]}" | ag $rgxp`)
      else
        images=(`echo $imagesAll`)
      fi

      if [ "$selected" -le "1" ]
      then
        selected=1
      fi
      if [ "$selected" -ge "${#images}" ]
      then
        selected=${#images}
      fi

      for i in $(seq ${#images}); do
        sel=' '
        if [ "$i" -eq "$selected" ];
        then
          sel='>'
          tput rev
        fi
        echo "$sel${images[$i]}"
        tput sgr0
      done
      for i in {1..$((${#images}+1))};do tput cuu1; done
      echo -n $regexp

      read -sk 1 key
      code=`printf "%d\n" "'$key"`
      if [ "$code" -eq "27" ];
      then
        read -sk 1 key
        code=`printf "%d\n" "'$key"`
        case "$code" in
          91)
            read -sk 1 key
            code=$((256+`printf "%d\n" "'$key"`))
            ;;
          27)
            return 0
            ;;
        esac
      fi

      case "$code" in
        10)
          if [ ! -z "$images" ];
          then
            image=${images[$(($selected))]}
            break
          fi
          ;;
        127)
          regexp="${regexp%?}"
          ;;
        321)
          selected=$(($selected-1))
          ;;
        322)
          selected=$(($selected+1))
          ;;
        *)
          regexp="$regexp$key"
          ;;
      esac
    done

    tput ed
    echo

    echo "image: $image"
    name=`echo "$USER-$image-$RANDOM" | sed -r 's/[\/:.]+/_/g' | sed -r 's/_ba_innovatrics_net//g'`
    echo "name: $name"
    
    echo -n "params: "; read params

    cmd="docker run -ti --rm --name $name --hostname $name --volume=/home/tpribyl:/home/tpribyl --volume=/home/tpribyl:/home/dev --volume=/home/tpribyl:/root --volume=/p:/p -w $PWD -u root $image $params"
    #cmd="docker run -ti --rm --name $name --hostname $name --volume=/home/tpribyl:/home/tpribyl --volume=/home/tpribyl:/home/dev --volume=/etc/passwd:/etc/passwd --volume=/etc/group:/etc/group --volume=/p:/p -w $PWD -u tpribyl $image $params"
    echo "cmd: $cmd"
    
    `echo $cmd`
  }
fi

alias fh='find . -iname'

alias xtest='ctest --output-on-failure -R'

alias l='ls -lah --color --group-directories-first'

alias gsha='echo `git log --pretty=format:'%h' -n 1`'

alias rsy='rsync -ah --info=progress2'

alias pcloud='~/sw/pcloud > /dev/null 2>&1 & disown %1'

function venv {
  source /p/venv/$1/bin/activate
}

function mdd {
  pandoc $1 | lynx -stdin
}

export PATH="$HOME/sw:/opt/cmake-3.13.3/bin:/p/cling/inst/bin:$HOME/.cargo/bin:$HOME/sw/wtf_0.20.0_linux_amd64:$HOME/sw:$PATH"

export PYTHONPATH="/p/image_flat_dev/ml_framework/python:/p/image_flat_dev/iface/connectors/python:/p/image_flat_dev/libs/img_tran/connectors/python:/p/image_flat_dev/ext_libs/caffe/python"

export INTEL_ROOT=/opt/intel/compilers_and_libraries_2018.5.274/linux/
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
