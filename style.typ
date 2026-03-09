#let intensity = 74%
#let accent = rgb("#0b93b7")
#let fontsize=14pt
// #let conf(colo) = [
//   let color = colo
// ]
// #let intensity = 13%
#let Cover(subject, assigment, author: "Ernestas Damanskis", lecturer, doc) = [
  #set text(font: "Times New Roman", lang: "lt")
  #align(center + top)[
    #image("assets/kvk.png", width: 18em)
    #text("KLAIPĖDOS VALSTYBINĖ KOLEGIJA", size: 15pt, weight: "bold") \
    #text("technologijų fakultetas", size: 15pt,weight: "bold") \
    #text("Informatikos ir biotechnologijų katedra", size: 15pt,weight: "bold") \
  ]
  #align(center + horizon)[
    // #text("Studijos Dalyko", size: 29pt) \
    // #line(length: 100%)
    #text(subject, size: 29pt, weight: "bold") \
    #text(assigment, size: 18pt) \
  ]
  #let label = "Lektorė:"
  #if lecturer.last() == "s" or lecturer.last() == "v" {
    label = "Lektorius:"
  }

  #set text(size: 17pt)
  #align(bottom + right)[
    #table(
      stroke: none,
      inset: (right: 0pt),
      columns: 2,
      align: left,
      label, lecturer,
      "Studentas:", author,
    )
    #align(center)[
      #pad(top: 4em, text(
        "Klaipėda, " + str(datetime.today().display("[year]")),
        size: 18pt,
        weight: "bold",
      ))
    ]
  ]

  #set list(indent: 1em)
  #set heading(numbering: "1.")
  #show heading.where(level: 1): it => block[
    // #text(weight: "bold", size: 18pt)[#length(it.body)]
    #text(weight: "bold", size: 21pt,fill: accent)[#it.body]

    #line(length: 100%,stroke: 2pt+accent)
    // #line(length: length(it.body))
    #v(0.4em)
]

  #show heading: set text(accent.darken(70%))
  // #show heading: set line(100%)
  // #set page(header: "header text" + line(length: 100%))
  //////////////////////////////////////
  #show figure: set block(breakable: true)
  #show figure.where(kind: raw): set align(left)

  #show figure.where(kind: raw): it => {
    block(
      clip: true,
      breakable: true,
      radius: (
        // left: 5pt,
        top-right: 10pt,
        top-left: 10pt,
      ),
      // radius: 10pt,
      // inset: 4pt,
      stroke: 3pt + accent.lighten(intensity),
    )[
      #block(
        fill: accent.lighten(intensity),
        breakable: false,
        width: 100%,
        spacing: 0pt,
        inset: (x: 0.5em, y: 0.5em),
      )[
        #text(weight: "semibold")[#it.caption]
      ]

      #block(
        width: 100%,
        // radius: (
        //   // left: 5pt,
        //   top-right: 10pt,
        //   top-left: 10pt,
        //   bottom-left: 10pt,
        //   bottom-right: 10pt,
        // ),

        breakable: true,
        inset: (x: 0.5em, y: 0.65em),
      )[
        #it.body
      ]
    ]
    // linebreak()
  }
  // #set text(size: 11pt)
  // #set text(size: 22pt)
  //////////////////////////////////////////////////
  #show table.cell.where(y: 0): set text(weight: "bold")
  #set table(
    align: (_, y) => // if x == 0 { left } +
    left + if y == 0 { bottom } else { top },
    //   fill: (_, y) =>
    // if y*10 <= 100 {
    //   color.lighten(y*10%)
    // },
    fill: (x, y) => if calc.odd(y) {
      if calc.even(x) {
        accent.lighten(intensity)
      } else {
        accent.lighten(intensity - 10%)
      }
    },
    inset: (x: .6em, y: 0.3em),
    // inset: (x: 0.5em, y: 0.3em),
    stroke: (_, y) => if y == 0 {
      (bottom: 2.5pt + accent.lighten(intensity - 30%))
    },
  )
  #show figure.caption: it => context [
    *#it.supplement~#it.counter.display()#it.separator*#it.body
  ]

  // #set table(
  //   // fill: (_, y) => if calc.odd(y) { luma(231) },
  //   // fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
  //   fill: (_, y) => (none, rgb("EAF2F5"), rgb("DDEAEF")).at(calc.rem(y, 3)),
  //   stroke: none,
  //   // stroke: luma(231)+3.1pt
  //   // stroke: frame(rgb("21222C")),
  //   // stroke:(x:none)
  //   // stroke: (_, y) => if y == 0 { (bottom: 1pt) }
  // )

  #pagebreak()

  #set page(numbering: "1")
  #set page(header: text(luma(94))[
    #grid(
      columns: (1fr, 1fr),
      align: (left + horizon, right),
      author + " INI16-2", image("./assets/kvk_mini.png", width: 8mm),
    )
  ])
  // [
  //   // #author INI16-1
  //   #align(left, "sdasddddddda"),
  //   #align(right, image("assets/kvk_mini.png", width: 1.2em))
  //   // #assigment
  // ])
  // #set page(header: text(luma(94), size: 0.9em)[
  //   // #author INI16-1
  //   #align(left, "sdasddddddda"),
  //   #align(right, image("assets/kvk_mini.png", width: 1.2em))
  //   // #assigment
  // ])
  #doc
]
#let TOC(ShowFigures: true, ShowTables: true, ShowRaw: true, doc) = {
  // title:[Turinys]
