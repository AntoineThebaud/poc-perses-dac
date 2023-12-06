package panels

import (
	"github.com/perses/perses/pkg/model/api/v1"
	barChart "github.com/perses/perses/schemas/panels/bar:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#cpuUsage: v1.#Panel & {
	#metric: string

	spec: {
		display: name: "CPU Usage",
		plugin: barChart
		queries: [
			{
				kind: "TimeSeriesQuery" // TODO lacking validation here
				spec: plugin: promQuery & {
					spec: query: "\(#metric){node=\"$node\",job=\"system\"}"
				}
			}
		]
	}
}