# Villa Serena — Interactive Property Studio

A static web app that lets prospective buyers **explore the potential of a property by clicking on surfaces in interior renderings and swapping the materials** — floors, walls, accent panels, furniture, fittings. Built to help listings sell themselves through an interactive experience rather than static photos.

## What it does

* Browse six curated spaces (Living Pavilion, Kitchen, Master Suite, Principal Bathroom, Study, Terrace)
* Click any surface in the rendering — a zone highlights and the curated material library opens in the side panel
* Preview 30+ curated finishes (oak, walnut, travertine, Calacatta marble, limewashed paints, linens, velvets, leathers, unlacquered brass)
* Toggle between **Design view** (with applied materials) and **Original** view
* Build a saved selection set, request a quote, schedule a viewing

## Stack

* Vanilla HTML / CSS / JavaScript — no build step
* Google Fonts (Cormorant Garamond, Inter, JetBrains Mono)
* SVG + CSS-clip-path zones overlaid on full-bleed photography
* CSS background-pattern textures with multiply-blend so finishes sit naturally on the photo
* LocalStorage for saved configurations
* Print-to-PDF for selection summary export

## Deploy

This is a fully static site. Drop it on any host.

### Option A — GitHub Pages (one command)

```bash
./deploy.sh
```

The script creates the repo `interior-material-studio` on your account and pushes the contents to `gh-pages`. Pages auto-publishes.

### Option B — Manual

```bash
git init
git add .
git commit -m "Initial commit: interactive property studio"
gh repo create interior-material-studio --public --source=. --remote=origin --push
# Then on github.com → Settings → Pages → Source: gh-pages branch → Save
```

### Option C — Drag-and-drop

Zip the folder and drag the contents into a new GitHub repo via the web upload, then enable Pages.

## File map

```
index.html               ← the entire app
assets/rooms/room1-6.jpg ← the six renderings
README.md                ← this file
deploy.sh                ← one-shot GitHub Pages deploy
```

## Replacing the renderings

Drop replacement JPGs into `assets/rooms/` keeping the filenames. To remap the clickable zones, edit the `zones` array for the room in the `<script>` block of `index.html` — each zone is a `clip-path: polygon(...)` defined as percentages of the image so it works at any size.

## License

Imagery and copy are property illustrations for demonstration purposes.
