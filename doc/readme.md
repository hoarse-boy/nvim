install md2vim.

```sh
go install git.foosoft.net/alex/md2vim@latest
```

## usage

convert markdown to vim help file.

```sh
md2vim jho_vim_notes.md jho_vim_notes.txt
```

## manual editing

edit the converted file if markdown snippet is used. it will generated empty file type in txt version.

```vim
>{add filetype here}
  package main

  import (
    "fmt"
    "os"
  )

  func main() {
    fmt.Println("hello world")
    os.Exit(0)
  }
>
```

