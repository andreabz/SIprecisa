#' estimate UI Function: option for repeatability and recovery estimates
#' on the same measurement values
#'
#' @description A shiny Module for estimating performance parameters of
#'   chemical analytical methods.
#'   Data are checked for normality, presence of outliers and repeatability and
#'   recovery statistics are calculated.
#'   The presence of a significant bias is tested by two-sided t-test.
#'
#' @details Normality is checked by using the Shapiro-Wilk test.
#'   Possible outliers are inspected by generalized extreme studentized deviate test.
#'   Mean values of measurments is compared with the reference value by two-sided t-test.
#'
#'   Test results are formatted in HTML.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @return Three UI {shiny} input widgets:
#' \itemize{
#'  \item{udm}{a text input for the unit of measurements.
#'    It is used for axes description and reporting, it is optional and it can be left blank.}
#'  \item{refvalue}{a numeric input widget for typing the known reference value.}
#'  \item{refuncertainty}{a numeric input widget for typing the extended uncertainty for
#'  the reference value.}
#'  \item{submit}{an action button to submit the reference value and uncertainty to calculations.}
#'  \item{significance}{a radiobutton widgted with test confidence levels.
#'    Choices are "90\%", "95\%", "99\%", default is "95\%".}
#' }
#'
#' @noRd
#'
#' @import shiny
mod_estimate031_riprec_inputs_ui <- function(id) {
  ns <- NS(id)
  tagList(

      # 1. write the unit of measurment (optional)
      textInput(ns("udm"),
                "Unit\u00E0 di misura",
                ""),

      # 2. select the test significant level
      radioButtons(
        ns("significance"),
        "Livello di confidenza",
        choices = c(
          "90%" = 0.90,
          "95%" = 0.95,
          "99%" = 0.99
        ),
        selected = 0.95
      ),

      # 3. known reference mean value
      numericInput(
        ns("refvalue"),
        "Valore di riferimento",
        0,
        min = 0),

      # 4. known reference extended uncertainty value
      numericInput(
        ns("refuncertainty"),
        "Incertezza estesa",
        0,
        min = 0),

      # 4. submit button
      actionButton(
        ns("submit"),
        "Calcola",
        icon = icon("calculator")
      ),

  )
}

#' estimate UI Function: option for repeatability and recovery estimates
#' on the same measurement values
#'
#' @description A shiny Module for estimating performance parameters of
#'   chemical analytical methods.
#'   Data are checked for normality, presence of outliers and repeatability and
#'   recovery statistics are calculated.
#'   The presence of a significant bias is tested by two-sided t-test.
#'
#' @details Normality is checked by using the Shapiro-Wilk test.
#'   Possible outliers are inspected by generalized extreme studentized deviate test.
#'   Mean values of measurments is compared with the reference value by two-sided t-test.
#'
#'   Test results are formatted in HTML.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @return A two column fluidrow. In the first column a boxplot and a summary table
#' are reported, whereas in the second column test results are reported in two
#' separate tabs.
#'
#' @noRd
#'
#' @import shiny
#' @import markdown
#' @importFrom plotly plotlyOutput
#' @importFrom DT DTOutput
#' @importFrom bslib navset_hidden nav_panel card card_header card_body layout_columns navset_card_tab
mod_estimate031_riprec_output_ui <- function(id) {
  ns <- NS(id)
  tagList(

    bslib::navset_hidden(
    id = ns("help_results"),

    bslib::nav_panel("help",
      help_card(
        card_title = "Cosa devi fare",
        rmdfile = "help_estimate031_riprec.Rmd",
        rmdpackage = "SIprecisa"
      )
    ),

    bslib::nav_panel("results",

      bslib::layout_columns(
        bslib::card(
          bslib::card_header(icon("vials"), "Boxplot e tabella riassuntiva"),
          bslib::card_body(plotly::plotlyOutput(ns("boxplot"))),
          bslib::card_body(DT::DTOutput(ns("summarytable")))
        ),

        bslib::navset_card_tab(
          id = ns("tabresults"),
          title = list(icon("vials"), "Test statistici"),

          bslib::nav_panel("Normalit\u00E0",
            h4("Test per la verifica della normalit\u00E0 (Shapiro-Wilk)"),
            htmlOutput(ns("shapirotest")),
            hr(),
            h4("Test per identificare possibili outliers (GESD)"),
            htmlOutput(ns("outliers"))
          ),
          bslib::nav_panel("Bias",
            h4("Test per valutare la presenza di bias (t-test, Welch)"),
            htmlOutput(ns("ttest"))
          )
        )
      )
    )

  ))
}

