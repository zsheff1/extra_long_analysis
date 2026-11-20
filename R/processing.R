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