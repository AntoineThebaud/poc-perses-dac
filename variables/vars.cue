package variables

import (
	"github.com/perses/perses/dac:varsBuilder"
)

#ds: "promDemo"
#metric: "up"

#myInput: varsBuilder.#input & [
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: #ds, metric: #metric, label: "country" },
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: #ds, metric: #metric, label: "region", allowMultiple: true },
	{ kind: "TextVariable", label: "size", value: "large", constant: true },
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: #ds, metric: #metric, label: "city", allowAllValue: true, allowMultiple: true }
]

varsBuilder & { #input: #myInput }