#' estimate server Function: option for repeatability and recovery estimates
#' on the same measurement values
#'
#' @description A shiny Module for estimating performance parameters of
#'   chemical analytical methods.
#'   Data are checked for normality, presence of outliers and repeatability and
#'   recovery statistics are calculated.
#'   The presence of a significant bias is tested by two-sided t-test.
#'
#' @details Normality is checked by using the Shapiro-Wilk test.
#'   Possible outliers are inspected by generalized extreme studentized deviate test.
#'   Mean values of measurments is compared with the reference value by two-sided t-test.
#'
#'    This module is supposed to be used as {mod_estimate03} submodule.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param r a {reactiveValues} storing data produced in the other modules.
#' in \code{r$loadfile02$} the following values can be found:
#' \itemize{
#'    \item{data} is the imported data.frame;
#'    \item{parvar} is the data.frame column name in which parameters are stored;
#'    \item{parlist} is the list of parameters provided by the data.frame;
#'    \item{responsevar} is the data.frame column name in which the response numerical values are stored.
#'    }
#'In \code{r$estimate03$myparameter} the selected parameter name is stored;
#' @return A {plotly} interactive boxplot, a {DT} summary table
#'  and Shapiro-Wilk test and \eqn{t}-test results formatted in HTML.
#'  a reactiveValues \code{r$estimate03x} with the following items:
#'    \itemize{
#'      \item{parameter}{the selected parameter;}
#'      \item{udm}{the unit of measurement;}
#'      \item{significance}{the level of significance for the tests;}
#'      \item{data}{the subsetted dataset with a flag for removed or not removed values;}
#'      \item{summary}{a summary table;}
#'      \item{normality}{a Markdown formatted string with the results for the normality test.}
#'      \item{outliers}{a Markdown formatted string with the results for the outliers test.}
#'      \item{ttest}{a Markdown formatted string with the results for the t-test.}
#'    }
#'
#' @noRd
#'
#' @import shiny
#' @import data.table
#' @importFrom plotly renderPlotly
#' @importFrom DT renderDT
mod_estimate031_riprec_server <- function(id, r) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    r$estimate03x <- reactiveValues()

    # storing input values into r$estimate03x reactiveValues ----

    ## selected parameter
    observeEvent(r$compare03$myparameter, {
      r$estimate03x$parameter <- r$estimate03$myparameter

      # updating the tabset switching from help to results tabs
      help_results <- ifelse(r$estimate03x$parameter == "", "help", "results")
      updateTabsetPanel(inputId = "help_results", selected = help_results)
    })

      ## reset reference value and extended uncertainty after changing the parameter
      observeEvent(r$estimate03$myparameter, ignoreNULL = FALSE, {
        # if the results have been saved, restore the input values
        if(r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()){

          freezeReactiveValue(input, "significance")
          freezeReactiveValue(input, "udm")
          freezeReactiveValue(input, "refvalue")
          freezeReactiveValue(input, "refuncertainty")

          updateRadioButtons(session,
                             "significance",
                             selected = r$estimate03[[r$estimate03$myparameter]]$significance)
          updateTextInput(session,
                          "udm",
                          value = r$estimate03[[r$estimate03$myparameter]]$udm)
          updateTextInput(session,
                          "refvalue",
                          value = r$estimate03[[r$estimate03$myparameter]]$refvalue)
          updateNumericInput(session,
                             "refuncertainty",
                             value = r$estimate03[[r$estimate03$myparameter]]$refuncertainty)

          showModal(
            modalDialog(
              title = "Hai gi\u00E0 salvato i risultati",
              shiny::HTML(
                "Per sovrascrivere i risultati salvati, clicca sui pulsanti
            cancella e poi nuovamente su salva, altrimenti le modifiche andranno perse.
            <br>
            Trovi i pulsanti in basso nella barra dei comandi,
            nella parte sinistra della pagina"
              ),
              easyClose = TRUE,
              footer = modalButton("Va bene")
            )
          )

          r$estimate03x$click <- 1

          # else, just use the default initial values
        } else {

          freezeReactiveValue(input, "significance")
          freezeReactiveValue(input, "udm")
          freezeReactiveValue(input, "refvalue")
          freezeReactiveValue(input, "refuncertainty")

          updateTextInput(session, "refvalue", value = 0)
          updateNumericInput(session, "refuncertainty", value = 0)

          r$estimate03x$click <- 0
        }

      })

    ## unit of measurement
    observeEvent(input$udm, ignoreNULL = FALSE, {
      udmclean <- gsub("[()\\[\\]]", "", input$udm, perl = TRUE)
      r$estimate03x$udm <- udmclean
    })

    ## test confidence level
    observeEvent(input$significance, ignoreNULL = FALSE, {
      r$estimate03x$significance <- input$significance
    })


    # preparing the reactive dataset for outputs ----
    mydata <- reactive({
      r$loadfile02$data[get(r$loadfile02$parvar) == r$estimate03x$parameter]
    })

    rownumber <- reactive({
      req(mydata())

      nrow(mydata())
    })

    key <- reactive(seq(from = 1, to = rownumber()))

    # using the row index to identify outliers
    keys <- reactiveVal()

    observeEvent(plotly::event_data("plotly_click", source = "boxplot"), {
      req(plotly::event_data("plotly_click", source = "boxplot")$key)

      key_new <- plotly::event_data("plotly_click", source = "boxplot")$key
      key_old <- keys()

      if (key_new %in% key_old) {
        keys(setdiff(key_old, key_new))
      } else {
        keys(c(key_new, key_old))
      }

    })

    # reset the keys index when changing the parameter
    observeEvent(r$estimate03$myparameter, {
      keys(NULL)
    })

    # flag per i punti selezionati
    is_outlier <- reactive(key() %in% keys())

    # assembling the dataframe
    input_data <- reactive({

      data.frame(
        key = key(),
        outlier = is_outlier(),
        response = mydata()[[r$loadfile02$responsevar]]
      )

    })

    # subset of non outliers
    selected_data <- reactive({
      req(input_data())

      input_data()[input_data()$outlier == FALSE,]
    })

    # min number of values
    minval <- reactive({
      req(!is.null(selected_data()))

      selected_data()[, .N]
    })


    # reactive boxplot ----
    plotlyboxplot <- reactive({
      req(input_data())

      boxplot_riprec(
        data = input_data(),
        response = r$loadfile02$responsevar,
        udm = r$estimate03x$udm,
        refvalue = r$estimate03x$refvalue,
        refuncertainty = r$estimate03x$refuncertainty
      )

    })

    output$boxplot <- plotly::renderPlotly({
      # if results have been saved, restore the boxplot
      if(r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()){

        r$estimate03[[r$estimate03$myparameter]]$plotlyboxplot

        # else a new boxplot is calculated and shown
      } else {

        plotlyboxplot()
      }
      })


    # reactive summary table ----
    summarytable <- reactive({
      req(selected_data())

      rowsummary_riprec(
        data = selected_data(),
        response = "response",
        udm = r$compare03x$udm,
        refvalue = r$compare03x$refvalue,
        refuncertainty = r$compare03x$refuncertainty
      )

    })

    output$summarytable <- DT::renderDT({
      # if results have been saved, restore the summarytable
      if (r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()) {

        DT::datatable(r$estimate03[[r$estimate03$myparameter]]$summary,
                      style = "bootstrap4",
                      fillContainer = TRUE,
                      options = list(dom = "t"),
                      rownames = FALSE)
      } else {

        DT::datatable(summarytable(),
                      style = "bootstrap4",
                      fillContainer = TRUE,
                      options = list(dom = "t"),
                      rownames = FALSE)
      }

    })


    # results of normality check ----
    shapiro_text <-
      "%s (W = %.3f, <i>p</i>-value = %.4f)</br>"

    shapiro_html <- reactive({
      # don't update the list if results have been already saved
      req(r$estimate03[[r$estimate03$myparameter]]$saved |> isFALSE() ||
            r$estimate03[[r$estimate03$myparameter]]$saved |> is.null())

    shapiro_output <- selected_data()[, "response"] |>
      fct_shapiro()

        sprintf(
          shapiro_text,
          shapiro_output$result,
          shapiro_output$W,
          shapiro_output$pvalue
        )
    })

    output$shapirotest <- renderText({
      validate(
        need(minval() >= 6,
             message = "Servono almeno 6 valori per poter calcolare i parametri prestazionali")
      )
      # if results have been saved, restore the normality test results
      if (r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()) {

        r$estimate03[[r$estimate03$myparameter]]$normality_html

      } else {

        shapiro_html()
      }
    })


    # results for outliers check ----
    out_text <-
      "%s a un livello di confidenza del 95%% </br> %s a un livello di confidenza del 99%% </br></br>"

    outliers_html <- reactive({
      req(selected_data())
      req(minval() >= 6)
      # don't update the list if results have been already saved
      req(r$estimate03[[r$estimate03$myparameter]]$saved |> isFALSE() ||
            r$estimate03[[r$estimate03$myparameter]]$saved |> is.null())

      outtest_output95 <- selected_data()[, "response"] |>
        fct_gesd(significance = 0.95)

      outtest_output99 <- selected_data()[, "response"] |>
        fct_gesd(significance = 0.99)

        sprintf(out_text,
                outtest_output95$text,
                outtest_output99$text)

    })

    output$outliers <- renderText({
      validate(
        need(minval() >= 6,
             message = "Servono almeno 6 valori per poter calcolare i parametri prestazionali")
      )
      # if results have been saved, restore the outliers test results
      if (r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()) {

        r$estimate03[[r$estimate03$myparameter]]$outliers_html

      } else {

        outliers_html()
      }
    })


    #### results for the t-test ----
    ttest_list <- reactive({
      req(selected_data())
      req(r$estimate03x$significance)
      req(r$estimate03x$alternative)
      # don't update if results have been saved
      req(r$estimate03[[r$estimate03$myparameter]]$saved |> isFALSE() ||
            r$estimate03[[r$estimate03$myparameter]]$saved |> is.null())

      fct_ttest_riprec(
        selected_data(),
        "response",
        refvalue,
        refuncertainty,
        significance = as.numeric(r$estimate03x$significance)
      )

    })

    ttest_text <-
