package commands

import (
	"github.com/spf13/cobra"
	"github.com/sstutz/go-elm-example/server/routers"
)

var serveCmd = &cobra.Command{
	Use:   "serve",
	Short: "Starts the application server",
	Long:  "Starts the application server on a given port",
	Run:   serve,
}

type Release struct {
	Version, Build string
}

func init() {
	RootCmd.AddCommand(serveCmd)
}

func serve(cmd *cobra.Command, args []string) {

	routers.ListenAndServe()
}
