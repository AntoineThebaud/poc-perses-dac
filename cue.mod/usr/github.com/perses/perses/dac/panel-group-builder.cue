// "fake" perses lib created for the purpose of this POC
// If proven relevant, should be considered added to the Perses native schemas

package panelGroupBuilder

import (
	"math"
	"github.com/perses/perses/pkg/model/api/v1"
	v1Dashboard "github.com/perses/perses/pkg/model/api/v1/dashboard"
)

// expected user inputs
#panels: [string]: v1.#Panel
#title: string
#cols: >0 & <=#gridCols
#height: number | *6

// intermediary compute magic
#gridCols: 24
#panelsAsList: [for k, p in #panels {p, name: k}]
#width: math.Trunc(#gridCols / #cols)
#panelsX: [for i, _ in #panelsAsList {
    #width * math.Round(math.Mod(i, #cols))
}]
#panelsY: [for i, _ in #panelsAsList {
    #height * math.Trunc(i / #cols)
}]

// final output
v1Dashboard.#Layout & {
    spec: v1Dashboard.#GridLayoutSpec & {
        display: title: #title
        items: [for i, panel in #panelsAsList {
            x: #panelsX[i],
            y: #panelsY[i],
            width: #width,
            height: #height,
            content: {
                "$ref": "#/spec/panels/\(panel.name)"
            }
        }]
    }
}