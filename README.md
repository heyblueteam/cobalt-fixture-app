# cobalt-fixture-app

Trivial public app used as a deploy target by cobalt's CLI test plan.
Tiny alpine image, a `nc` "HTTP server" on port 3000, a `worker`
service for testing service-scoped commands, and a `data` volume.

If you're not running cobalt's test plan, you can ignore this repo.
