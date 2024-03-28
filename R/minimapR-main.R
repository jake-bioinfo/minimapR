## minimapR-main.R
## LICENSE: MIT License

## This is a the main wrapper function for the command line tool 
## minimap2.
#' @title minimap2
#'
#' @description
#' This function is a wrapper for the command line tool minimap2. 
#' minimap2 is a long read sequencing alignment tool that is
#' used to align long reads to a reference genome.
#'
#' @param reference Reference genome to align the query sequences
#' @param query_sequences Query sequences to align to the reference genome
#' @param output_file Output file to save the alignment results
#' @param a Logical value to use the preset string with the -a flag
#' @param preset_string Preset string to use with the -x flag
#' @param threads Number of threads to use
#' @param verbose Logical value to print progress of the installation
#' @param ... Additional arguments to pass to minimap2
#'
#' @return This function returns the line needed to add minimap2 to PATH
#' 
#' @example
#' reference <- "reference.fa"
#' query_sequences <- "query.fa"
#' output_file <- "output.sam"
#' minimap2(reference, query_sequences, output_file)
#' 
#' @example
#' reference <- file.path(here::here("data/MT-human.fa")
#' query_sequences <- file.path(here::here("data/MT-orang.fa")
#' output_file <- file.path(here::here("data/MT-human-orang"))
#' bam_out <- minimap2(reference, 
#'  query_sequences, 
#'  output_file,
#'  threads = 4,
#'  preset_string = "map-hifi" 
#'  return_ = TRUE, 
#'  verbose = TRUE)
#' 
#' @export
#' @import Rsamtools
#' @import pafr
#' @import here
#' @import GenomeInfoDb
minimap2 <- function(reference, 
    query_sequences, 
    output_file_prefix, 
    a = TRUE,
    preset_string = "map-hifi",
    threads = 1, 
    return = FALSE,
    verbose = TRUE, 
    ...) {

    # Source helper functions
    source(here::here("R/minimapR-helper.R"))

    # Get the path to the minimap2 executable
    mini_path <- Sys.which("minimap2")
    st_path <- Sys.which("samtools")

    # Output files
    output_sam <- paste0(output_file_prefix, ".sam")
    output_bam <- paste0(output_file_prefix, ".bam")
    output_paf <- paste0(output_file_prefix, ".paf")

    # Check if minimap2 is installed
    if (!is.null(mini_path) && !is.null(st_path)) {
        # Run minimap2
        if (verbose) {
            message("Running minimap2...")
        }
        
        # Run minimap2
        if (a) {
            system(paste0(mini_path, " -ax ", preset_string, 
                " -t ", threads, " ", reference, 
                " ", query_sequences, " -o ", output_sam, 
                " ", ...))
            system(paste0(st_path, " view -bS ", output_sam, " > ", output_bam))
            system(paste0(st_path, " sort -o ", output_bam, " ", output_bam))

        if (return == TRUE) {
            bam_f <- Rsamtools::BamFile(output_bam)
            ret <- as.data.frame(Rsamtools::scanBam(bam_f))
            }

        } else {
            system(paste0(mini_path, " -x ", preset_string, 
                " -t ", threads, " ", reference, 
                " ", query_sequences, " -o ", output_paf, 
                " ", ...))

            if (return == TRUE) {
                ret <- pafr::read_paf(output_paf)
            }
        }

        # Return the output
        if (return == TRUE) {
            return(ret)
        }

    } else {
        message("minimap2 or samtools is not installed.",
                "\nPlease install minimap2 and samtools", 
                "\n\twith the minimap2_install() function.",
                "\n\twith the samtools_install() function.")
    }
}