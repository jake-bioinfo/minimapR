## minimapR-helper.R
## LICENSE: MIT License

## Install minimap2 from Heng Li's github repository
### Requires: git2r
### Source directory should not include minimap2 name
#' @title minimap2_install
#'
#' @description Install \code{minimap2} from Heng Li's github repository
#'
#' @param source_directory Source directory to install minimap2. Do not include minimap2 name in the
#'  source directory
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#'
#' @examples
#' \dontrun{
#' install_dir <- file.path("/dir/to/install")
#' path_line <- minimap2_install(source_directory = install_dir, verbose = FALSE)
#' }
#' @export
#' @import git2r
minimap2_install <- function(source_directory, verbose = TRUE, return = FALSE) {
    # Check if minimap2 is already installed
    if (!is.null(Sys.which("minimap2")) & Sys.which("minimap2") != "") {
        # Install minimap2
        install_dir <- paste0(source_directory, "/minimap2")
        if (!dir.exists(install_dir)) {
            dir.create(install_dir)
        }

        if (verbose) {
            message("Installing minimap2 to directory", install_dir, "...")
        }

        # Git clone minimap
        download_out <- tryCatch(
            {
                git2r::clone(
                    url = "https://github.com/lh3/minimap2",
                    local_path = install_dir,
                    progress = TRUE
                )
            },
            error = function(e) {
                stop("Error downloading minimap2: ", e)
            },
            warn = function(w) {
                message("Warning downloading minimap2: ", w)
            },
            finally = function(f) {
                message("minimap2 successfully downloaded.")
            },
        )


        print(download_out)

        # Install minimap2
        install_out <- tryCatch(
            {
                system(paste0("cd ", install_dir, " && make"), intern = TRUE)
            },
            error = function(e) {
                message("Error installing minimap2: ", e)
            },
            warn = function(w) {
                message("Warning installing minimap2: ", w)
            },
            finally = function(f) {
                message("minimap2 successfully installed.")
            }
        )

        print(install_out)

        # Add minimap2 to PATH
        message(
            "Please add minimap2 ", install_dir, " to .bashrc or respective windows path.",
            "\n\texport PATH=$PATH:", install_dir
        )

        if (return == TRUE) {
            return(paste0("export PATH=$PATH:", install_dir))
        }
    } else {
        message("minimap2 is already installed.")
    }
}

## Check path of minimap2 and if installed
## If return is true then the path of the executable is returned
##   given that minimap2 is installed
#' @title minimap2_check
#'
#' @description Check if minimap2 is installed
#'
#' @param return Logical value to return the path of minimap2
#'
#' @return This function returns the path of minimap2 if installed
#'
#' @examples
#' minimap2_check(return = TRUE)
#'
#' @export
minimap2_check <- function(return = TRUE) {
    if (!is.null(Sys.which("minimap2")) & Sys.which("minimap2") != "") {
        message("minimap2 is installed.")
        if (return == TRUE) {
            return(Sys.which("minimap2"))
        }
    } else {
        message(
            "minimap2 is not installed.",
            "\nPlease run minimap2_install() to install minimap2."
        )
    }
}

## Install samtools with conda
### Requires: conda
#' @title samtools_install
#'
#' @description Install samtools with conda
#'
#' @param verbose Logical value to print progress of the installation
#'
#'
#' @examples
#' \dontrun{
#' samtools_install()
#' }
#'
#' @export
samtools_install <- function(verbose = TRUE) {
    # Check if samtools is already installed
    if (!is.null(Sys.which("samtools")) & Sys.which("samtools") != "") {
        # Install samtools
        if (verbose) {
            message("Installing samtools with conda ...")
        }

        # Install samtools
        install_out <- tryCatch(
            {
                system(paste0("conda install -c bioconda -y samtools"),
                    intern = TRUE
                )
            },
            error = function(e) {
                message("Error installing samtools: ", e)
            },
            warn = function(w) {
                message("Warning installing samtools: ", w)
            },
            finally = function(f) {
                message("samtools successfully installed.")
            }
        )

        print(install_out)

        # Add samtools to PATH
        message("Samtools successfully installed.")
    } else {
        message("samtools is already installed.")
    }
}

## Checks if samtools is installed
## If return is true then the path of the executable is returned
##   given that samtools is installed
#' @title samtools_check
#'
#' @description Check if samtools is installed
#'
#' @param return Logical value to return the path of samtools
#'
#' @return This function returns the path of samtools if installed
#'
#' @examples
#' samtools_check(return = TRUE)
#'
#' @export
#' @import Rsamtools
samtools_check <- function(return = TRUE) {
    if (!is.null(Sys.which("samtools")) & Sys.which("samtools") != ""){
        message("samtools is installed.")
        if (return == TRUE) {
            return(Sys.which("samtools"))
        }
    } else {
        message(
            "samtools is not installed.",
            "\nPlease run samtools_install() to install samtools."
        )
    }
}