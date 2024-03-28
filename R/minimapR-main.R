## minimapR-main.R
## LICENSE: MIT License

minimap2 <- function(reference, 
    query_sequences, 
    output_file, 
    a = TRUE,
    preset_string = "map-hifi",
    threads = 1, 
    verbose = TRUE, 
    ...) {
    # Check if minimap2 is installed
    if (!is.null(Sys.which("minimap2"))) {
        # Run minimap2
        if (verbose) {
            message("Running minimap2...")
        }
        
        # Run minimap2
        if (a) {
            system(paste0("minimap2 -ax ", preset_string, 
                " -t ", threads, " ", reference, 
                " ", query_sequences, " -o ", output_file, 
                " ", ...))
        } else {
            system(paste0("minimap2 -x ", preset_string, 
                " -t ", threads, " ", reference, 
                " ", query_sequences, " -o ", output_file, 
                " ", ...))
        }
    } else {
        message("minimap2 is not installed. Please install minimap2.")
    }
}