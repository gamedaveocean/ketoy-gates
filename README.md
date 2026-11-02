# ketoy-gates — signed Ketoy gate bundles (OTA gate links)

Public CDN for the Ed25519-signed `.ktx` gate bundles of the mobile app batch.

Each app fetches exactly one file:

```
https://gamedaveocean.github.io/ketoy-gates/<slug>/main.ktx
```

The bundle carries the **gate link and the gate mode**, so changing what an
installed app does on launch is a one-file push here — no Play Store release, no
reinstall:

| `<slug>/main.ktx` built with | what every installed copy of that app does |
|---|---|
| `GATE_URL = ""` + `GATE_MODE = "none"` | shows the native app, no gate (delivered state) |
| `GATE_URL = "<link>"` + `GATE_MODE = "custom_tab"` | opens the link in a Chrome Custom Tab; closing it reveals the native app |
| `GATE_MODE = "custom_tab_reopen"` | sticky: closing the tab re-opens it |
| `GATE_MODE = "browser"` | hands the link to the system browser |

## Updating a link

```bash
cd C:/Users/1/orca/_ketoy_flutter_gate
python publish_bundle.py --slug <slug> --pkg <applicationId> --name "<App name>" \
    --gate-url "<new link>" --gate-mode custom_tab
bash sync_to_host.sh <slug>          # copies ota/<slug>/main.ktx here, commits, pushes
```

Devices pick the new bundle up on their next launch. GitHub Pages serves with
`Cache-Control: max-age=600`, so allow ~10 minutes for the CDN to hand out the
new copy (the app sends `If-None-Match` and keeps the last good bundle in the
meantime).

Bundles are signed with the batch Ed25519 key; an APK only accepts a bundle whose
signature matches the 32-byte public key shipped inside it. Rollback = push the
previous `.ktx` back.
