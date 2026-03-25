$-- When {#refs} div is present, the Lua filter injects #bibliography() at that
$-- location and sets suppress-bibliography to prevent this partial from emitting
$-- a duplicate call. Without {#refs}, this partial renders the bibliography
$-- normally at the end of the document.
$if(citations)$
$if(csl)$

#set bibliography(style: "$csl$")
$elseif(bibliographystyle)$

#set bibliography(style: "$bibliographystyle$")
$endif$
$if(bibliography)$
$if(suppress-bibliography)$
$-- Bibliography already rendered inline by {#refs} div — do nothing
$else$

#bibliography(($for(bibliography)$"$bibliography$"$sep$,$endfor$))
$endif$
$endif$
$endif$
