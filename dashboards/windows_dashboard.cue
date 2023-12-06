// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	//"github.com/perses/perses/schemas/common"
	myPanels "github.com/AntoineThebaud/poc-perses-dac/panels"
)

"windowsDashboard": v1.#Dashboard & {
	metadata: {
		name: "My Windows Dashboard"
		project: "My project"
	}
	spec: {
		panels: {
			"cpuUsage": myPanels.#cpuUsage & {#metric: "wmi_cpu"},
			"ramUsage": myPanels.#ramUsage & {#metric: "wmi_ram"},
		}
	}
}