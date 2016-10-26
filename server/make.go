package main

import (
	"net/http"
	"os"

	"github.com/GeertJohan/go.rice"
	"github.com/sstutz/go-elm-example/server/template"
)

var (
	Version string
	Build   string
	cwd, _  = os.Getwd()
)

type Release struct {
	Version, Build string
}

func main() {
	serv()
}

func serv() {
	http.HandleFunc("/", welcome)
	fs := http.FileServer(rice.MustFindBox("../client/dist").HTTPBox())
	http.Handle("/static/", http.StripPrefix("/static/", fs))
	http.ListenAndServe(":3000", nil)
}

func welcome(w http.ResponseWriter, r *http.Request) {
	t, _ := template.Load("elm.html")
	release := Release{Version, Build}
	t.Execute(w, release)
}
