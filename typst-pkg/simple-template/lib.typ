#let simple-template(body, font: "New Computer Modern", size: 10pt) = {
	set text(font: font, size: size)
	set page(
		footer: context [
			#if counter(page).final().first() > 1 {
				align(right,
					[#counter(page).display("1")/#counter(page).final().first()]
				)
			}
		],
	)
	show raw: set text(font: font)
	show raw: it => block(fill: luma(90%), width: 100%, inset: 5pt, it)
	show heading: set text(size: size + 2pt)
	show heading.where(level: 1): it => {
		v(2em)
		pad(left: 12em, it)
		v(1em)
	}
	show heading.where(level: 2): it => {
		pad(left: 10em, it)
		v(1em)
	}
	show heading.where(level: 3): it => {
		pad(left: 6em, it)
		v(1em)
	}

	body
}

#let set-indent(body, indent: 4em, spacing: 0.65em) = {
	set par(
		first-line-indent: (all: true, amount: indent),
		spacing: spacing
	)
	body
}

#let set-italic(body) = {
	show text: it => text(style: "italic", it)
	body
}
