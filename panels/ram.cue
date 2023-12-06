package panels

import (
	"github.com/perses/perses/pkg/model/api/v1"
	timeseriesChart "github.com/perses/perses/schemas/panels/time-series:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#ramUsage: v1.#Panel & {
	#os: *"linux" | "windows"
	#filter: string

	#metric: [ // switch
		if #os == "windows" {
			"wmi_ram"
		},
		"node_memory_usage"
	][0]

	spec: {
		display: name: "My Timeseries Panel",
		plugin: timeseriesChart
		queries: [
			{
				kind: "TimeSeriesQuery" // TODO lacking validation here
				spec: plugin: promQuery & {
					spec: query: "\(#metric){\(#filter)}"
				}
			}
		]
	}
}