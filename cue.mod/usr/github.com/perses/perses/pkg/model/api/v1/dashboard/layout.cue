package dashboard

import "github.com/perses/perses/pkg/model/api/v1/common"

#GridItem: {
	x:       int             @go(X)
	y:       int             @go(Y)
	width:   int             @go(Width)
	height:  int             @go(Height)
	content: common.#JSONRef @go(Content)
}

#GridLayoutCollapse: {
	open: bool @go(Open)
}

#GridLayoutDisplay: {
	title:     string              @go(Title)
	collapse?: #GridLayoutCollapse @go(Collapse)
}

#GridLayoutSpec: {
	display: #GridLayoutDisplay @go(Title)
	items?:  [...#GridItem]     @go(Items,[]GridItem)
}

#LayoutKind: "Grid"

#LayoutSpec: #GridLayoutSpec

#Layout: {
	kind: #LayoutKind @go(Kind)
    spec: #LayoutSpec @go(Spec)
}

