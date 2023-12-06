package variables

import (
	"strings"
	v1Dashboard "github.com/perses/perses/pkg/model/api/v1/dashboard"
	v1Variable "github.com/perses/perses/pkg/model/api/v1/variable"
)


#variablesInput: [
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "up"
		label: "country"
		allowAllValue: false
		allowMultiple: false
	},
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "up"
		label: "region"
		allowAllValue: false
		allowMultiple: true
	},
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "up"
		label: "city"
		allowAllValue: true
		allowMultiple: true
	}
]

#matchers: [ for k, _ in #variablesInput {
	strings.Join([for k2, var in #variablesInput if k2 < k {"\(var.label)=\"$\(var.label)\""}], ",")
}]

#exprs: [for k, v in #variablesInput {
	"group by (" + v.label + ") (" + v.metric + "{" + #matchers[k] + "})"
}]

#variables: [...v1Dashboard.#Variable] & [ for id, var in #variablesInput {
	kind: v1Variable.#KindList
	spec: v1Dashboard.#ListVariableSpec & {
		name: var.label
		allowAllValue: var.allowAllValue
		allowMultiple: var.allowMultiple
		plugin: {
			kind: "PrometheusPromQLVariable"
			spec: {
				datasource: name: var.datasource.name
				expr: #exprs[id]
				labelName: var.label
			}
		}
	}
}]