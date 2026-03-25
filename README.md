# Stanford Thesis Template for Typst and Quarto

A template for Stanford PhD dissertations and theses, available as both a pure Typst template and a Quarto custom format. Based on the official [Stanford formatting requirements](https://studentservices.stanford.edu/my-academics/earn-my-degree/graduate-degree-progress/dissertations-and-theses/prepare-your-work-0) and the [suthesis-2e.sty](https://web.stanford.edu/~emma/suthesis/suthesis-template.tex) LaTeX template.

> **Disclaimer**: The Office of the University Registrar does not endorse or verify the accuracy of any dissertation or thesis formatting templates. Always check your output against the [current requirements](https://studentservices.stanford.edu/my-academics/earn-my-degree/graduate-degree-progress/dissertations-and-theses/prepare-your-work-0) before submitting.

## Quarto Usage

### Installing

```bash
quarto use template StanfordHPDS/typst-stanford-thesis
```

This will install the format extension and create a Quarto Book project with example chapter files that you can use as a starting place for your dissertation.

### Setup

The template uses a [Quarto Book](https://quarto.org/docs/books/) project. Thesis metadata goes in `_quarto.yml`:

```yaml
project:
  type: book

book:
  title: "Your Dissertation Title"
  author:
    - name: Your Name
  chapters:
    - index.qmd
    - chapters/chapter-2.qmd
    - chapters/chapter-3.qmd

bibliography: references.bib

department: Your Department
degree: Doctor of Philosophy
department-prefix: "Department of"
submission-month: June
submission-year: "2026"
abstract: |
  Your abstract text here.
acknowledgments: |
  Your acknowledgments here.
dedication: |
  *To someone special.*
show-toc: true
show-lof: true
show-lot: true

format:
  stanford-thesis-typst: default
```

Each chapter is its own `.qmd` file. Add or remove chapter files and update the `chapters:` list in `_quarto.yml` to match.

Render with:

```bash
quarto render
```

### YAML Options

| Option | Default | Description |
|--------|---------|-------------|
| `title` | (required) | Dissertation title |
| `author` | (required) | Author name |
| `department` | (required) | Department or program name |
| `degree` | `"Doctor of Philosophy"` | Degree name |
| `department-prefix` | `"Department of"` | Use `"Program in"` or `"Committee on"` as needed |
| `submission-month` | — | Month of submission to the Registrar |
| `submission-year` | — | Year of submission |
| `abstract` | — | Abstract text |
| `acknowledgments` | — | Acknowledgments text |
| `dedication` | — | Dedication text (centered on its own page) |
| `preface` | — | Preface text |
| `show-toc` | `true` | Show table of contents |
| `show-lof` | `true` | Show list of figures |
| `show-lot` | `true` | Show list of tables |
| `section-numbering` | `"1.1"` | Heading numbering format |

### Fonts

The template defaults to Times New Roman (with Libertinus Serif as fallback). See the [Stanford formatting requirements](https://studentservices.stanford.edu/my-academics/earn-my-degree/graduate-degree-progress/dissertations-and-theses/prepare-your-work-0) for the full list of acceptable fonts.

Override via the standard Quarto `mainfont` option:

```yaml
format:
  stanford-thesis-typst:
    mainfont: "New Computer Modern"
```

## Pure Typst Usage

You can also use the template directly with Typst, without Quarto. See `sample-thesis/` for a complete example.

```typst
#import "stanford-thesis.typ": thesis

#show: thesis.with(
  title: "Your Dissertation Title",
  author: "Your Name",
  department: "Your Department",
  degree: "Doctor of Philosophy",
  submission-month: "June",
  submission-year: "2026",
  abstract: [
    Your abstract here.
  ],
  acknowledgments: [
    Your acknowledgments here.
  ],
)

= Introduction

Your content here.

#bibliography("your-references.bib")
```

Compile with:

```bash
typst compile sample-thesis/main.typ --root .
```

The `--root .` flag is needed so Typst can access `stanford-thesis.typ` from the project root.
