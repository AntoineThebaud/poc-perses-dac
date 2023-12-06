package panels

import (
	"github.com/perses/perses/pkg/model/api/v1"
	barChart "github.com/perses/perses/schemas/panels/bar:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#cpuUsage: v1.#Panel & {
	#os: *"linux" | "windows"
	#filter: string

	#metric: [ // switch
		if #os == "windows" {
			"wmi_cpu"
		},
		"node_cpu_usage"
	][0]

	spec: {
		display: name: "CPU Usage",
		plugin: barChart
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