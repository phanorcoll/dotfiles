# Mr.Robot Theme.
# Minimalistic theme that displays git branch and status with icons

PRIMARY_COLOR='#eeeee4'
SECONDARY_COLOR='#2596be'
INFO_TEXT='#808080'
MODIFIED_COLOR='#FFA500'
ADDED_COLOR='#008000'
DELETED_COLOR='#FF0000'
YELLOW_COLOR='#FFDE59'

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

            echo "  $symbols %F{$INFO_TEXT} $branch_name%f"
        else
            echo "  %F{$INFO_TEXT} $branch_name%f"
        fi
    else
        echo " %F{INFO_TEXT}󱂷 %f"
    fi
}

# Function to display tool versions based on the project
function project_tool_versions() {
    local tool_info=""

    # Check for Node.js version
    if [ -f "package.json" ] || [ -d "node_modules" ]; then
        local node_version=$(node -v 2>/dev/null)
        [ -n "$node_version" ] && tool_info+="  %F{$YELLOW_COLOR}󰎙 $node_version%f"
    fi

    # Check for TypeScript version
    if [ -f "tsconfig.json" ]; then
        local ts_bin="./node_modules/.bin/tsc"
        if [ -x "$ts_bin" ]; then
            local ts_version=$($ts_bin --version 2>/dev/null | awk '{print $2}')
            [ -n "$ts_version" ] && tool_info+="  %F{$SECONDARY_COLOR}󰛦 $ts_version%f"
        fi
    fi

    # Check for Go version
    if [ -f "go.mod" ] || [ -d ".go" ]; then
        local go_version=$(go version 2>/dev/null | awk '{print $3}')
        [ -n "$go_version" ] && tool_info+="  %F{$SECONDARY_COLOR} $go_version%f"
    fi

    if [ -n "$tool_info" ]; then
        echo "$tool_info"
    fi
}

# Set the prompt
PROMPT='%F{$PRIMARY_COLOR}󰚩  %n%f $(git_prompt_status)$(project_tool_versions)
%F{$SECONDARY_COLOR}%f '
# Customize the right prompt
# RPROMPT='$(git_prompt_status)$(project_tool_versions)'
