package handlers

import (
	"net/http"

	"github.com/sstutz/go-elm-example/server/helpers"
	"github.com/sstutz/go-elm-example/server/templates"
)

func Welcome(w http.ResponseWriter, r *http.Request) {
	t, _ := templates.Load("elm.html")
	release := helpers.ReleaseInformation()
	t.Execute(w, release)
}
