// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/perses/perses/pkg/model/api/v1/role

package role

#Action: _ // #enumAction

#enumAction:
	#ReadAction |
	#CreateAction |
	#UpdateAction |
	#DeleteAction |
	#WildcardAction

#ReadAction:     #Action & "read"
#CreateAction:   #Action & "create"
#UpdateAction:   #Action & "update"
#DeleteAction:   #Action & "delete"
#WildcardAction: #Action & "*"
