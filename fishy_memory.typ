#set text(
  font: "New Computer Modern",
  size: 12pt,
  lang: "en"
)
#set page(
  paper: "a4",
  numbering: "1",
  margin: (
    top: 2cm,
    bottom: 2cm,
    x: 3cm
  )
)


///////////////////////////////// Thanks @wrzian https://github.com/typst/typst/discussions/2585#discussioncomment-10318563  /////////////////////////////////////////////////////////
/////////////// I modified a bit to make it also work with cite and other refs.
/////// For equation, need to set a numbering first #set math.equation(numbering: "(1)")
#let separate-supplement-style(supp, num) = {
  text(supp)
  [ ]
  box(num, stroke: 1pt + red, outset: (bottom:1.5pt, x:.5pt, y:.5pt))
}
#show cite: it => {
    if it.supplement == none {
     box(it, stroke: green + 1pt)
  } 
}
#show ref: it => {
  let (element, target, supplement: supp) = it.fields()
  // cite doesn't have element
  if element == none {
    return it
  }

  let non_cite_ref = element.fields()
  let supp = if supp == auto { non_cite_ref.supplement } else { supp }
  let num = context { // apply the heading's numbering style
    let head-count = counter(heading).at(target)
    numbering(non_cite_ref.numbering, ..head-count)
  }
  link(target, separate-supplement-style(supp, num))
}
//////////////////////////////////////////////////////////////////////////////////////////



#show raw: it => block(
  width: 100%,
  fill: luma(240),
  inset: 4pt,
  radius: 4pt,
  text(size: 7pt, it)
)
#set heading(numbering: "1.1")
#set par(justify: true)
#set enum(numbering: "(a)", indent: 5pt)
#set math.equation(numbering: "(1)")
#v(135pt)

#let today = datetime.today()
#align(center, text(19pt, weight: "bold", font: "Latin Modern Roman 17",)[
  this is a center aligned title \
  #v(2.5em)
  #today.display("[month repr:long] [day], [year]")
])

$ "loss" =  - sum_(n=1)^n (y_i  log hat(y)_(theta,i) + (1-y_i)log(1-hat(y)_(theta,i)) ) $ <NLLLoss>

#figure(
  image("figure/schedule.png", width: 80%),
  caption: [
    this is a caption
  ],
) <this_is_cite_ref>
#figure(
  table(
    columns: (5),
    inset: 3pt,
    align: horizon,
    table.header(
      [], [*negative*], [*neutral*],  [*positive*],[*total*]
    ),
    [train],[2084],[3077],[1929],[7090],
    [validation],[259],[388],[241],[888],
    [test],[263],[393],[245],[901]
  ), 
  caption: [hahaha]
) <MAMS_stat>
#figure(
    grid(
        columns: (1),
        rows:    (auto, auto),
        gutter: 0em,
        [ #image("diagram/A_attn_service.png",   width: 100%) ],
        [ #image("diagram/A_attn_food.png", width: 100%) ],
    ),
    caption: [up to down: service_negative, predicted as neutral; food_positive, predicted as neutral;]
) <A_visual_attn>


@zhangAlgorithmOptimizedMRNA2023 #cite(label("10.1093/nar/gkad1168"))
#bibliography("my_refs.bib", style: "ieee")