"<b>H0:</b> %s </br>
<b>H1:</b> %s
<ul>
  <li> Media delle misure (valore e intervallo di confidenza) = %s %s, %s \u2013 %s %s</li>
  <li> <i>t</i> sperimentale = %s </li>
  <li> <i>t</i> critico (\u03b1 = %s, \u03bd = %s) = %s </li>
  <li> <i>p</i>-value = %s </li>
</ul>
\u21e8 %s"

    ttest_html <- reactive({

      sprintf(
        ttest_text,
        ttest_list()$hypotheses[[1]],
        ttest_list()$hypotheses[[2]],
        ttest_list()$difference[[1]],
        r$estimate03x$udm,
        ttest_list()$difference[[2]],
        ttest_list()$difference[[3]],
        r$estimate03x$udm,
        ttest_list()$test[[3]],
        ttest_list()$test[[2]],
        ttest_list()$test[[1]],
        ttest_list()$test[[4]],
        ttest_list()$test[[5]],
        ttest_list()$result
      )

    })

    output$ttest <- renderText({
      validate(
        need(minval() >= 6,
             message = "Servono almeno 6 valori per poter calcolare i parametri prestazionali")
      )
      # if results have been saved, restore the t-test results
      if (r$estimate03[[r$estimate03$myparameter]]$saved |> isTRUE()) {

        r$estimate03[[r$estimate03$myparameter]]$ttest_html

      } else {

        ttest_html()
      }

      })

    # saving the outputs ----

    observeEvent(ttest_html(), {

      # output dataset
      r$estimate03x$data <- mydata()[, !r$loadfile02$parvar, with = FALSE]
      r$estimate03x$data[, "rimosso"] <- ifelse(is_outlier() == TRUE, "s\u00EC", "no")

      # summary table
      r$estimate03x$summary <- summarytable()

      # boxplot
      r$estimate03x$plotlyboxplot <- plotlyboxplot()

      # test results
      r$estimate03x$normality <- shapiro_html()
      r$estimate03x$outliers <- outliers_html()
      r$estimate03x$ttest <- ttest_html()
      # flag for when ready to be saved
      r$estimate03x$click <- 1

      # the plot is saved only when the save button is clicked
    })

  })
}