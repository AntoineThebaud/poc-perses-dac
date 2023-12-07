package variables

import (
	"github.com/perses/perses/dac:varsBuilder"
)

#kind: "PrometheusPromQLVariable"
#ds: "promDemo"
#metric: "up"

#myInput: varsBuilder.#input & [
	{ kind: #kind, datasourceName: #ds, metric: #metric, label: "country" },
	{ kind: #kind, datasourceName: #ds, metric: #metric, label: "region", allowMultiple: true },
	{ kind: #kind, datasourceName: #ds, metric: #metric, label: "city", allowAllValue: true, allowMultiple: true }
]

varsBuilder & { #input: #myInput }