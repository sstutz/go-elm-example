package commands

import (
	"fmt"

	"github.com/spf13/cobra"
	"github.com/sstutz/go-elm-example/server/helpers"
)

var (
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
	release := helpers.ReleaseInformation()
	fmt.Println(release.Version + " " + release.Build)
}
