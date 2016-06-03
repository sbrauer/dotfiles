alias g="git"
alias s="git status"

alias ga="git add"
alias gap="git add -p"
alias gb="git branch"
alias gci="git commit"
alias gcia="git commit --amend"
alias gcl="git clone"

# Remove local branches that are merged.
alias gclean='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log -p"
alias gp="git pull"
alias gpo="git push origin"
alias gpof="git push origin --force"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias grh="git reset --hard HEAD"
alias gs="git stash"
alias gsp="git stash pop"
alias gss="git stash save"
alias gsa="git stash apply"
alias gsl="git stash list"