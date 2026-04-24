#let deg = [°]
#let pfunc = $℘$

#let num = [\#]
#let s = h(1em)
#let vec(body) = $arrow(body)$
#let dream(body) = block(width: 100%, body)
#let tens(body, exp) = $body times 10^(exp)$
#let qed = align(right, $square$)

#let tens(body, exp) = $body#strong(scale(x: 75%, y: 75%, "E"))^exp$

#let para = $\/\/$
#let slash = [/]
#let graph(body) = {
  strong(body)
  h(1em)
}
#let ans(body) = {
  align(center, block(
    width: 90%,
    align(left, body),
  ))
}
#let meter = [m]
#let meterc = [cm]
#let meterm = [mm]
#let meterk = [km]
#let joule = [J]
#let volt = [V]
#let voltµ = [µV]
#let voltn = [nV]
#let coulomb = [C]
#let coulombµ = [µC]
#let coulombn = [nC]
#let newton = [N]
#let farrad = [F]
#let farradµ = [µF]
#let epso = $epsilon_(0)$
#let voltmeter = [V/m]
#let ampere = [A]
#let amperem = [mA]
#let watt = [W]
