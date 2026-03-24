// Stanford PhD Dissertation Template for Quarto/Typst
// Based on requirements from Stanford Student Services and suthesis-2e.sty

#let thesis(
  // Required parameters
  title: none,
  author: none,
  department: none,

  // Optional parameters with defaults
  degree: "Doctor of Philosophy",
  department-prefix: "Department of",
  submission-month: none,
  submission-year: none,

  // Typography options
  font-size: 12pt,
  font-family: ("Times New Roman", "Libertinus Serif"),
  spacing: 1.3,

  // Optional content
  abstract: none,
  dedication: none,
  acknowledgments: none,
  preface: none,
  abbreviations: none,

  // Lists
  show-toc: true,
  show-lof: true,
  show-lot: true,

  // Section numbering
  section-numbering: "1.1",

  // Document body
  body,
) = {
  // ── Page setup ──
  set page(
    paper: "us-letter",
    margin: (
      inside: 1.5in,
      outside: 1in,
      top: 1in,
      bottom: 1in,
    ),
  )

  // ── Typography ──
  set text(
    font: font-family,
    size: font-size,
    fill: black,
    lang: "en",
    hyphenate: true,
  )

  set par(
    leading: spacing * 0.65em,
    justify: true,
  )

  set document(
    title: title,
    author: author,
  )

  // ── Heading styles ──
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.5in)
    if it.numbering != none {
      text(size: 1.2em, weight: "bold",
        "Chapter " + counter(heading).display(it.numbering)
      )
      v(0.15in)
    }
    text(size: 1.4em, weight: "bold", it.body)
    v(0.3in)
  }

  show heading.where(level: 2): it => {
    v(0.3in)
    text(size: 1.2em, weight: "bold", {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.5em)
      }
      it.body
    })
    v(0.15in)
  }

  show heading.where(level: 3): it => {
    v(0.2in)
    text(size: 1.1em, weight: "bold", {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.5em)
      }
      it.body
    })
    v(0.1in)
  }

  // ════════════════════════════════════════════════════
  // TITLE PAGE
  // ════════════════════════════════════════════════════

  set page(numbering: none)

  {
    set text(hyphenate: false)
    v(1in)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      upper(title),
    ))

    v(1fr)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      {
        upper("A Dissertation") + linebreak()
        upper("Submitted to the " + department-prefix + " " + department) + linebreak()
        upper("and the Committee on Graduate Studies") + linebreak()
        upper("of Stanford University") + linebreak()
        upper("in Partial Fulfillment of the Requirements") + linebreak()
        upper("for the Degree of") + linebreak()
        upper(degree)
      }
    ))

    v(1fr)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      {
        upper(author) + linebreak()
        if submission-month != none and submission-year != none {
          upper(submission-month + " " + submission-year)
        }
      }
    ))

    v(0.5in)
  }

  // ════════════════════════════════════════════════════
  // PRELIMINARY PAGES
  // ════════════════════════════════════════════════════

  set page(numbering: "i")
  counter(page).update(4)

  if abstract != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Abstract")
    abstract
  }

  if preface != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Preface")
    preface
  }

  if acknowledgments != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Acknowledgments")
    acknowledgments
  }

  if dedication != none {
    pagebreak(weak: true)
    v(1fr)
    align(center, dedication)
    v(1fr)
  }

  if show-toc {
    pagebreak(weak: true)
    outline(
      title: "Contents",
      depth: 3,
      indent: auto,
    )
  }

  if show-lot {
    pagebreak(weak: true)
    outline(
      title: "List of Tables",
      target: figure.where(kind: table).or(figure.where(kind: "quarto-float-tbl")),
    )
  }

  if show-lof {
    pagebreak(weak: true)
    outline(
      title: "List of Figures",
      target: figure.where(kind: image).or(figure.where(kind: "quarto-float-fig")),
    )
  }

  if abbreviations != none {
    pagebreak(weak: true)
    align(center, text(size: 1.4em, weight: "bold", "List of Abbreviations"))
    v(0.3in)
    abbreviations
  }

  // ════════════════════════════════════════════════════
  // MAIN BODY
  // ════════════════════════════════════════════════════

  set page(numbering: "1")
  counter(page).update(1)
  set page(
    number-align: center + bottom,
    header: context {
      // No header on pages where a level-1 heading starts
      let here-page = counter(page).at(here())
      let ch-starts = query(heading.where(level: 1))
        .filter(h => counter(page).at(h.location()) == here-page)
      if ch-starts.len() > 0 { return }

      let elems = query(selector(heading.where(level: 1)).before(here()))
      if elems.len() > 0 {
        let current = elems.last()
        set text(size: 0.9em)
        emph({
          if current.numbering != none {
            [Chapter ]
            numbering(current.numbering, ..counter(heading).at(current.location()))
            [. ]
          }
          current.body
        })
        h(1fr)
        counter(page).display()
      }
    },
  )

  set heading(numbering: section-numbering)

  set figure(placement: auto)
  show figure: set block(breakable: false)
  show figure.caption: it => {
    set text(size: 0.95em)
    it
  }

  set bibliography(style: "apa")
  show bibliography: it => {
    pagebreak(weak: true)
    it
  }

  body
}
