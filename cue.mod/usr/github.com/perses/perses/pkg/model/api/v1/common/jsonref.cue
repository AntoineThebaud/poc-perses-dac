package common

#JSONRef: {
	// Ref is the JSON reference. That's the only thing that is used during the marshalling / unmarshalling process.
	// Other attributes are ignored during these processes.
	$ref: string @go(Ref)
}