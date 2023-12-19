package v1

import (
	"github.com/perses/perses/pkg/model/api/v1/common"
	"github.com/perses/perses/pkg/model/api/v1/dashboard"
)

#PanelDisplay: {
	name:         string @go(Name)
	description?: string @go(Description)
}

#Panel: {
	kind: "Panel"
}

#DashboardSpec: {
	display?:         common.#Display           @go(Display)
	datasources?:     [string]: #DatasourceSpec @go(Datasources)
	variables?:       [...dashboard.#Variable]  @go(Variables,[]Variable)
	panels:           [string]: #Panel          @go(Panels)
	layouts:          [...dashboard.#Layout]    @go(Layouts,[]Layout)
	duration:         _ | *"1h"                 @go(Duration)        // TODO def should come from github.com/prometheus/common/model 
	refreshInterval?: _                         @go(RefreshInterval) // TODO def should come from github.com/prometheus/common/model
}

#Dashboard: {
	kind:     #KindDashboard   @go(Kind)
	metadata: #ProjectMetadata @go(Metadata)
	spec:     #DashboardSpec   @go(Spec)
}
