report_correlation <- function(test, sigfigs = 3) {
  test <- test |>
    broom::tidy() |>
    janitor::clean_names()

  df <- round(unname(test$parameter), digits = 2)
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

report_aic <- function(models) {
  models |>
    tibble::enframe(name = "identifier", value = "model") |>
    dplyr::mutate(
      formula = purrr::map_chr(model, \(x) deparse1(stats::formula(x))),
      df = purrr::map_dbl(model, \(x) attr(stats::logLik(x), "df")),
      aic = purrr::map_dbl(model, \(x) stats::AIC(x)),
      delta_aic = aic - min(aic)
    ) |>
    dplyr::select(-model) |>
    dplyr::arrange(delta_aic)
}

demo_summarize <- function(raw) {
  raw |>
    dplyr::summarize(
      n = dplyr::n(),
      age_mean = mean(age, na.rm = TRUE),
      age_sd = sd(age, na.rm = TRUE),
      male_n = sum(sex == "Male"),
      female_n = sum(sex == "Female"),
      dx_td_n = sum(dx == "td", na.rm = TRUE),
      dx_ps_n = sum(dx == "ps", na.rm = TRUE),
      dx_op_n = sum(dx == "op", na.rm = TRUE),
      trauma_mean = mean(trauma, na.rm = TRUE),
      trauma_sd = sd(trauma, na.rm = TRUE),
      ses_mean = mean(ses, na.rm = TRUE),
      ses_sd = sd(ses, na.rm = TRUE)
    ) |>
    dplyr::mutate(
      age = sprintf("%.2f (%.2f)", age_mean, age_sd),
      male = sprintf("%d (%.2f%%)", male_n, (male_n * 100 / n)),
      female = sprintf("%d (%.2f%%)", female_n, (female_n * 100 / n)),
      td = sprintf("%d (%.2f%%)", dx_td_n, (dx_td_n * 100 / n)),
      ps = sprintf("%d (%.2f%%)", dx_ps_n, (dx_ps_n * 100 / n)),
      op = sprintf("%d (%.2f%%)", dx_op_n, (dx_op_n * 100 / n)),
      trauma = sprintf("%.2f (%.2f)", trauma_mean, trauma_sd),
      ses = sprintf("%.2f (%.2f)", ses_mean, ses_sd)
    ) |>
    dplyr::mutate(n = as.character(n)) |>
    dplyr::select(n, age, male, female, td, ps, op, trauma, ses) |>
    tidyr::pivot_longer(
      cols = tidyselect::everything(),
      names_to = "Characteristic",
      values_to = "Value"
    )
}