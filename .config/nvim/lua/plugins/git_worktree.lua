-- url: https://github.com/ThePrimeagen/git-worktree.nvim
-- desc: Git worktree management
return {
  'ThePrimeagen/git-worktree.nvim',
  keys = {
    { '<leader>gwc', ':Telescope git_worktree create_git_worktree<CR>', desc = 'Create a new git worktree' },
    { '<leader>gws', ':Telescope git_worktree git_worktrees<CR>', desc = 'List existing git worktrees' },
  },
}
