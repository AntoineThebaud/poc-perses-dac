# poc-perses-dac

POC of dashboard-as-code with Perses

# Setup steps

## 1. Init repo + import Perses model as CUE definitions

```bash
cue mod init github.com/AntoineThebaud/poc-perses-dac
go mod init github.com/AntoineThebaud/poc-perses-dac
go get github.com/perses/perses/pkg/model/api/v1
cue get go github.com/perses/perses/pkg/model/api/v1
```

## 2. Patch the CUE definitions

This should no longer be needed at some point hopefully, but for the moment the Perses model doesn't get fully converted to CUE defs because of a technical limitation in the CUE translation process: a top-value (= "any") gets generated instead of a proper def for any type that defines a custom UnmarshallJSON or UnmarshallYAML. See https://github.com/cue-lang/cue/issues/2466.

You can copy the [generated files](./cue.mode/gen/github.com/perses) from this repo to get all the patches.