# tex-vscode

A LaTeX manuscript template for VS Code: a draft paper (`main.tex`) built on a small custom
style (`simple_draft.sty`), plus a Dev Container so no local TeX installation is needed.

## What is in the repo

| Path | Purpose |
| --- | --- |
| `main.tex` | The document. Placeholder title, authors, affiliations, abstract, sections, a table, a figure and a bibliography. |
| `simple_draft.sty` | Style used by `main.tex`: letter paper with 1in margins, Times, `authblk` authors/affiliations, IEEE-style `biblatex` bibliography (biber backend), `tabularray` tables, and a few helper commands (see below). |
| `references.bib` | Bibliography loaded by `simple_draft.sty` via `\addbibresource{references.bib}`. |
| `.vscode/settings.json` | LaTeX Workshop settings: build on save, output to `build/`, PDF in a tab, and the build recipes listed below. |
| `.devcontainer/` | Dev Container based on `danteev/texlive`, with `arxiv-latex-cleaner` and `pdflinkchecker-cli` installed. A copy of [a-nau/latex-devcontainer](https://github.com/a-nau/latex-devcontainer) (MIT, see `.devcontainer/LICENSE` and `.devcontainer/readme.md`). |

### Helper commands in `simple_draft.sty`

- `\correspondingauthor[affils]{Name}{email}` – an author marked as corresponding, with the email shown under the affiliations.
- `\author[affils]{Name}` / `\affil[n]{Text}` – from `authblk`.
- `\enablelinenumbers` – line numbers from the abstract onwards (handy for review).
- `\firstpagefootnote{Text}` – a footnote in the first-page footer.
- `\runninghead{Text}` – a centered running header on pages after the first.

## Building

### In VS Code with the Dev Container (recommended)

1. Install [VS Code](https://code.visualstudio.com/), [Docker](https://docs.docker.com/get-docker/) and the
   `ms-vscode-remote.remote-containers` extension.
2. Open this folder and run **Dev Containers: Rebuild and Reopen Container** (`F1`).
3. Open `main.tex`. LaTeX Workshop builds on save; the PDF ends up in `build/main.pdf` and opens in a tab.

Recipes available from the LaTeX Workshop menu (`.vscode/settings.json`):

- `latexmk` – default; runs biber automatically, so citations resolve.
- `pdflatex -> bibtex -> pdflatex * 2` – note the bibliography uses biblatex with the biber backend, so this
  recipe will not resolve citations; use `latexmk`.
- `bibtex`
- `link-checker` – runs `pdflinkchecker` over the folder.
- `prepare arxiv` – runs `.devcontainer/misc/prepare_arxiv.sh`, which cleans the sources with
  `arxiv_latex_cleaner` (config in `.devcontainer/misc/cleaner_config.yaml`) into `arxiv/` and zips them
  to `arxiv.zip`.

### From the command line

With a TeX Live installation that includes `latexmk` and `biber`:

```sh
latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error --shell-escape -outdir=build main.tex
```

## Caveats

- `.devcontainer/misc/initialize.sh` (run after the container is created) tries to copy CI files from
  `.devcontainer/ci/`, which is not part of this repo; the copy fails harmlessly and no CI config is created.
- The Dev Container disables SSL verification for Git and Node (`devcontainer.json`); the Docker build
  also refreshes CA certificates. Adjust if you do not need that.
- `.vscode/settings.json` points `ltex.java.path` at an ARM64 OpenJDK path; on x64 use the
  `/usr/lib/jvm/default-java` value from `.devcontainer/settings.json`.
- `build/`, `arxiv/` and `arxiv.zip` are generated and ignored by Git.
