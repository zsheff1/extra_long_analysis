match_visits <- function(df, key, id_col) {
  edges <- df |>
    mutate(
      from = paste0("scan_", scanid),
      to = paste0("test_", .data[[id_col]]),
      weight = n_distinct(scanid) * max(time_difference) +
        1 - time_difference
    )

  graph <- igraph::graph_from_data_frame(
    edges |> select(from, to, weight),
    directed = FALSE
  )

  matching <- igraph::max_bipartite_match(
    graph,
    types = startsWith(igraph::V(graph)$name, "test_")
  )$matching

  edges |>
    filter(to == matching[from]) |>
    select(-from, -to, -weight)
}

residualize_gamm <- function(x, data, termlabels) {
  data$.response <- x

  mgcv::gamm(
    reformulate(
      response = ".response",
      termlabels = termlabels
    ),
    random = list(bblid = ~ 1),
    data = data,
    method = "REML"
  ) |>
    purrr::pluck("gam") |>
    residuals() |>
    scale() |>
    as.numeric()
}