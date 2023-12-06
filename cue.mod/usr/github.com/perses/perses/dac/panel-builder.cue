// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package panelBuilder

import (
	"strings"
	"github.com/perses/perses/pkg/model/api/v1"
)

v1.#Panel & {
    #clause: "by" | "without" | *""
    #clauseLabels: [...string] | *[]

    #builtClause: string | *""
    if #clause != "" {
        #builtClause: """
        \(#clause) (\(strings.Join(#clauseLabels, ",")))
        """
    }
}