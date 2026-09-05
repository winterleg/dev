#let colors = (
  title: eastern,
  headers: maroon,
  partfill: rgb("#002299"),
  label: red,
  hyperlink: blue,
  strong: rgb("#000055"),
)

#let conf-remove-cjk-breaks(doc) = {
  import "@preview/cjk-unbreak:0.2.1": remove-cjk-break-space
  show: remove-cjk-break-space

  doc
}

#let conf_academic(
  fonts: "New Computer Modern",
  math_fonts: "New Computer Modern Math",
  font_size: 10pt,
  doc,
) = {
  set heading(numbering: "1.1")
  set list(marker: [---])
  set page(columns: 2, numbering: "1/1", number-align: left, margin: 0.7in)
  set par(justify: true)
  set text(lang: "fr", font: fonts, size: font_size)
  set math.mat(delim: "[")
  set list(marker: $dash.em$)

  import "@preview/headcount:0.1.0": *
  show heading: reset-counter(counter(math.equation), levels: 2)
  show math.equation: set text(font: math_fonts)
  show link: body => text(
    underline(body),
    fill: color.blue,
    font: link_font,
  )

  set outline(depth: 2)
  show outline.entry.where(level: 1): set block(above: 1.6em)
  show outline.entry.where(level: 1): it => {
    strong(it)
  }

  doc
}

#let conf(
  fonts: ("Noto Serif", "Noto Serif CJK JP"),
  math_fonts: ("New Computer Modern Math", "Fira Math"),
  link_font: "Noto Serif",
  font_size: 12pt,
  page_numbering: "1/1",
  maketitle: false,
  doc,
) = {
  set heading(numbering: "1.")
  set list(marker: $dash.em$)
  set page(numbering: page_numbering, number-align: left)
  set par(justify: true)
  set text(lang: "fr", font: fonts, size: font_size)
  set math.mat(delim: "[")
  set list(marker: $dash.em$)
  set list(indent: 1em)
  set enum(indent: 1em)

  import "@preview/headcount:0.1.0": *
  show heading: reset-counter(counter(math.equation), levels: 2)
  show math.equation: set text(font: math_fonts)
  show link: body => text(
    underline(body),
    fill: color.blue,
    font: link_font,
  )

  doc
}
