package commands

import (
	"fmt"

	"github.com/spf13/cobra"
)

var (
	Version    string
	Build      string
	versionCmd = &cobra.Command{
		Use:   "version",
		Short: "Print version number",
		Long:  "Prints the version number of example",
		Run:   version,
	}
)

func init() {
	RootCmd.AddCommand(versionCmd)
}

func version(cmd *cobra.Command, args []string) {
	fmt.Println(Version + " " + Build)
}
