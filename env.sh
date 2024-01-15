set -e
#pnpm add -g pnpm
pnpm add -D vitepress
pnpm i vite-plugin-vitepress-auto-sidebar
pnpm i vitepress-plugin-comment-with-giscus
pnpm add -D busuanzi.pure.js
pnpm add -D markdown-it-mathjax3
pnpm i @mermaid-js/mermaid-mindmap@9.3.0 mermaid@9.1.0 vitepress-plugin-mermaid@2.0.10
pnpm medium-zoom