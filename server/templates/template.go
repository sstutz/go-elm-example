package templates

import (
	"html/template"

	"github.com/sstutz/go-elm-example/server/assets"
)

func Load(name string) (t *template.Template, err error) {
	var tmpl string

	if tmpl, err = assets.LoadTemplates().String(name); err != nil {
		return nil, err
	}

	if t, err = template.New(name).Parse(tmpl); err != nil {
		return nil, err
	}

	return t, nil

}
