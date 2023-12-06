// Run `cue vet` or `cue eval` to validate that the provided cuelang payload is correct

package pkg

import (
	"github.com/perses/perses/pkg/model/api/v1"
	"github.com/perses/perses/schemas/common"
)

d: v1.#Dashboard

c: common.#calculation