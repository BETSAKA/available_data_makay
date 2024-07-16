library(aws.s3)

# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

# Send all SRTM files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

srtm_files <- list.files(path = "data/nasa_srtm", recursive = TRUE,
                          full.names = TRUE)

srtm_dest <- str_replace(srtm_files, "data/", "diffusion/makay/data/")

map2(srtm_files, srtm_dest, put_to_s3)


# Send composed tifs to bucket
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

srtm_files <- list.files(path = "data/nasa_srtm", recursive = TRUE,
                         full.names = TRUE)

srtm_dest <- str_replace(srtm_files, "data/", "diffusion/makay/data/")

map2(srtm_files, srtm_dest, put_to_s3)



# Send all firms files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

firms_files <- list.files(path = "data/firms", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "makay/firms_recent")

map2(firms_files, firms_dest, put_to_s3)


# Check which SRTM overlap with MAdagascar --------------------------------


overlaps_with_mada <- function(raster_file, contour_mada) {
  # Load the raster file
  r <- raster(raster_file)
  
  # Convert the raster to an sf object
  r_sf <- st_as_sf(r, na.rm = TRUE)
  
  # Check if there's any intersection between the raster and contour_mada
  any(st_intersects(r_sf, contour_mada))
}

files <- list.files("data/mapme_biodiversity/nasa_srtm", full.names = TRUE)

overlapping_files <- files[map_lgl(files, overlaps_with_mada, contour_mada = contour_mada)]
                           
                           
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

