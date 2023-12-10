New-Module -Name PsFzfUtil -Script {
  function Invoke-Fzf {
    fzf --bind='ctrl-d:preview-page-down' --bind='ctrl-u:preview-page-up' --no-sort --border --prompt='Search Directory> ' --height=95% `
    --layout=reverse --bind='ctrl-/:toggle-preview' --preview-window='110' --preview='bat --plain --color=always {}' `
    --color='bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672' `
  }
  Export-ModuleMember -Function Invoke-Fzf
} 2>&1>$null
