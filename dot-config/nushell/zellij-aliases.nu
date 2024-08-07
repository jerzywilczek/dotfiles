def zr [...command: string] {
  zellij run --name $"($command)" -- nu -e ...$command
}

def zrf [...command: string] {
  zellij run --name $"($command)" --floating -- nu -e ...$command
}

def zri [...command: string] {
  zellij run --name $"($command)" --in-place -- nu -c ...$command
}

def ze [file: path] {
  zellij edit $file
}

def zef [file: path] {
  zellij edit --floating $file
}

def zei [file: path] {
  zellij edit --in-place $file
}

def zpipe [plugin?: string] {
  if ($plugin == null) {
    zellij pipe
  } else {
    zellij pipe -p $plugin
  }
}

def zws [folder?: path] {
    if ($folder == null) {
        zellij action new-tab --layout workspace
    } else {
        zellij action new-tab --layout workspace --cwd $folder
    }
}
