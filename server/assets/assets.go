package assets

import "github.com/GeertJohan/go.rice"

type Asset struct {
	*rice.Box
}

func LoadAssets() *Asset {
	return &Asset{rice.MustFindBox("../../client/dist")}
}

func LoadTemplates() *Asset {
	return &Asset{rice.MustFindBox("../templates/files")}
}
