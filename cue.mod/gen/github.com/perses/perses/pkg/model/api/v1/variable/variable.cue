// /!\ manually added file

package variable

#Kind: #KindText | #KindList

#KindText: "TextVariable"
#KindList: "ListVariable"

#Display: {
	name?:        string @go(Name)
	description?: string @go(Description)
	hidden:       bool   @go(Hidden)
}
