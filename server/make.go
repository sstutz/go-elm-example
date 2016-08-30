package main

import (
	"html/template"
	"net/http"
	"os"
	"path/filepath"
)

var (
	Version string
	Build   string
	cwd, _  = os.Getwd()
	assets  = filepath.Join(cwd, "public")
)

type Release struct {
	Version, Build string
}

func main() {
	serv()
}

func serv() {
	http.HandleFunc("/", welcome)

	fs := http.FileServer(http.Dir(assets))
	http.Handle("/static/", http.StripPrefix("/static/", fs))
	http.ListenAndServe(":3000", nil)
}

func welcome(w http.ResponseWriter, r *http.Request) {
	layout := filepath.Join(cwd, "templates/elm.html")
	t, _ := template.ParseFiles(layout)

	release := Release{Version, Build}

	t.Execute(w, release)
}
