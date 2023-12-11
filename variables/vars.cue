package variables

import (
	"github.com/perses/perses/dac:prometheusVarsBuilder"
)

let ds = "promDemo"
let m = "up"
let i = prometheusVarsBuilder.input & [
	{pluginKind: "PrometheusPromQLVariable", datasourceName: ds, metric: m, label: "country"},
	{pluginKind: "PrometheusPromQLVariable", datasourceName: ds, metric: m, label: "region", allowMultiple: true},
	{kind: "TextVariable", label: "size", value: "large", constant: true},
	{pluginKind: "PrometheusLabelValuesVariable", datasourceName: ds, metric: m, label: "city", allowAllValue: true, allowMultiple: true},
]

prometheusVarsBuilder & {input: i}
