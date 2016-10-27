package commands

import (
	"net/http"

	"github.com/GeertJohan/go.rice"
	"github.com/spf13/cobra"
	"github.com/sstutz/go-elm-example/server/template"
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
	http.HandleFunc("/", welcome)
	fs := http.FileServer(rice.MustFindBox("../../client/dist").HTTPBox())
	http.Handle("/static/", http.StripPrefix("/static/", fs))
	http.ListenAndServe(":3000", nil)
}

func welcome(w http.ResponseWriter, r *http.Request) {
	t, _ := template.Load("elm.html")
	release := Release{Version, Build}
	t.Execute(w, release)
}