// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package varsBuilder

import (
	"strings"
	v1Dashboard "github.com/perses/perses/pkg/model/api/v1/dashboard"
	v1Variable "github.com/perses/perses/pkg/model/api/v1/variable"
)

#input: [...{
    kind: string
    datasource: name: string
    metric: string
    label: string
    allowAllValue: bool | *false
    allowMultiple: bool | *false
}]

#matchers: [ for k, _ in #input {
	strings.Join([for k2, var in #input if k2 < k {"\(var.label)=\"$\(var.label)\""}], ",")
}]

#fullMatcher: strings.Join([for var in #input {"\(var.label)=\"$\(var.label)\""}], ",")

#exprs: [for k, v in #input {
	"group by (" + v.label + ") (" + v.metric + "{" + #matchers[k] + "})"
}]

#variables: [...v1Dashboard.#Variable] & [ for id, var in #input {
	kind: v1Variable.#KindList
	spec: v1Dashboard.#ListVariableSpec & {
		name: var.label
		allowAllValue: var.allowAllValue
		allowMultiple: var.allowMultiple
		plugin: {
			kind: var.kind
			spec: {
				datasource: name: var.datasource.name
				expr: #exprs[id]
				labelName: var.label
			}
		}
	}
}]