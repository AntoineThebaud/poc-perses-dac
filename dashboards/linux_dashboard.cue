// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	//"github.com/perses/perses/schemas/common"
	myPanels "github.com/AntoineThebaud/poc-perses-dac/panels"
	myVars "github.com/AntoineThebaud/poc-perses-dac/variables"
)

"linuxDashboard": v1.#Dashboard & {
	metadata: {
		name: "My Linux Dashboard"
		project: "My project"
	}
	spec: {
		panels: {
			"cpuUsage": myPanels.#cpuUsage & {#metric: "node_cpu_usage"},
			"ramUsage": myPanels.#ramUsage & {#metric: "node_memory_usage"},
		}
		variables: myVars.#variables
	}
}