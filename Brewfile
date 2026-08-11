# Aggregator: installs EVERYTHING (nvim + helix + ghostty + zed).
#   brew bundle --file ~/dev/dotfiles/Brewfile
#
# To set up only one tool, use its own file instead:
#   brew bundle --file ~/dev/dotfiles/Brewfile.nvim
#   brew bundle --file ~/dev/dotfiles/Brewfile.helix
#   brew bundle --file ~/dev/dotfiles/Brewfile.ghostty
#   brew bundle --file ~/dev/dotfiles/Brewfile.zed
#
# Brewfiles are plain Ruby, so this just evaluates the per-tool files.
%w[Brewfile.nvim Brewfile.helix Brewfile.ghostty Brewfile.zed].each do |f|
  path = File.join(File.dirname(__FILE__), f)
  instance_eval(File.read(path), path)
end
