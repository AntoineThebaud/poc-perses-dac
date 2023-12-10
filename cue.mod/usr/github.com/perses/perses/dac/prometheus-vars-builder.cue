// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package prometheusVarsBuilder

import (
	"strings"
	promQLVar "github.com/perses/perses/schemas/variables/prometheus-promql:model"
	"github.com/perses/perses/dac:varsBuilder"
)

// expected user input
input: [...#listInputItem | #textInputItem]
#listInputItem: {
	varsBuilder.#listInputItem
    name: string | *label // map name to label by default
	metric: string
	label: string
}
#textInputItem: {
	varsBuilder.#textInputItem
    name: string | *label // map name to label by default
	metric: "placeholder" // not-used value, just to have loop working
	label: string
}

// outputs
matchers: [ for k, _ in input {
	strings.Join([for k2, var in input if k2 < k {"\(var.label)=\"$\(var.label)\""}], ",")
}]

fullMatcher: strings.Join([for var in input {"\(var.label)=\"$\(var.label)\""}], ",")

exprs: [for k, v in input {
	"group by (" + v.label + ") (" + v.metric + "{" + matchers[k] + "})"
}]

let alias = input
variables: {varsBuilder & { input: alias }}.variables & [ for id, var in input {
    spec: [ // switch
        if var.kind == "ListVariable" {
            plugin: promQLVar & {
                spec: {
                    datasource: kind: "PrometheusDatasource"
                    expr: exprs[id]
                    labelName: var.label
                }
            }
        },
        {}
    ][0]
}]