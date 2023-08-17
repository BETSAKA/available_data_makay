library(tidyverse)
library(aws.s3)

# To use the S3 server to save and load intermediate results,# You must enter 
# your AWS credentials in the R console. For more indications see: 
# https://www.book.utilitr.org/01_r_insee/fiche_utiliser_rstudio_sspcloud#renouveler-des-droits-dacc%C3%A8s-p%C3%A9rim%C3%A9s

# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

# A function to iterate/vectorize copy
save_from_s3 <- function(from, to, overwrite = FALSE) {
  aws.s3::save_object(
    object = from,
    bucket = "fbedecarrats",
    file = to,
    overwrite = overwrite,
    region = "")
}