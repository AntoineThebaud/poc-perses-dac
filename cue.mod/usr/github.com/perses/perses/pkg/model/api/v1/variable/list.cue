package variable

import "github.com/perses/perses/pkg/model/api/v1/common"

#DefaultValue: {
	singleValue: string      @go(SingleValue)
	sliceValues: [...string] @go(SliceValues)
}

#Sort: "none" | "alphabetical-asc" | "alphabetical-desc" | "numerical-asc" | "numerical-desc" | "alphabetical-ci-asc" | "alphabetical-ci-desc"

#ListSpec: {
	display?: #Display @go(Display)
	// Value from the list to be selected by default.
	defaultValue?: #DefaultValue @go(DefaultValue)
	// Whether or not to append the "All" value that allows selecting all available values at once.
	allowAllValue: bool @go(AllowAllValue)
	// Whether or not to allow multi-selection of values.
	allowMultiple: bool @go(AllowMultiple)
	// CustomAllValue is a custom value that will be used if AllowAllValue is true and if then `all` is selected
	customAllValue?: string @go(CustomAllValue)
	// CapturingRegexp is the regexp used to catch and filter the result of the query.
	// If empty, then nothing is filtered. That's the equivalent of setting CapturingRegexp with (.*)
	capturingRegexp?: string @go(CapturingRegexp)
	// Sort method to apply when rendering the list of values
	sort?:  #Sort          @go(Sort)
	plugin: common.#Plugin @go(Plugin)
}