// /!\ manually added file

package variable

import "github.com/perses/perses/pkg/model/api/v1/common"

#TextSpec: {
	display?:  #Display @go(Display)
	value:     string   @go(Value)
	constant?: string   @go(Constant)
}