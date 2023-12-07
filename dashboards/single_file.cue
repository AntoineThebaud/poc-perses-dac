// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	"github.com/perses/perses/dac:panelBuilder"
	"github.com/perses/perses/dac:panelGroupBuilder"
	"github.com/perses/perses/dac:varsBuilder"
	timeseriesChart "github.com/perses/perses/schemas/panels/time-series:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#myVarsBuilder: varsBuilder & { #input: [
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "thanos_build_info"
		label: "stack"
	},
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "kube_namespace_labels"
		label: "namespace"
		allowMultiple: true
	},
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "kube_pod_info"
		label: "pod"
		allowAllValue: true
		allowMultiple: true
	},
	{
		kind: "PrometheusPromQLVariable"
		datasource: name: "promDemo"
		metric: "kube_pod_container_info"
		label: "container"
		allowAllValue: true
		allowMultiple: true
	}
]}

#myPanels: {
	"memory": this=panelBuilder & {
        #filter: #myVarsBuilder.#fullMatcher
        #clause: "by"
        #clauseLabels: ["container"]

        spec: {
            display: name: "Container Memory",
            plugin: timeseriesChart
            queries: [
                {
                    kind: "TimeSeriesQuery"
                    spec: plugin: promQuery & {
                        spec: query: "max \(this.#aggr) (container_memory_rss{\(#filter)})"
                    }
                }
            ]
        }
    },
	"cpu": this=panelBuilder & {
        #filter: #myVarsBuilder.#fullMatcher
        spec: {
            display: name: "Container CPU",
            plugin: timeseriesChart
            queries: [
                {
                    kind: "TimeSeriesQuery"
                    spec: plugin: promQuery & {
                        spec: query: "sum \(this.#aggr) (container_cpu_usage_seconds{\(#filter)})"
                    }
                }
            ]
        }
    }
}

"singleFileDashboard": v1.#Dashboard & {
	metadata: {
		name: "Containers monitoring"
		project: "My project"
	}
	spec: {
		panels: #myPanels
		variables: #myVarsBuilder.#variables
		layouts: [
			panelGroupBuilder & { #panels: #myPanels, #title: "Resource usage", #cols: 3 }
		]
	}
}