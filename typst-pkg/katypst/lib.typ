#import "source/clues.typ"
#import "source/meth.typ"
#import "source/config.typ"
#import "source/theorems.typ"

#let em = $dash.em$
#let deg = [°]

#let fonts = (
  serif: ("Noto Serif", "Noto Serif CJK JP"),
  sans: ("Noto Sans", "Noto Sans CJK JP"),
  mono: "IosevkaTerm NFM",
  computer: "New Computer Modern",
  zenmaru: "Zen Maru Gothic",
  raleway: "Raleway",
  fmath: "Fira Math",
  cmath: "New Computer Modern Math",
  courier: "Courier New",
  angular: "Monaspace Krypton NF",
)

#let present(
  top_content,
  middle_content,
  bottom_content,
  show_outline: true,
  do_pagebreak: true,
) = {
  align(center, {
    align(top, top_content)
    align(horizon, middle_content)
    align(bottom, bottom_content)
  })
  if show_outline {
    pagebreak()
    outline()
  }
  if do_pagebreak {
    pagebreak()
  }
}

#let tens(value, exponent) = {
  $
    value times 10^(exponent)
  $
}

#let inter = {
  set par.line(numbering: none)
  linebreak()
  align(center, line(length: 90%))
  linebreak()
}




#let present_math(
  font: "Courier Prime",
  fontm: "New Computer Modern Math",
  font_size: 10pt,
  hyphenate: false,
  numbering_enum: "(a)",
  body,
) = {
  set text(lang: "fr")
  set text(font: font)
  set text(size: font_size, hyphenate: hyphenate)
  set enum(numbering: numbering_enum)
  show math.equation: set text(font: fontm)
  show math.equation: set text(font: fontm)

  let space = h(1em)
  let meter = [m]
  let cmeter = [cm]
  let mmeter = [cm]
  let kmeter = [km]
  let volt = [V]
  let µvolt = [µV]
  let nvolt = [nV]
  let coulomb = [C]
  let µcoulomb = [µC]
  let ncoulomb = [nC]
  let newton = [N]
  let farrad = [F]
  let epso = $epsilon_(0)$
  let voltmeter = [V/m]
  let num = [\#]
  let space = h(1em)
  let para = $\/\/$
  let slash = [/]
  let qed = align(right, $square.filled$)

  let dream(body) = block(width: 100%, body)
  let tens(body, exp) = $body#strong(scale(x: 75%, y: 75%, "E"))^exp$
  let paragraph(body) = {
    strong(body)
    h(1em)
  }
  let ans(body) = {
    align(center, block(
      width: 90%,
      align(left, body),
    ))
  }
  body
}
