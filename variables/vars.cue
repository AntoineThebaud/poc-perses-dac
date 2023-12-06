package variables

import (
	"github.com/perses/perses/dac:varsBuilder"
)

#kind: "PrometheusPromQLVariable"
#ds: "promDemo"
#metric: "up"

#myInput: varsBuilder.#input & [
	{
		kind: #kind
		datasource: name: #ds
		metric: #metric
		label: "country"
	},
	{
		kind: #kind
		datasource: name: #ds
		metric: #metric
		label: "region"
		allowMultiple: true
	},
	{
		kind: #kind
		datasource: name: #ds
		metric: #metric
		label: "city"
		allowAllValue: true
		allowMultiple: true
	}
]

#builder: varsBuilder & { #input: #myInput }