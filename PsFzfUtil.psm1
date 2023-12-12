New-Module -ScriptBlock {
  $RG_PREFIX="rg --column --no-heading --color=always --smart-case"
  function MyFzf {
    $p = [System.Diagnostics.Process]@{StartInfo = @{
      FileName = "fzf";
      Arguments = @(
        "--layout=reverse",
        "--height=85%",
        "--border",
        "--no-sort",
        "--prompt=`"Search Directory> `""
        "--bind=`"ctrl-d:preview-page-down`"",
        "--bind=`"ctrl-u:preview-page-up`"",
        "--preview=`"bat --plain --color=always {}`""
        "--preview-window=`"110`""
        "--color=`"bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92671`""
      );
      RedirectStandardOutput = $true;
      WorkingDirectory = $PWD;
    }}

    $p.Start()
    $result = $p.StandardOutput.ReadLine()
    $p.WaitForExit()

    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($result)
    [Microsoft.PowerShell.PSConsoleReadLine]::ClearScreen()
  }
  # TODO adapt the below function to match the above
  function MyRg {
    fzf --bind='ctrl-d:preview-page-down' --bind='ctrl-u:preview-page-up' --no-sort --border --prompt='Ripgrep> ' `
    --ansi `
    --color="bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672" `
    --bind="ctrl-/:toggle-preview" `
    --preview-window="110" `
    --delimiter=':' `
    --bind="start:reload:$RG_PREFIX {q}" `
    --bind="change:reload:$RG_PREFIX {q} || true" `
    --preview='bat --color=always --plain {1} --highlight-line {2}' `
    --layout=reverse `
    --margin 2 `
  }
  Export-ModuleMember MyFzf, MyRg
}
