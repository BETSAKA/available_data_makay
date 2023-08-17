# Send all firms files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

firms_files <- list.files(path = "data/nasa_firms", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "mapme_biodiversity/")

map2(firms_files, firms_dest, put_to_s3)
