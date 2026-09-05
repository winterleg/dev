#let qs(body) = {
  set enum(numbering: "(a)")
  block(
    breakable: false,
    {
      body
      v(5pt)
      line(length: 100%, stroke: 0.1pt)
    },
  )
}

#let pt(body) = {
  body
}

#let ans(body) = {
  align(center, block(
    width: 80%,
    align(left, body),
  ))
}

#let det(..args) = $mat(delim: "|", ..args)$

#import "@preview/headcount:0.1.0": *
#let eq(equation) = math.equation(
  block: true,
  numbering: dependent-numbering("(1.1)"),
  equation,
)

#import "@preview/cetz:0.4.2"
#let xyz_to_cetz(x, y, z) = (y, z, x)

#let vector(origin, end, color: blue, depth: true, depth_color: gray) = {
  if depth {
    cetz.draw.set-style(
      stroke: (paint: depth_color, dash: "dashed"),
    )

    let (origin_x, origin_y, origin_z) = origin
    let (end_x, end_y, end_z) = end

    // vers l'origine du vecteur
    cetz.draw.line(
      xyz_to_cetz(0, 0, 0),
      xyz_to_cetz(origin_x, 0, 0),
      xyz_to_cetz(origin_x, origin_y, 0),
      xyz_to_cetz(origin_x, origin_y, origin_z),
    )

    // vers l'extrémité du vecteur
    cetz.draw.line(
      xyz_to_cetz(0, 0, 0),
      xyz_to_cetz(end_x, 0, 0),
      xyz_to_cetz(end_x, end_y, 0),
      xyz_to_cetz(end_x, end_y, end_z),
    )

    cetz.draw.set-style(
      stroke: 1pt + black,
    )
  }
  cetz.draw.set-style(
    stroke: 1pt + color,
  )
  cetz.draw.line(
    xyz_to_cetz(..origin),
    xyz_to_cetz(..end),
    mark: (end: "stealth"),
    stroke: (paint: color),
  )
}

#let draw_axis(size, draw_negative: false) = {
  let neg = if draw_negative { -size } else { 0 }
  cetz.draw.line(
    xyz_to_cetz(neg, 0, 0),
    xyz_to_cetz(size, 0, 0),
    mark: (end: "stealth"),
  )
  cetz.draw.content((), "x", anchor: "north-west")

  cetz.draw.line(
    xyz_to_cetz(0, neg, 0),
    xyz_to_cetz(0, size, 0),
    mark: (end: "stealth"),
  )
  cetz.draw.content((), "y", anchor: "west")

  cetz.draw.line(
    xyz_to_cetz(0, 0, neg),
    xyz_to_cetz(0, 0, size),
    mark: (end: "stealth"),
  )
  cetz.draw.content((), "z", anchor: "south-east")
}

#let start_draw(body) = cetz.canvas(length: 1cm, {
  body
})

// Helper functions for 3D vector math
#let cross(v1, v2) = (
  v1.at(1) * v2.at(2) - v1.at(2) * v2.at(1),
  v1.at(2) * v2.at(0) - v1.at(0) * v2.at(2),
  v1.at(0) * v2.at(1) - v1.at(1) * v2.at(0),
)
#let vec_add(v1, v2) = (
  v1.at(0) + v2.at(0),
  v1.at(1) + v2.at(1),
  v1.at(2) + v2.at(2),
)
#let vec_sub(v1, v2) = (
  v1.at(0) - v2.at(0),
  v1.at(1) - v2.at(1),
  v1.at(2) - v2.at(2),
)
#let vec_scale(v, s) = (v.at(0) * s, v.at(1) * s, v.at(2) * s)

#let draw_plane(
  a,
  b,
  c,
  d,
  size: 1,
  color: blue,
  draw_normal: false,
  normal_length: 1,
) = {
  import cetz.draw

  let stroke_color = black

  // Normalize the normal vector n = (a, b, c)
  let n_raw = (a, b, c)
  let norm_sq = a * a + b * b + c * c
  if norm_sq == 0 { return }
  let norm = calc.sqrt(norm_sq)
  let n = vec_scale(n_raw, 1 / norm)

  // Determine fill color based on orientation to a viewpoint on the +z axis.
  let base_fill = color.opacify(-50%)
  let final_fill
  if n.at(0) >= 0 or n.at(1) >= 0 or n.at(2) >= 0 {
    // Normal is pointing towards a +z viewpoint, make it lighter.
    final_fill = base_fill.lighten(25%)
  } else {
    // Normal is pointing away from a +z viewpoint, make it darker.
    final_fill = base_fill.darken(25%)
  }

  // Create two orthogonal unit vectors u and v that lie on the plane
  let temp_vec = if (n.at(0) == 0 and n.at(2) == 0) { (1, 0, 0) } else {
    (0, 1, 0)
  }
  let u_raw = cross(n, temp_vec)
  let u_norm = calc.sqrt(
    u_raw.at(0) * u_raw.at(0)
      + u_raw.at(1) * u_raw.at(1)
      + u_raw.at(2) * u_raw.at(2),
  )
  let u = vec_scale(u_raw, 1 / u_norm)
  let v = cross(n, u) // n and u are orthonormal, so v is already a unit vector

  // Find a center point P0 on the plane to anchor the patch and normal vector
  let P0
  if c != 0 {
    P0 = (0, 0, d / c)
  } else if b != 0 {
    P0 = (0, d / b, 0)
  } else if a != 0 {
    P0 = (d / a, 0, 0)
  } else {
    // This case should have been caught by norm_sq == 0
    return
  }

  // Define the 4 corners of the square patch on the plane
  let u_scaled = vec_scale(u, size)
  let v_scaled = vec_scale(v, size)
  let p1 = vec_sub(vec_sub(P0, u_scaled), v_scaled)
  let p2 = vec_add(vec_sub(P0, u_scaled), v_scaled)
  let p3 = vec_add(vec_add(P0, u_scaled), v_scaled)
  let p4 = vec_sub(vec_add(P0, u_scaled), v_scaled)

  // Draw the plane patch
  draw.line(
    xyz_to_cetz(..p1),
    xyz_to_cetz(..p2),
    xyz_to_cetz(..p3),
    xyz_to_cetz(..p4),
    fill: final_fill,
    stroke: stroke_color,
    close: true,
  )

  // Draw the normal vector if requested
  if draw_normal {
    let P_normal_end = vec_add(P0, vec_scale(n, normal_length))
    vector(P0, P_normal_end, color: red)
  }
}
