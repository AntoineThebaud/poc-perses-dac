// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	myPanels "github.com/AntoineThebaud/poc-perses-dac/panels"
	myVars "github.com/AntoineThebaud/poc-perses-dac/variables"
	"github.com/perses/perses/dac:panelGroupBuilder"
)

#winPanels: {
	"cpuUsage": myPanels.#cpuUsage & {#os: "windows", #filter: myVars.fullMatcher}
	"ramUsage": myPanels.#ramUsage & {#os: "windows", #filter: myVars.fullMatcher, #clause: "without", #clauseLabels: ["country, region"]}
}

"windowsDashboard": v1.#Dashboard & {
	metadata: {
		name:    "My Windows Dashboard"
		project: "My project"
	}
	spec: {
		panels:    #winPanels
		variables: myVars.variables
		layouts: [
			panelGroupBuilder & {#panels: #winPanels, #title: "My panel group", #cols: 3, #height: 12},
		]
	}
}
