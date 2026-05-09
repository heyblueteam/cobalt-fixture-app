# cobalt-fixture-app

Public test fixture used by cobalt's CLI test plan and end-to-end
test suite (`cobalt/e2e/`).

`main` is a tiny nginx image listening on `:3000` plus a `worker`
service for testing service-scoped commands, plus a `data` volume.

## Branches

Each branch is a deliberately-shaped variant for a specific test
scenario. Tests deploy from `<repo>#<branch>` and assert the
behavior unique to that branch.

| Branch         | Behavior                                                            | Used by scenario                                |
|----------------|---------------------------------------------------------------------|-------------------------------------------------|
| `main`         | Normal app: nginx serves immediately on port 3000                   | primary deploy, redirects, cascade, base flows  |
| `slow-startup` | Sleeps 30s before nginx accepts connections                         | healthcheck-patience scenario                   |
| `crash-loop`   | Web container `exit 1`s on start; deploy must fail without dropping the previous serving container | failed-deploy / rollback safety scenario |

## Adding a scenario

  1. Branch from `main` (`git checkout -b <slug> --no-track main`).
  2. Modify `Dockerfile` / `cobalt.json` / `index.html` to encode
     the deliberate shape.
  3. Update the table above.
  4. Push the branch — no PR needed; e2e tests reference the branch
     name directly.

If you're not running cobalt's tests, you can ignore this repo.
