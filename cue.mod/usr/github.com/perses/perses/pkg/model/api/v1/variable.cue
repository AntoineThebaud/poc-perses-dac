package v1

import "github.com/perses/perses/pkg/model/api/v1/variable"

#VariableSpec: {
	kind: variable.#Kind @go(Kind)
	spec: _              @go(Spec)
}