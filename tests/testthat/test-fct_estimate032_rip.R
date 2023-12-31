

test_that("ggboxplot_rip works well", {
  testdata <- tomato_yields[fertilizer == "a", pounds, parameter]
  testdata$pounds_b <- tomato_yields[fertilizer == "b", pounds][1:5]
  colnames(testdata)[2] <- "pounds_a"
  testdata$rimosso <- c(rep("no", 3), "sì", "no")

  mytestplot <- ggboxplot_rip(testdata,
                                "pounds_a",
                                "pounds_b")

  expect_true(mytestplot |> ggplot2::is.ggplot())
  expect_equal(mytestplot$labels$y, "| differenza relativa | (%)")
})

test_that("rowsummary_rip works well", {

  testdata <- data.table::data.table(uniiso_11352_b4)
  testdata$perc_diff <- testdata$rel_diff * 100
  testdata$outlier <- c(FALSE, FALSE, FALSE, TRUE, rep(FALSE, times = 6))
  mytesttable <- rowsummary_rip(testdata, "perc_diff", "%")

  expect_equal(mytesttable$statistica |> unlist(),
               c("n esclusi", "n", "massimo", "media", "mediana", "minimo"))
  expect_equal(colnames(mytesttable),
               c("statistica", "| differenza relativa |"))
  expect_equal(mytesttable[statistica == "media"]$`| differenza relativa |`,
               sprintf("%.3g %%", testdata[outlier == FALSE, 100 * mean(rel_diff)]))
  expect_equal(mytesttable[statistica == "massimo"]$`| differenza relativa |`, "16.9 %")
  expect_equal(mytesttable[statistica == "minimo"]$`| differenza relativa |`, "2.50 %")
  expect_equal(mytesttable[statistica == "mediana"]$`| differenza relativa |`,
               sprintf("%.3g %%", testdata[outlier == FALSE, 100 * stats::median(rel_diff)]))
  expect_equal(mytesttable[statistica == "n"]$`| differenza relativa |`,
               testdata[outlier == FALSE, .N] |> as.character())
  expect_equal(mytesttable[statistica == "n esclusi"]$`| differenza relativa |`,
               testdata[outlier == TRUE, .N] |> as.character())

  testdata$outlier <- rep(FALSE, times = 10)
  mytesttable <- rowsummary_rip(testdata, "perc_diff", "%")
  expect_equal(mytesttable[statistica == "media"]$`| differenza relativa |`, "8.33 %")
})


test_that("fct_precision_rip works well", {

  testdata <- data.table::data.table(uniiso_11352_b4)
  mytestprecision <- fct_precision_rip(testdata, "rel_diff")

  expect_equal(mytestprecision$alpha, 0.025)
  expect_equal(mytestprecision$n, 10)
  expect_equal(mytestprecision$mean, 0.0833)
  expect_equal(sprintf("%.3g", mytestprecision$rsd), "7.38")
  expect_equal(sprintf("%.3g", mytestprecision$rel_repeatability),
               sprintf("%.3g", qt(0.975, 10 - 1, ) * sqrt(2) * 7.385))

})
