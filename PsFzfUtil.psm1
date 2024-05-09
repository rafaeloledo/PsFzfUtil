Add-Type -AssemblyName System.Windows.Forms
New-Module -ScriptBlock {
  $DEFAULT_EDITOR = 'v'
  $RG_PREFIX="rg --column --no-heading --color=always --smart-case"
  function MyFzf {
    $p = [System.Diagnostics.Process]@{StartInfo = @{
      FileName = "fzf";
      Arguments = @(
        "--layout=reverse",
        "--height=100%",
        "--border=`"rounded`"",
        "--no-sort",
        "--preview-window=`"wrap`"",
        "--prompt=`"Search Directory> `""
        "--bind=`"ctrl-d:preview-page-down`"",
        "--bind=`"ctrl-u:preview-page-up`"",
        "--preview=`"bat --plain --color=always {}`"",
        "--preview-window=`"55%`"",
        "--preview-window=`"border-rounded`"",
        "--color=`"bg+:#202224,border:#424947,spinner:#E6DB74,hl:#7E8E91,fg:#6ccfef,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#a6a8aa,prompt:#F92672,hl+:#F92671`""
      );
      RedirectStandardOutput = $true;
      WorkingDirectory = $PWD;
    }}

    $p.Start()
    $result = $p.StandardOutput.ReadLine()
    $p.WaitForExit()

    if ($result -ne $null) {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($DEFAULT_EDITOR) `'$($result)`'")
      [Microsoft.PowerShell.PSConsoleReadLine]::ClearScreen()
      [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    }
  }

  function MyRg {
    $DEFAULT_EDITOR = 'v'
    $p = [System.Diagnostics.Process]@{StartInfo = @{
      FileName = "fzf";
      Arguments = @(
        "--layout=reverse",
        "--height=100%",
        "--preview-window=`"wrap`"",
        "--border",
        "--no-sort",
        "--delimiter=`":`"",
        "--disabled",
        "--ansi",
        "--prompt=`"Ripgrep> `"",
        "--bind=`"ctrl-d:preview-page-down`"",
        "--bind=`"ctrl-u:preview-page-up`"",
        "--preview-window=`"60%`"",
        "--color=`"bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92671`"",
        "--preview=`"bat --plain --color=always {1} --highlight-line {2}`"",
        "--bind=`"start:reload:$RG_PREFIX {q}`"",
        "--bind=`"change:reload:$RG_PREFIX {q} || true`""
      );
      RedirectStandardOutput = $true;
      WorkingDirectory = $PWD;
    }}

    $p.Start()
    $result = $p.StandardOutput.ReadLine()
    $file = ($result -split ":", 2)[0]
    $line = ((($result -split ":", 2)[1]) -split ":", 2)[0]
    $p.WaitForExit()

    if ($result -ne $null) {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($DEFAULT_EDITOR) `'$($file)`' +$line")
      [Microsoft.PowerShell.PSConsoleReadLine]::ClearScreen()
      [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    }
  }
  Export-ModuleMember MyFzf, MyRg
}
