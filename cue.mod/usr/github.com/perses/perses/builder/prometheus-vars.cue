// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package prometheusVars

import (
	"strings"
	promQLVar "github.com/perses/perses/schemas/variables/prometheus-promql:model"
	promLabelValuesVar "github.com/perses/perses/schemas/variables/prometheus-label-values:model"
	promLabelNamesVar "github.com/perses/perses/schemas/variables/prometheus-label-names:model"
	varsBuilder "github.com/perses/perses/builder:vars"
)

// expected user input
input: #input
#input: [...#listInputItem | #textInputItem]
#listInputItem: {
	varsBuilder.#listInputItem
	name: string | *label // map name to label by default
	metric: string
	label: string
}
#textInputItem: {
	varsBuilder.#textInputItem
	name: string | *label // map name to label by default
	label: string
}

// This allows the lib users to not have to specify the main variable kind when it's a 
// ListVariable, as TextVariables have no plugin.
input: [for var in input {
	if var.pluginKind != _|_ {
		kind: "ListVariable"
	}
}]

// outputs
matchers: [for k, _ in input {
	strings.Join(
		[for k2, var in input if k2 < k if var.label != _|_ {
			"\(var.label)=\"$\(var.label)\""
		}],
		","
	)
}]

fullMatcher: strings.Join([for var in input if var.label != _|_ {"\(var.label)=\"$\(var.label)\""}], ",")

exprs: [for k, v in input {
    [ // switch
        if v.pluginKind == "PrometheusPromQLVariable" {
            "group by (" + v.label + ") (" + v.metric + "{" + matchers[k] + "})"
        },
        if v.pluginKind == "PrometheusLabelValuesVariable" || v.pluginKind == "PrometheusLabelNamesVariable" {
            v.metric + "{" + matchers[k] + "}"
        },
    ][0]
}]

let alias = input
variables: {varsBuilder & { input: alias }}.variables & [ for id, var in input {
    spec: [ // switch
        if var.kind == "ListVariable" if var.pluginKind == "PrometheusPromQLVariable" {
            plugin: promQLVar & {
                spec: {
                    datasource: kind: "PrometheusDatasource"
                    expr: exprs[id]
                    labelName: var.label
                }
            }
        },
        if var.kind == "ListVariable" if var.pluginKind == "PrometheusLabelValuesVariable" {
            plugin: promLabelValuesVar & {
                spec: {
                    datasource: kind: "PrometheusDatasource"
                    labelName: var.label
                    matchers: [exprs[id]]
                }
            }
        },
        if var.kind == "ListVariable" if var.pluginKind == "PrometheusLabelNamesVariable" {
            plugin: promLabelNamesVar & {
                spec: {
                    datasource: kind: "PrometheusDatasource"
                    matchers: [exprs[id]]
                }
            }
        },
        {}
    ][0]
}]