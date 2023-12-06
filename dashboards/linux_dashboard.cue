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
			"cpuUsage": myPanels.#cpuUsage & { #filter: myVars.#fullMatcher, #clause: "by", #clauseLabels: ["city"] },
			"ramUsage": myPanels.#ramUsage & { #filter: myVars.#fullMatcher },
		}
		variables: myVars.#variables
	}
}