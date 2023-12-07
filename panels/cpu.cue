package panels

import (
	"github.com/perses/perses/dac:panelBuilder"
	barChart "github.com/perses/perses/schemas/panels/bar:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#cpuUsage: this=panelBuilder & {
	#os: *"linux" | "windows"

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
					spec: query: "sum \(this.#aggr) (\(#metric){\(this.#filter)})"
				}
			}
		]
	}
}