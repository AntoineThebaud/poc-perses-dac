// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	//"github.com/perses/perses/schemas/common"
	bar "github.com/perses/perses/schemas/panels/bar:model"
	timeseries "github.com/perses/perses/schemas/panels/time-series:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#myFirstPanel: v1.#Panel & {
	spec: {
		display: name: "My Bar Panel",
		plugin: bar
		queries: [...v1.#Query] & [
			{
				kind: "TimeSeriesQuery" // TODO lacking validation here
				spec: plugin: promQuery & {
					spec: query: "vector(1)"
				}
			}
		]
	}
}

#mySecondPanel: v1.#Panel & {
	spec: {
		display: name: "My Timeseries Panel",
		plugin: timeseries
		queries: [...v1.#Query] & [
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {
					spec: query: "vector(2)"
				}
			}
		]
	}
}

// final output:
v1.#Dashboard & {
	metadata: {
		name: "My Dashboard"
		project: "My project"
	}
	spec: {
		panels: {
			"panel1": #myFirstPanel,
			"panel2": #mySecondPanel,
		}
	}
}