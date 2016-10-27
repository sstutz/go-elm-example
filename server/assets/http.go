package assets

import "net/http"

type HTTPAsset struct {
	*Asset
}

func (a *Asset) Http() *HTTPAsset {
	return &HTTPAsset{a}
}

func (h *HTTPAsset) Open(name string) (http.File, error) {
	return h.Asset.Open(name)
}
