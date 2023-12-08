package variables

import (
	"github.com/perses/perses/dac:prometheusVarsBuilder"
)

let ds = "promDemo"
let m  = "up"
let i = prometheusVarsBuilder.input & [
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: ds, name: label, metric: m, label: "country" },
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: ds, name: label, metric: m, label: "region", allowMultiple: true },
	{ kind: "TextVariable", name: label, label: "size", value: "large", constant: true },
	{ pluginKind: "PrometheusPromQLVariable", datasourceName: ds, metric: m, name: label, label: "city", allowAllValue: true, allowMultiple: true }
]

prometheusVarsBuilder & { input: i }