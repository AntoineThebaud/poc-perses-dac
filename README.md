# poc-perses-dac

POC of dashboard-as-code with Perses

# Setup done

## 1. Init repo + import Perses model as CUE definitions

```bash
cue mod init github.com/AntoineThebaud/poc-perses-dac
go mod init github.com/AntoineThebaud/poc-perses-dac
go get github.com/perses/perses/pkg/model/api/v1
cue get go github.com/perses/perses/pkg/model/api/v1
```

-> /!\ Current issue: model not fully imported, top-value instead of proper def in any place where custom UnmarshallJSON is used on Perses side. See https://github.com/cue-lang/cue/issues/2466.