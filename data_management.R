# Send all firms files to S3
my_bucket <- get_bucket_df(bucket = "fbedecarrats", region = "")

firms_files <- list.files(path = "data/nasa_firms", recursive = TRUE,
                          full.names = TRUE)

firms_dest <- str_replace(firms_files, "data/", "mapme_biodiversity/")

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
