package main

import (
	"os"

	"github.com/sstutz/go-elm-example/server/commands"
)

var (
	cwd, _ = os.Getwd()
)

func main() {
	commands.RootCmd.Execute()
}
