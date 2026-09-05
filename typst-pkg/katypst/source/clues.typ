#import "@preview/gentle-clues:1.2.0": *

#let problem(..args) = clue(
  accent-color: _get-accent-color-for("experiment"),
  icon: _get-icon-for("experiment"),
  title: "Problem",
  ..args,
)
#let exercise(..args) = clue(
  accent-color: _get-accent-color-for("experiment"),
  icon: _get-icon-for("experiment"),
  title: "Exercise",
  ..args,
)
#let sample(..args) = clue(
  accent-color: _get-accent-color-for("success"),
  icon: _get-icon-for("experiment"),
  title: "Sample Question",
  ..args,
)
#let solution(..args) = clue(
  accent-color: _get-accent-color-for("conclusion"),
  icon: _get-icon-for("conclusion"),
  title: "Solution",
  ..args,
)
#let remark(..args) = clue(
  accent-color: _get-accent-color-for("info"),
  icon: _get-icon-for("info"),
  title: "Remark",
  ..args,
)
#let definition(..args) = clue(
  accent-color: _get-accent-color-for("abstract"),
  icon: _get-icon-for("abstract"),
  title: "Definition",
  ..args,
)
#let proof(..args) = clue(
  accent-color: _get-accent-color-for("abstract"),
  icon: _get-icon-for("abstract"),
  title: "Definition",
  ..args,
)


