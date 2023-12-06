package panels

import (
	"strings"
	"github.com/perses/perses/pkg/model/api/v1"
	timeseriesChart "github.com/perses/perses/schemas/panels/time-series:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#ramUsage: v1.#Panel & {
	#os: *"linux" | "windows"
	#filter: string
	#clause: "by" | "without" | *""
	#clauseLabels: [...string] | *[]
	#builtClause: string | *""
	if #clause != "" {
		#builtClause: """
		\(#clause) (\(strings.Join(#clauseLabels, ",")))
		"""
	}

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
					spec: query: "sum \(#builtClause) (\(#metric){\(#filter)})"
				}
			}
		]
	}
}