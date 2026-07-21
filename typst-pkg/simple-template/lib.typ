#let simple-template(body) = {
	let font = ("New Computer Modern Mono", "Noto Serif CJK JP")
	let size = 10pt
	set text(font: font, size: size)
	set page(
		footer: context [
			#if counter(page).final().first() > 1 {
				align(right, counter(page).display("1"))
			}
		],
	)
	show raw: set text(font: font)
	show raw: it => block(fill: luma(90%), width: 100%, inset: 5pt, it)
	show heading: set text(size: size + 2pt)
	show heading: it => {
		pad(left: 2cm, it)
		v(1em)
	}

	body
}

#let set-indent(body) = {
	set par(
		first-line-indent: (all: true, amount: 8em),
		spacing: 0.65em
	)
	body
}

#let set-italic(body) = {
	show text: it => text(style: "italic", it)
	body
}
