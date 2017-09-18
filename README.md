# Lightstep Tracer API - Public

To update either `src/lightstep/collector/collector.proto|lightstep_carrier.proto`, make the change in https://github.com/lightstep/lightstep-tracer-common and then, update using git `subtree`

Update subtree:

```
git subtree pull --prefix src/lightstep/collector git@github.com:lightstep/lightstep-tracer-common.git master --squash
```
