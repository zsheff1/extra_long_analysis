# Extra Long Analysis

Exploratory analyses of neuroimaging, clinical, cognitive, and environmental data from the Philadelphia Neurodevelopmental Cohort (PNC), with a focus on cortical gyrification and its relationships with neurodevelopment and psychopathology.

The project uses R and [Quarto](https://quarto.org/) to yield reproducible statistical analyses, visualizations, and reports.

## Research Overview

The primary neuroimaging measure is the **Local Gyrification Index (LGI)**, a measure of cortical folding derived from FreeSurfer surface reconstructions. Analyses examine global, lobar, and regional LGI in relation to:

- **Brain structure:** Cortical volume and estimated total intracranial volume (eTIV).
- **Psychopathology:** Clinical factor scores, psychosis-spectrum symptoms, and categorical psychiatric measures.
- **Cognition:** Overall cognitive performance and domain-specific cognitive abilities.
- **Demographics and environment:** Age, sex, socioeconomic status (SES), and trauma exposure.
- **Interactions:** Potential moderation of LGI associations by demographic and environmental characteristics.

Analyses include correlations, group comparisons, linear regression, generalized additive models (GAMs), and exploratory factor analysis.

## Reports

[View Published Reports](https://zsheff1.github.io/extra_long_reports/)

Rendered reports are published separately through GitHub Pages. The analysis is maintained in a single Quarto document, `lgi.qmd`, which supports two rendering profiles:

| Profile | Description |
|---|---|
| `scratch` | Detailed exploratory report, including analysis code and intermediate results. |
| `presentation` | Presentation-oriented report with code hidden. |

## Repository Structure

```text
extra_long_analysis/
├── R/
│   ├── mapping.R
│   ├── plotting.R
│   └── reporting.R
├── lgi.qmd
├── _quarto.yml
├── _quarto-scratch.yml
├── _quarto-presentation.yml
├── references.bib
└── biological-psychiatry.csl
```

- **`lgi.qmd`** — Main analysis document, containing data preparation, statistical analyses, visualizations, and results.
- **`R/`** — Supporting functions for variable mapping, plotting, and statistical reporting.
- **`_quarto*.yml`** — Quarto project configuration and rendering profiles.
- **`references.bib`** — Bibliography maintained through Zotero and Better BibTeX.
- **`biological-psychiatry.csl`** — Citation formatting for *Biological Psychiatry*.

## Reproducibility

Analyses are written in R.

To render the reports:

```bash
quarto render lgi.qmd --profile scratch
quarto render lgi.qmd --profile presentation
```

The project currently relies on curated datasets and additional data sources stored on `bblrepo1.pmacs.upenn.edu`. Input paths and the report output directory are configured for that environment.

Consequently, the repository documents the analytical workflow but is not independently executable without access to the required datasets and a compatible R environment.

## Project Management

- [GitHub Issues](https://github.com/zsheff1/extra_long_analysis/issues) — Research tasks, methodological questions, and planned improvements.
- [Project Wiki](https://github.com/zsheff1/extra_long_analysis/wiki) — Meeting minutes, research discussions, and supporting documentation.
- [Published Reports](https://zsheff1.github.io/extra_long_reports/) — Rendered exploratory analyses, statistical results, and visualizations.
