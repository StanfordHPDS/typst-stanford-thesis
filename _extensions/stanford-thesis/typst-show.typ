#show: doc => thesis(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
  author: "$for(by-author/first)$$it.name.literal$$endfor$",
$endif$
$if(department)$
  department: "$department$",
$endif$
$if(degree)$
  degree: "$degree$",
$endif$
$if(department-prefix)$
  department-prefix: "$department-prefix$",
$endif$
$if(submission-month)$
  submission-month: "$submission-month$",
$endif$
$if(submission-year)$
  submission-year: "$submission-year$",
$endif$
$if(fontsize)$
  font-size: $fontsize$,
$endif$
$if(mainfont)$
  font-family: ("$mainfont$",),
$endif$
$if(spacing)$
  spacing: $spacing$,
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(dedication)$
  dedication: [$dedication$],
$endif$
$if(acknowledgments)$
  acknowledgments: [$acknowledgments$],
$endif$
$if(preface)$
  preface: [$preface$],
$endif$
$if(abbreviations)$
  abbreviations: [$abbreviations$],
$endif$
  show-toc: $show-toc$,
  show-lof: $show-lof$,
  show-lot: $show-lot$,
$if(section-numbering)$
  section-numbering: "$section-numbering$",
$endif$
$if(chapter-prefix)$
  chapter-prefix: "$chapter-prefix$",
$endif$
$if(appendix-prefix)$
  appendix-prefix: "$appendix-prefix$",
$endif$
  doc,
)
