# go language vscode style snippet notes

> use the note below to create snippet. current neovim uses non comment json, so the go.md is created

```
	/* //? copy below and use '' only. as go doesnt often use '' only when using rune. paste it inside "body" like example below
    [
      ' type PaymentMethod struct {',
      '	Id uuid.UUID `json:"id" gorm:"primaryKey;<-:create;column:Id"`',
      '}',
    ]
  */
	//? 1. remember to update the body above using ''
	//? 2. copy above and use this web to fast convert https://transform.tools/js-object-to-json
	//? 3. copy the converted json to this snippet below

	//? notes: wrap each line of code using both single quote and comma like this '', in go file first

	// Place your snippets for go here. Each snippet is defined under a snippet name and has a prefix, body and
	// description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	// $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the
	// same ids are connected.
	// Example of using snippet laber and others
	/* 
    "method store": {
      "prefix": "-method store",
      "body": ["func (s Store) ${1:method}($2) $3 {", "  $4", "}"],
      "description": "method store"
	},  */
	// Example:
	// "commandD3timesTo_change_it": {
	// 	"prefix": "-commandD3timesTo_change_it",
	// 	"body": [],
	// 	"description": "commandD3timesTo_change_it"
	// },
```
