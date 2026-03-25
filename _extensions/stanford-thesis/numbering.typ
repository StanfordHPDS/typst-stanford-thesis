#let equation-numbering = it => {
  let chapter = counter(heading).get().first()
  if state("in-appendix").get() == true {
    numbering("(A.1)", chapter, it)
  } else {
    numbering("(1.1)", chapter, it)
  }
}

#let callout-numbering = it => {
  let chapter = counter(heading).get().first()
  if state("in-appendix").get() == true {
    numbering("A.1", chapter, it)
  } else {
    numbering("1.1", chapter, it)
  }
}

#let subfloat-numbering(n-super, subfloat-idx) = {
  let chapter = counter(heading).get().first()
  if state("in-appendix").get() == true {
    numbering("A.1a", chapter, n-super, subfloat-idx)
  } else {
    numbering("1.1a", chapter, n-super, subfloat-idx)
  }
}

#let theorem-inherited-levels = 1

#let theorem-numbering(loc) = { "1.1" }

#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(width: 100%, inset: (left: 1em), stroke: (left: 2pt + black))[
    #if full-title != "" and full-title != auto and full-title != none {
      strong[#full-title]
      linebreak()
    }
    #body
  ]
}
