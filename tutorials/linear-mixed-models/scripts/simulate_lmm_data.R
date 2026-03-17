set.seed(123)

n_subjects <- 30
n_time <- 6

subject_df <- tibble(
  subject = factor(1:n_subjects),
  b0 = rnorm(n_subjects, mean = 0, sd = 6),
  b1 = rnorm(n_subjects, mean = 0, sd = 1.2)
)

df <- expand_grid(
  subject = factor(1:n_subjects),
  time = 0:(n_time - 1)
) |>
  left_join(subject_df, by = "subject") |>
  mutate(
    y = 20 + 2.5 * time + b0 + b1 * time + rnorm(n(), mean = 0, sd = 2)
  )