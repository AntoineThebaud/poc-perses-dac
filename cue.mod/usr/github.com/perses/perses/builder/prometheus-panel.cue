// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package prometheusPanel

import (
	"strings"
	"github.com/perses/perses/pkg/model/api/v1"
)


// expected user inputs
#clause: "by" | "without" | *""
#clauseLabels: [...string] | *[]

// outputs
#aggr: string | *""
if #clause != "" {
    #aggr: """
    \(#clause) (\(strings.Join(#clauseLabels, ",")))
    """
}

#filter: string

v1.#Panel