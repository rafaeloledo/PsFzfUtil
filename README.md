## TODO

> make this module generic and support multiple parameters
> currently it's wrapping my personal fzf commands

## Usage
`Import-Module PsFzfUtil`

> Use the function members

```sh
Set-PSReadLineKeyHandler -Chord "Ctrl+o" -ScriptBlock { MyFzf }
Set-PSReadLineKeyHandler -Chord "Ctrl+r" -ScriptBlock { MyRg  }
```

## Current members

`MyFzf` -> call fzf with predefined configurations
`MyRg` -> call fzf-ripgrep with predefined configurantions

> You can fork this project and adapt the member functions to suit your preferences.

## Installing

```
$path = $env:USERPROFILE\Documents\PowerShell\Modules
git clone https://github.com/rafaeloledo/PsFzfUtil.git <path>
```

