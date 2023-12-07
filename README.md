# poc-perses-dac

POC of dashboard-as-code with Perses

# Setup

How to setup a repo similar to this one to do DaC with Perses.

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

## 3. Add the plugins schemas

Currently there is no way to get these via proper dependency management, although this is being worked on by the CUE maintainers (see https://github.com/cue-lang/cue/discussions/2330).

Thus, for the moment, you have to copy the [`schemas`](https://github.com/perses/perses/tree/main/schemas) folder of the perses repo & paste it into `./cue.mod/usr/github.com/perses/perses` (create this folder path manually).

The schemas available in this poc repo correspond to the revision `3b1e341` of the perses repo.

/!\ some manual changes were done here too, but should be backported to the Perses repo at some point.

# Develop

Create your panels, dashboards etc.. based on the example provided in this repo.

With the provided example, in order to validate & build the final output of all the dashboards, you should run:
```
cue eval dashboards/* --out yaml
```

The end result of the CUE definitions available in this repo can be visualized with the `output.yaml` file:

To regenerate this file, simply run:
```
cue eval dashboards/* --out yaml > output.yaml
```

This file should be regenerated after any change done to the CUE defs, in order to have it always in sync & reflecting the current state of the schemas.

# TODO
- links between dashboards
- reusable options
- complexify variables:
  - decouple the generic varsBuilder from prometheus & provide prometheus helper as "plugin lib"
  - manage the case where a variable should not "chain" to previous ones