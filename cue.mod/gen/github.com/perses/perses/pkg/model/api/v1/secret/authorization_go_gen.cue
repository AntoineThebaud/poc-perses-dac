// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/perses/perses/pkg/model/api/v1/secret

package secret

// PublicAuthorization is the public struct of Authorization.
// It's used when the API returns a response to a request
#PublicAuthorization: {
	type:             string  @go(Type)
	credentials?:     #Hidden @go(Credentials)
	credentialsFile?: string  @go(CredentialsFile)
}

// Authorization contains HTTP authorization credentials.
#Authorization: _
