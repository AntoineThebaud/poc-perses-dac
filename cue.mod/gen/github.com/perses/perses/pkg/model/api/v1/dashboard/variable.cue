// /!\ manually added file

package dashboard

import "github.com/perses/perses/pkg/model/api/v1/variable"

#TextVariableSpec: {
    name: string @go(Name)
    variable.#TextSpec
}

#ListVariableSpec: {
    name: string @go(Name)
    variable.#ListSpec
}

#Variable: {
	kind:  variable.#Kind                        @go(Kind)
	spec?: #TextVariableSpec | #ListVariableSpec @go(Spec)
}
