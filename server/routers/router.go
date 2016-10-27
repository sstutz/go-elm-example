package routers

import (
	"net/http"

	"github.com/gorilla/mux"
	"github.com/sstutz/go-elm-example/server/assets"
	"github.com/sstutz/go-elm-example/server/routers/handlers"
)

type Router struct {
	*mux.Router
}

func ListenAndServe() {
	R := &Router{mux.NewRouter()}

	R.Get("/", handlers.Welcome)

	fs := http.FileServer(assets.LoadAssets().Http())

	R.PathPrefix("/static/").Handler(http.StripPrefix("/static/", fs))

	http.ListenAndServe(":3000", R)
}

func (r *Router) Get(path string, f func(http.ResponseWriter, *http.Request)) *mux.Route {
	return r.NewRoute().Methods("GET").Path(path).HandlerFunc(f)
}
