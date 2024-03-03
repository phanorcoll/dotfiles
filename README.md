![Create a lively anime scene featuring a Golang-inspired gopher proudly showcasing 'Dotfiles'](https://github.com/phanorcoll/dotfiles/assets/195602/22e1be57-7c04-4be2-a710-ad2fc14c7180)
# Configuration files


## Install
Clone the repo in any location and inside the root of the dotfiles folder run:

`stow --target ~/ .`

**note:** Make sure you dont have the same file structure as the dotfiles folder, if you do, backup everything.

Remember, <u>**never delete**</u> something unless you're 100% sure you'll never need it again.

**Stow** will create a symlink for each folder and file in your **$HOME**.

## Set the Global Configuration for Git
Set the global Git configuration to use your template file.

`git config --global commit.template ~/.git_commit_template.txt `
