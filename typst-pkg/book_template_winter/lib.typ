#let em = $dash.em$

#import "@local/katypst:0.1.0": *
#import "@preview/wordometer:0.1.5": *


#let book_template(
  book_name: "default name",
  author: "Winter",
  title_font: fonts.computer,
  font: fonts.mono,
  body,
) = {
  set text(
    lang: "fr",
    hyphenate: false,
    font: font,
    size: 12pt,
  )

  set page(margin: 3cm, paper: "a4")
  set par(justify: true)
  set list(marker: $dash$)

  set outline(depth: 2)
  set outline.entry(fill: line(length: 100%, stroke: 0.2pt))
  show outline.entry.where(level: 1): set block(above: 1.6em)
  show outline.entry.where(level: 1): it => {
    strong(it)
  }


  show link: body => text(underline(body), fill: color.blue)
  show: word-count

  present(show_outline: true, do_pagebreak: false)[
  ][
    #text(2.5em, font: title_font, book_name)

    #text(2em, author)
  ][
  ]
  line(length: 100%)
  [#h(3em)#total-words mots]

  align(bottom, text(0.5em)[
    © 2025 #author. Distribué sous licence
    #link("https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr")[
      Creative Commons Attribution – Pas d’Utilisation Commerciale – Partage
      dans les Mêmes Conditions 4.0 International
    ]
  ])

  set heading(numbering: "1.a")
  show heading: body => {
    pagebreak()
    v(3em)
    align(center, text(1.1em, [
      #counter(heading).display(body.numbering):
      #underline(body.body, stroke: 0.5pt)
    ]))
    v(3em)
  }

  set page(numbering: "1/1")
  counter(page).update(1)

  body
}

