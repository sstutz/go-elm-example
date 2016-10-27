package helpers

var (
	Version string
	Build   string
)

type Release struct {
	Version, Build string
}

func ReleaseInformation() *Release {
	return &Release{Version, Build}
}