set text(fontsize)
  outline()

  pagebreak()

  context {
    if ShowFigures and counter(figure.where(kind: image)).final().at(0) > 0 {
      outline(
        title: [Paveikslėlių sąrašas],
        target: figure.where(kind: image),
      )
      pagebreak()
    }
  }

  context {
    if ShowTables and counter(figure.where(kind: table)).final().at(0) > 0 {
      outline(
        title: [Lentelių sąrašas],
        target: figure.where(kind: table),
      )
      pagebreak()
    }
  }
  context {
    if ShowRaw and counter(figure.where(kind: raw)).final().at(0) > 0 {
      outline(
        title: [Kodų sąrašas],
        target: figure.where(kind: raw),
      )
      pagebreak()
    }
  }
  doc
}
#let output(caption: "Rezultatas: ", cbody) = [
  // #block(
  //   clip: true,
  //   breakable: true,
  //   // radius: 20pt,
  //   // stroke: 2pt + surface0,
  //   inset: 4pt,
  // )
  // [
  // #block(
  //   breakable: false,
  //   width: 100%,
  //   spacing: 0pt,
  //   inset: (x: 0.5em, y: 0.5em),
  //   // fill: accent.lighten(intensity),
  // )[
  //   #align(left, [#text(weight: "bold",fill: accent)[#caption]])
  // ]

  #block(
    width: 100%,
    breakable: true,
    fill: accent.lighten(intensity),
    radius: 10pt,
    inset: (x: 0.5em, y: 0.65em),
    
  )[
    #set text(
    font: "Courier Prime Code",
    size: 12pt
  )
    #cbody
  ]
  // ]
]



#let key(name)= [
  #box(
  fill: accent.lighten(intensity),
  radius: 5pt,
  stroke: 1pt+accent,
  // width: fit-content,
  // inset: (x: 0.5em, y: 0.25em),
  inset: (x: 0.5em),
  outset: ( y: 0.24em),
)[
    #if name == "Win" {
    name = " "
    } 
  #text(font: "Times New Roman", lang: "lt")[#name]
  // [Block]
]
]
#let button(name)= [
  #box(
  // fill: accent,
  radius: 5pt,
  stroke: 1pt+accent,
  // width: fit-content,
  inset: (x: 0.8em),
  outset: ( y: 0.24em),
)[
  #text(font: "Times New Roman", lang: "lt")[#name]
  // [Block]
]
]
#let code(path, caption: none) = [
  #if type(path) == str [
    #let file = path.split("/").at(-1)
    #let ext = file.split(".").at(-1)
    #let text = read(path)
    #figure(raw(text, lang: ext), caption: file)

  ] else [

    #figure(path, caption: caption)
  ]
]
