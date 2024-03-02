# Mr.Robot Theme.
# Minimalistic theme that displays git branch and status with icons

PRIMARY_COLOR='#eeeee4'
SECONDARY_COLOR='#2596be'
INFO_TEXT='#808080'
MODIFIED_COLOR='#FFA500'
ADDED_COLOR='#008000'
DELETED_COLOR='#FF0000'

# Function to display git branch and status
function git_prompt_status() {
    local branch_name
    local git_status
    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch_name" ]; then
        git_status=$(git status --porcelain 2>/dev/null)
        if [ -n "$git_status" ]; then
            local added=""
            local deleted="󱂥"
            local modified="󰔤"
            local untracked=""
            local ahead=""
            local behind=""
            
            local symbols=""
            
            # Check for updates
            if [[ "$git_status" =~ ([MADRC]) ]]; then
                symbols+=" %F{$MODIFIED_COLOR}$modified%f "
            fi
            
            # Check for adds
            if [[ "$git_status" =~ ([A]) ]]; then
                symbols+=" %F{$ADDED_COLOR}$added%f "
            fi
            
            # Check for deletes
            if [[ "$git_status" =~ ([D]) ]]; then
                symbols+=" %F{$DELETED_COLOR}$deleted%f "
            fi
            
            # Check for untracked
            if [[ "$git_status" =~ ([?]) ]]; then
                symbols+=" %F{$INFO_TEXT}$untracked%f "
            fi
            
            echo " $symbols %F{$INFO_TEXT} $branch_name%f"
        else
            echo " %F{$INFO_TEXT} $branch_name%f"
        fi
    else
        echo " %F{INFO_TEXT}󱂷 %f"
    fi
}

# Set the prompt
PROMPT='%F{$PRIMARY_COLOR}󰚩 %f%F{$SECONDARY_COLOR} %f '

# Customize the right prompt
RPROMPT='$(git_prompt_status)'
