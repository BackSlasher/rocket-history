# Rocket Alert History Viewer

A client-side web app for visualizing Israeli rocket alert history data.

## Usage

```bash
make update    # Fetch missing day files (past 30 days) and update index.html
make serve     # Start local server at http://localhost:8000
```

## Features

- **Views**: Daily line chart, hourly bar chart, or heatmap (days × hours)
- **Multi-region comparison**: Select multiple regions to overlay on charts; heatmap shows diagonal split cells for 2 regions
- **10-minute grouping**: Alerts within 10 min for same location = single event (one shelter visit)
- **Day/night shading**: Visual indicator for night hours (00:00-06:00, 18:00-24:00)
- **URL state**: Selected regions, view type, and time range persisted in query string

## Data

- Source: [oref-map.org](https://oref-map.org) day-history API (proxies פיקוד העורף data)
- Stored as `docs/day-YYYY-MM-DD.json` files
- Only includes "ירי רקטות וטילים" and "חדירת כלי טיס עוין" categories
- alertDate timestamps are in Israel time (parsed as strings to avoid TZ conversion issues)

## Structure

```
├── Makefile           # fetch-data, update-index, serve
├── README.md
└── docs/              # GitHub Pages root
    ├── index.html     # Single-page app
    ├── favicon.svg
    └── day-*.json     # Alert data by day
```

## Technical Notes

- Pure client-side (no build step)
- Chart.js + chartjs-plugin-annotation for visualization
- alertDate strings parsed directly (not via Date object) to avoid UTC timezone shifts
