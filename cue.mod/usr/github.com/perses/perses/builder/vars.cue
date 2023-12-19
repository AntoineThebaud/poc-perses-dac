// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package vars

import (
	v1Dashboard "github.com/perses/perses/pkg/model/api/v1/dashboard"
)

// expected user input
input: [...#listInputItem | #textInputItem]
#listInputItem: {
	kind: "ListVariable"
	name: string
	pluginKind: string
	datasourceName: string
	allowAllValue: bool | *false
	allowMultiple: bool | *false
	...
}
#textInputItem: {
	kind: "TextVariable"
	name: string
	value: string
	constant: bool | *false
	...
}

// outputs
variables: [...v1Dashboard.#Variable] & [ for id, var in input {
	kind: var.kind
	spec: [ // switch
		if var.kind == "ListVariable" {
			v1Dashboard.#ListVariableSpec & {
				name: var.name
				allowAllValue: var.allowAllValue
				allowMultiple: var.allowMultiple
				plugin: {
					kind: var.pluginKind
					spec: {
						datasource: name: var.datasourceName
					}
				}
			}
		},
		if var.kind == "TextVariable" {
			v1Dashboard.#TextVariableSpec & {
				name: var.name
				value: var.value
				constant: var.constant
			}
		},
	][0]
}]