package template

import (
	"github.com/GeertJohan/go.rice"
	"html/template"
)

func Load(name string) (t *template.Template, err error) {
	var tmpl string

	if tmpl, err = rice.MustFindBox("files").String(name); err != nil {
		return nil, err
	}

	if t, err = template.New(name).Parse(tmpl); err != nil {
		return nil, err
	}

	return t, nil

}
