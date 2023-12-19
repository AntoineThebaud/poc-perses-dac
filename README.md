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

## 2. Add the CUE definitions patches

Because the Perses datamodel doesnt fully get translated into CUE by the above `cue get` command, some patches are required (more context about this [here](./cue.mod/usr/github.com/perses/perses/pkg/README.md))
You can copy the [./cue.mod/usr/github.com/perses/perses/pkg](./cue.mod/usr/github.com/perses/perses/pkg) folder from this repo & paste it in the same place in yours to get all the patches.

## 3. Add the plugins schemas

Currently there is no way to get these via proper dependency management, although this is being worked on by the CUE maintainers (see https://github.com/cue-lang/cue/discussions/2330).

Thus, for the moment, you have to copy the [`schemas`](https://github.com/perses/perses/tree/main/schemas) folder of the perses repo & paste it into `./cue.mod/usr/github.com/perses/perses` (create this folder path manually).

The schemas available in this poc repo correspond to the revision `3b1e341` of the perses repo.

/!\ some manual changes were done here too, but should be backported to the Perses repo at some point.

## 4. Add the dashboard builder utilities

To make the development of Perses dashboards as code easier, you can copy the [`./cue.mod/usr/github.com/perses/perses/builder`](./cue.mod/usr/github.com/perses/perses/builder) folder from this repo & paste it in the same place in yours to get some useful utilities.

# Develop

Create your panels, dashboards etc.. based on the examples provided in this repo.

With the provided examples, in order to validate & build the final output of all the dashboards, you should run:
```
cue eval dashboards/* --out yaml
```

# Contribute

The end result of the CUE definitions available in this repo can be visualized with the `output.yaml` file:

To regenerate this file, simply run:
```
cue eval dashboards/* --out yaml > output.yaml
```

This file should be regenerated after any change done to the CUE defs, in order to have it always in sync & reflecting the current state of the schemas.

# TODO
- links between dashboards (/!\ depends on https://github.com/perses/perses/issues/1642 implem)
- reusable options