report_correlation <- function(test, sigfigs = 3) {
  test <- test |>
    broom::tidy() |>
    janitor::clean_names()

  df <- unname(test$parameter)
  r <- signif(unname(test$estimate), digits = sigfigs)
  p <- test$p_value
  ci_5 <- signif(test$conf_low, digits = sigfigs)
  ci_95 <- signif(test$conf_high, digits = sigfigs)

  if (p < 0.001) {
    p <- 0.001
    p_operator <- "<"
  } else {
    p <- signif(p, digits = sigfigs)
    p_operator <- "="
  }

  stringr::str_c(
    stringr::str_c("r(", df, ") = ", r),
    stringr::str_c("p", p_operator, p, sep = " "),
    stringr::str_c("95% CI [", ci_5, ", ", ci_95, "]"),
    sep = ", "
  )
}

report_t_test <- function(test, sigfigs = 3) {
  test <- test |>
    broom::tidy() |>
    janitor::clean_names()

  df <- round(unname(test$parameter), digits = 2)
  t <- signif(unname(test$statistic), digits = sigfigs)
  p <- test$p_value
  ci_5 <- signif(test$conf_low, digits = sigfigs)
  ci_95 <- signif(test$conf_high, digits = sigfigs)

  if (p < 0.001) {
    p <- 0.001
    p_operator <- "<"
  } else {
    p <- signif(p, digits = sigfigs)
    p_operator <- "="
  }

  stringr::str_c(
    stringr::str_c("t(", df, ") = ", t),
    stringr::str_c("p", p_operator, p, sep = " "),
    stringr::str_c("95% CI [", ci_5, ", ", ci_95, "]"),
    sep = ", "
  )
}