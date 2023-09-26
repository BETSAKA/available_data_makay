# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

# Send all firms files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

firms_files <- list.files(path = "data/firms", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "makay/firms_recent")

map2(firms_files, firms_dest, put_to_s3)

# IBtracks
ibtracs_files <- list.files(path = "data/ibtracs", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "makay/ibtracs")

map2(firms_files, firms_dest, put_to_s3)

# A function to iterate/vectorize copy
save_from_s3 <- function(from, to) {
  aws.s3::save_object(
    object = from,
    bucket = "fbedecarrats",
    file = to,
    overwrite = FALSE,
    region = "")
}

gfw_on_s3 <- my_bucket %>%
  filter
