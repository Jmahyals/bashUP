# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Enable color support for `ls` and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

#banner personalizado

# Set a colorful prompt with the directory on one line and the command prompt on the next
PS1='\[\e[0;30;43m\] \w \[\e[0m\]\n\[\e[0;32m\] >  \[\e[0m\]'

# Enable Bash completion if available
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Autocompletar para comandos personalizados
_custom_commands() {
    local current_word options
    current_word="${COMP_WORDS[COMP_CWORD]}"
    options="mi_comando1 mi_comando2 mi_comando3"

    COMPREPLY=( $(compgen -W "${options}" -- ${current_word}) )
}

# Autocompletar para directorios y archivos
_files_and_directories() {
    local current_word
    current_word="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -f ${current_word}) )
}

# Configuración de colores para diferentes tipos de archivos
export LS_COLORS="\
*.md=38;5;135:\
*.js=38;5;226:\
*.html=38;5;208:\
*.py=38;5;81:\
*.sql=38;5;45:\
*.txt=38;5;141:\
*.json=38;5;196:\
*.css=38;5;39:\
*.xml=38;5;214:\
*.sh=38;5;118:\
*.csv=38;5;214:\
*.tar=38;5;215:\
*.gz=38;5;69:\
*.zip=38;5;33:\
*.jpg=38;5;214:\
*.jpeg=38;5;214:\
*.png=38;5;208:\
*.gif=38;5;227:\
*.mp3=38;5;112:\
*.mp4=38;5;160:\
*.pdf=38;5;199:\
*.doc=38;5;34:\
*.docx=38;5;34:\
*.xls=38;5;76:\
*.xlsx=38;5;76:\
*.ppt=38;5;166:\
*.pptx=38;5;166:\
*.apk=38;5;34"

alias ls='ls --color=auto'

# Asignar las funciones de autocompletado a los comandos correspondientes
complete -F _custom_commands mi_comando
complete -F _files_and_directories cd
alias ls="lsd"
alias md="mkdir"
alias rmd="rm -rf"
alias cdsd="cd /sdcard"

# Habilitar el autocompletado para comandos y directorios
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
shopt -s histappend
shopt -s dotglob

# Mejorar el historial de comandos
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:ls:[bf]g:exit"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#exportar mas comandos
export PATH=$PATH:~/myscript
export PATH=$PATH:~/calculator

#Comando para ver los archivos 
fl() {
  local file
  local mime_type

  # Encuentra archivos en el directorio actual y en los directorios raíz especificados
  file=$(find . -maxdepth 1 -type f -or -path "$root_dirs/*" | fzf --height 40% --reverse --border --prompt 'Select file: ')

  # Abre el archivo seleccionado si se ha hecho una selección
  if [ -n "$file" ]; then
    # Asegúrate de que la ruta es absoluta
    file=$(realpath "$file")
    
    # Determina el tipo MIME del archivo
    mime_type=$(file --mime-type -b "$file")

    # Abre el archivo según su tipo MIME con la aplicación adecuada
    case "$mime_type" in
      text/*)
        nano "$file"
        ;;
      image/*)
        termux-open "$file"
        ;;
      video/*)
        termux-open "$file"
        ;;
      audio/*)
        termux-open "$file"
        ;;
      application/pdf)
        termux-open "$file"
        ;;
      *)
        termux-open "$file"
        ;;
    esac
  fi
}

sao() {
  local ext
  ext=$(echo -e "pdf\njpg\npng\naudio" | fzf --height 60% --reverse --border)
  
  if [ -n "$ext" ]; then
    local file
    file=$(find . -type f -name "*.${ext}" | fzf --height 60% --reverse --border)
    
    if [ -n "$file" ]; then
      termux-open "$file"
    fi
  fi
}


fdl() {
  local file
  file=$(find . -type f -size +50M | fzf --height 60% --reverse --border)
  
  if [ -n "$file" ]; then
    read -p "¿Estás seguro de que deseas eliminar $file? (s/n) " confirm
    if [[ $confirm == [sS] ]]; then
      rm "$file"
      echo "$file ha sido eliminado."
    else
      echo "Operación cancelada."
    fi
  fi
}

# Función para cambiar al directorio seleccionado y mostrar la cantidad de archivos
cdl() {
  local dir
  dir=$(find . -maxdepth 1 -type d | tail -n +2 | fzf --height 70% --reverse --border)

  # Cambia al directorio seleccionado si se ha hecho una selección
  if [ -n "$dir" ]; then
    cd "$dir"
    # Mostrar la cantidad de archivos en el directorio actual
    echo "Directorio actual: $(pwd)"
    echo "Cantidad de archivos: $(ls -1 | wc -l)"
  fi
}

szl() {
  local dir
  dir=$(find . -maxdepth 1 -type d ! -path . | fzf --height 60% --reverse --border)

  # Mostrar el directorio seleccionado si se ha hecho una selección
  if [ -n "$dir" ]; then
    echo "Directorio seleccionado: $dir"
    # Mostrar el tamaño total de archivos en el directorio seleccionado
    echo "Tamaño total de archivos: $(du -sh "$dir" | awk '{print $1}')"
  fi
}

# Función para buscar y ejecutar scripts shell
rsh() {
    local script
    local file
    file=$(find /data/data/com.termux/files/home/myscript -type f -name "*.sh" -print | \
           awk -F'/' '{print $NF}' | \
           fzf --prompt "Select a script to run: " \
               --preview "echo {}" \
               --preview-window=up:20%:wrap \
               --height=30%)
    
    if [[ -n "$file" ]]; then
        script=$(find /data/data/com.termux/files/home/myscript -type f -name "$file")
        if [[ -n "$script" ]]; then
            bash "$script"
        fi
    fi
}
