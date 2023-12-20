package variables

import (
	varsBuilder "github.com/perses/perses/builder:prometheusVars"
)

let ds = "promDemo"
let m = "up"
let i = varsBuilder.#input & [
	{pluginKind: "PrometheusPromQLVariable", datasourceName: ds, metric: m, label: "country"},
	{pluginKind: "PrometheusLabelNamesVariable", datasourceName: ds, metric: m, name: "country labels"},
	{pluginKind: "PrometheusPromQLVariable", datasourceName: ds, metric: m, label: "region", allowMultiple: true},
	{kind: "TextVariable", label: "size", value: "large", constant: true},
	{pluginKind: "PrometheusLabelValuesVariable", datasourceName: ds, metric: m, label: "city", allowAllValue: true, allowMultiple: true},
]

varsBuilder & {input: i}
