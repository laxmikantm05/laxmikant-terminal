# Hide default fish greeting
set fish_greeting

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Typewriter effect function (used across entire config)
function tw --description "Prints text with a typewriter animation effect"
    set -l delay 0.01
    for c in (string split '' $argv)
        echo -n $c
        sleep $delay
    end
    echo
end

# Lambda-style prompt
function fish_prompt
    set -l last_status $status
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname | cut -d . -f 1)
    end
    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set -g __fish_prompt_char '#'
            case '*'
                set -g __fish_prompt_char (set_color red; echo λ)
        end
    end

    # Define colors
    set -l normal (set_color normal)
    set -l white (set_color FFFFFF)
    set -l red (set_color F00)
    set -l orange (set_color df5f00)
    set -l limegreen (set_color 87ff00)
    set -l turquoise (set_color 5fdfff)

    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color 5fdfff
    set -g __fish_git_prompt_color_flags df5f00
    set -g __fish_git_prompt_color_prefix white
    set -g __fish_git_prompt_color_suffix white
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_show_informative_status true

    # Print animated header
    tw "$white╭─$red$USER$white at $orange$__fish_prompt_hostname$white in $limegreen"(pwd | sed "s=$HOME=⌁=")"$turquoise"
    __fish_git_prompt " (%s)"
    echo

    # Prompt line (non-animated for responsiveness)
    echo -n "$white╰─$__fish_prompt_char $normal"
end

# !! and !$ support
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fancy command history
function history
    builtin history --show-time='%F %T '
end

# Handy backup
function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 to DIR2 if directory
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Aliases
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='psmem | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias fastfetch="fastfetch --logo arch"

# Apply pywal colors if available
if type "wal" > /dev/null 2>&1
    cat ~/.cache/wal/sequences
end

# Starship support
starship init fish | source

# Greet the user with system info
function greet_user
    set hour (date +%H)
    if test $hour -lt 12
        set greeting "Good Morning"
    else if test $hour -lt 18
        set greeting "Good Afternoon"
    else
        set greeting "Good Evening"
    end

    set day (date '+%A')
    switch $day
        case Monday
            set day_greeting "Start the week with strength!"
        case Friday
            set day_greeting "Friday vibes — the weekend is near!"
        case Saturday Sunday
            set day_greeting "It's a weekend — time to relax!"
        case '*'
            set day_greeting "Power up your productivity!"
    end

    set user (whoami)
    set host_name (hostname)
    set current_time (date '+%H:%M:%S')
    set current_date (date '+%A, %d %B %Y')
    set weather_data (curl -s "wttr.in?format=%C+%t")
    set weather_condition (echo $weather_data | awk '{print $1}')
    set weather_temp (echo $weather_data | awk '{print $2}')
    set uptime (uptime -p)
    set last_login (last -n 1 $user | awk '{print $4, $5, $6, $7}')
    set last_logout (last -x -n 1 $user | grep shutdown | awk '{print $6, $7, $8, $9}')

    switch $weather_condition
        case Clear
            set weather_icon "☀️"
        case Cloudy Overcast
            set weather_icon "☁️"
        case Rain
            set weather_icon "🌧️"
        case Snow
            set weather_icon "❄️"
        case '*'
            set weather_icon "🌈"
    end

    fastfetch --logo blackarch

    set_color red
    echo "╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
    tw "┃                                   [ SYSTEM STATUS ONLINE ]                                │"
    echo "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫"
    set_color normal

    tw "              ★☆★ $greeting, $user! $day_greeting ★☆★"
    echo " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    tw "  🖥️       Hostname:        $host_name"
    tw "  🕒   Current Time:        $current_time"
    tw "  📅   Current Date:        $current_date"
    tw "  $weather_icon        Weather:        $weather_condition $weather_temp"

    tw ""
    echo " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    tw "  ⏱️ System Uptime:        $uptime"
    tw "  💡 Last Login   :    $last_login"
    tw "  💡 Last Logout  :      $last_logout"
    echo " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    tw "                     Welcome Back to the system, Captain. Operate with precision."
    set_color red
    echo "╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
    set_color normal
end


# Call greeting on shell open
greet_user

# Random salutation list
set -g salutations "Sir" "Boss" "Chief" "Captain" "Master"

function random_salutation
    set -l count (count $salutations)
    set -l index (random 1 $count)
    echo $salutations[$index]
end

# Post-execution animation
function postexec --on-event fish_postexec
    if set -q __last_command_not_found
        set -e __last_command_not_found
        return
    end

    set -l salutation (random_salutation)
    if test $status -eq 0
        set_color green
        tw "✅ Task completed successfully, $salutation! All systems are go."
    else
        set_color red
        tw "❌ Task failed, $salutation. Exit status: $status."
    end
    set_color normal
end

# Command not found
function fish_command_not_found
    set -l salutation (random_salutation)
    set_color red
    tw "❓ Apologies, $salutation. Command '$argv' not found. Are you sure it's installed?"
    set_color normal
    set -g __last_command_not_found 1
end
