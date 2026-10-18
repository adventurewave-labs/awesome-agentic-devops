#!/usr/bin/env bash
# Regenerate the GitHub Pages site in docs/ from README.md.
# Run from anywhere: scripts/build-site.sh  (requires: pandoc)
# Hand-authored files (llms.txt, robots.txt, CNAME, favicon.svg, og.png) are NOT touched.
set -euo pipefail
cd "$(dirname "$0")/.."

SITE_URL="https://agentic-devops.online"
LAST_UPDATED=$(git log -1 --format=%as -- README.md)
mkdir -p docs

pandoc README.md -f gfm -t html5 --wrap=none -o docs/_body.html

cat > docs/_head.html <<'HEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Awesome Agentic DevOps — AI Agents, MCP Servers &amp; SRE Agents</title>
<meta name="description" content="Curated, link-verified map of agentic DevOps: open-source SRE agents, MCP servers, coding agents, agentic CI/CD, frameworks, protocols, and research.">
<meta name="theme-color" content="#0d9488">
<link rel="canonical" href="https://agentic-devops.online/">
<link rel="icon" type="image/svg+xml" href="/favicon.svg">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Awesome Agentic DevOps">
<meta property="og:title" content="Awesome Agentic DevOps — AI Agents, MCP Servers &amp; SRE Agents">
<meta property="og:description" content="Curated, link-verified map of agentic DevOps: open-source SRE agents, MCP servers, coding agents, agentic CI/CD, frameworks, protocols, and research.">
<meta property="og:url" content="https://agentic-devops.online/">
<meta property="og:image" content="https://agentic-devops.online/og.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Awesome Agentic DevOps — AI Agents, MCP Servers &amp; SRE Agents">
<meta name="twitter:description" content="Curated, link-verified map of agentic DevOps: open-source SRE agents, MCP servers, coding agents, agentic CI/CD, frameworks, protocols, and research.">
<meta name="twitter:image" content="https://agentic-devops.online/og.png">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "@id": "https://agentic-devops.online/#website",
      "url": "https://agentic-devops.online/",
      "name": "Awesome Agentic DevOps",
      "description": "Curated, link-verified map of agentic DevOps: open-source SRE agents, MCP servers, coding agents, agentic CI/CD, frameworks, protocols, and research.",
      "inLanguage": "en",
      "publisher": { "@id": "https://agentic-devops.online/#org" }
    },
    {
      "@type": "Organization",
      "@id": "https://agentic-devops.online/#org",
      "name": "Adventure Wave Labs",
      "url": "https://github.com/adventurewave-labs",
      "sameAs": ["https://github.com/adventurewave-labs"]
    },
    {
      "@type": "FAQPage",
      "@id": "https://agentic-devops.online/#faq",
      "mainEntity": [
        {
          "@type": "Question",
          "name": "What is agentic DevOps?",
          "acceptedAnswer": { "@type": "Answer", "text": "The shift from deterministic, script-driven DevOps to autonomous AI agents that reason, act on infrastructure, self-correct, and collaborate with humans across the software delivery lifecycle — the framing used by Microsoft, Opsera, and the open-source SRE-agent ecosystem." }
        },
        {
          "@type": "Question",
          "name": "How is agentic DevOps different from AIOps and traditional CI/CD automation?",
          "acceptedAnswer": { "@type": "Answer", "text": "Traditional CI/CD is deterministic and AIOps surfaces anomalies; agentic DevOps reasons through causes and executes remediation. Per Opsera: not traditional automation (deterministic vs. probabilistic), not just LLM code generation (no agency), and not AIOps (which lacks reasoning and remediation)." }
        },
        {
          "@type": "Question",
          "name": "Which protocols do DevOps AI agents use?",
          "acceptedAnswer": { "@type": "Answer", "text": "MCP (Model Context Protocol) is how agents use tools, A2A (Agent2Agent) is how agents collaborate, and AG-UI handles agent-to-user interaction. MCP and A2A are now under the Linux Foundation." }
        },
        {
          "@type": "Question",
          "name": "How do you run agentic DevOps safely?",
          "acceptedAnswer": { "@type": "Answer", "text": "Start read-only or in proposal mode; guard against the lethal trifecta of private data, untrusted content, and outbound access in one sandbox; gate probabilistic agents with policy-as-code; scope credentials per agent; and record every production-adjacent run." }
        }
      ]
    }
  ]
}
</script>
<style>
:root {
  --bg: #ffffff; --fg: #1e293b; --muted: #64748b; --accent: #0d9488;
  --border: #e2e8f0; --code-bg: #f1f5f9; --link: #0d9488;
}
@media (prefers-color-scheme: dark) {
  :root { --bg: #0f172a; --fg: #e2e8f0; --muted: #94a3b8; --accent: #2dd4bf;
    --border: #1e293b; --code-bg: #1e293b; --link: #2dd4bf; }
}
* { box-sizing: border-box; }
body { margin: 0; font: 16px/1.65 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: var(--bg); color: var(--fg); }
.topbar { position: sticky; top: 0; z-index: 10; display: flex; justify-content: space-between; align-items: center; padding: 10px 20px; background: var(--bg); border-bottom: 1px solid var(--border); }
.topbar .brand { font-weight: 700; color: var(--accent); text-decoration: none; font-size: 15px; }
.topbar .gh { color: var(--muted); text-decoration: none; font-size: 14px; }
main { max-width: 880px; margin: 0 auto; padding: 32px 20px 64px; }
h1 { font-size: 2rem; line-height: 1.25; margin: 8px 0 12px; }
h2 { font-size: 1.4rem; margin-top: 2.2em; padding-bottom: .3em; border-bottom: 1px solid var(--border); }
h3 { font-size: 1.1rem; margin-top: 1.6em; }
a { color: var(--link); }
h2 a, h3 a { color: inherit; text-decoration: none; }
img { max-width: 100%; height: auto; }
table { border-collapse: collapse; display: block; overflow-x: auto; max-width: 100%; }
th, td { border: 1px solid var(--border); padding: 6px 12px; text-align: left; font-size: 14px; }
th { background: var(--code-bg); }
code { background: var(--code-bg); border-radius: 4px; padding: 1px 5px; font-size: 0.9em; font-family: ui-monospace, SFMono-Regular, Menlo, monospace; }
blockquote { margin: 1em 0; padding: 4px 16px; border-left: 4px solid var(--accent); background: var(--code-bg); border-radius: 0 6px 6px 0; color: var(--fg); }
hr { border: none; border-top: 1px solid var(--border); margin: 2.5em 0; }
footer { border-top: 1px solid var(--border); color: var(--muted); font-size: 13.5px; text-align: center; padding: 24px 20px 40px; }
</style>
</head>
<body>
<nav class="topbar">
  <a class="brand" href="/">❯ agentic-devops.online</a>
  <a class="gh" href="https://github.com/adventurewave-labs/awesome-agentic-devops">GitHub ↗</a>
</nav>
<main>
HEAD

cat > docs/_foot.html <<'FOOT'
</main>
<footer>
  Maintained by <a href="https://github.com/adventurewave-labs">Adventure Wave Labs</a> ·
  <a href="https://github.com/adventurewave-labs/awesome-agentic-devops">Source &amp; contributions</a> · MIT license ·
  Every GitHub link verified 2026-10-17 · List updated: {{LAST_UPDATED}}
</footer>
</body>
</html>
FOOT

cat docs/_head.html docs/_body.html docs/_foot.html > docs/index.html
sed -i '' "s|{{LAST_UPDATED}}|$LAST_UPDATED|" docs/index.html
rm docs/_head.html docs/_body.html docs/_foot.html

cat > docs/sitemap.xml <<SITEMAP
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<url><loc>$SITE_URL/</loc><lastmod>$LAST_UPDATED</lastmod><changefreq>weekly</changefreq><priority>1.0</priority></url>
</urlset>
SITEMAP

echo "Built docs/index.html + docs/sitemap.xml (lastmod $LAST_UPDATED)"
