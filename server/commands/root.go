package commands

import "github.com/spf13/cobra"

var RootCmd = &cobra.Command{
	Use:   "example",
	Short: "example",
	Long:  "Long description of example",
}
