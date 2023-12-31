// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	panelBuilder "github.com/perses/perses/builder:prometheusPanel"
	panelGroupBuilder "github.com/perses/perses/builder:panelGroup"
	varsBuilder "github.com/perses/perses/builder:prometheusVars"
	timeseriesChart "github.com/perses/perses/schemas/panels/time-series:model"
	promQuery "github.com/perses/perses/schemas/queries/prometheus:model"
)

#myVarsBuilder: varsBuilder & {input: [
	{pluginKind: "PrometheusLabelValuesVariable", datasourceName: "promDemo", name: "PaaS", metric: "thanos_build_info", label: "stack"},
	{kind: "TextVariable", label: "prometheus", value: "platform", constant: true},
	{kind: "TextVariable", label: "prometheus_namespace", value: "observability", constant: true},
	{pluginKind: "PrometheusPromQLVariable", datasourceName: "promDemo", metric: "kube_namespace_labels", label: "namespace", allowMultiple: true},
	{pluginKind: "PrometheusLabelNamesVariable", datasourceName: "promDemo", metric: "kube_namespace_labels", name: "namespace_labels"},
	{pluginKind: "PrometheusPromQLVariable", datasourceName: "promDemo", metric: "kube_pod_info", label: "pod", allowAllValue: true, allowMultiple: true},
	{pluginKind: "PrometheusPromQLVariable", datasourceName: "promDemo", metric: "kube_pod_container_info", label: "container", allowAllValue: true, allowMultiple: true},
	{pluginKind: "PrometheusLabelNamesVariable", datasourceName: "promDemo", metric: "kube_pod_container_info", name: "container_labels"},
]}

#myPanels: {
	"memory": this=panelBuilder & {
		#filter: #myVarsBuilder.fullMatcher
		#clause: "by"
		#clauseLabels: ["container"]

		spec: {
			display: name: "Container Memory"
			plugin: timeseriesChart
			queries: [
				{
					kind: "TimeSeriesQuery"
					spec: plugin: promQuery & {
						spec: query: "max \(this.#aggr) (container_memory_rss{\(this.#filter)})"
					}
				},
			]
		}
	}
	"cpu": this=panelBuilder & {
		#filter: #myVarsBuilder.fullMatcher
		spec: {
			display: name: "Container CPU"
			plugin: timeseriesChart
			queries: [
				{
					kind: "TimeSeriesQuery"
					spec: plugin: promQuery & {
						spec: query: "sum \(this.#aggr) (container_cpu_usage_seconds{\(this.#filter)})"
					}
				},
			]
		}
	}
}

"singleFileDashboard": v1.#Dashboard & {
	metadata: {
		name:    "Containers monitoring"
		project: "My project"
	}
	spec: {
		panels:    #myPanels
		variables: #myVarsBuilder.variables
		layouts: [
			panelGroupBuilder & {#panels: #myPanels, #title: "Resource usage", #cols: 3},
		]
	}
}
