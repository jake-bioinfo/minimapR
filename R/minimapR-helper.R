## minimapR-helper.R
## LICENSE: MIT License

## Install minimap2 from Heng Li's github repository
### Requires: git2r
### Source directory should not include minimap2 name
#' @title minimap2_install
#'
#' @description Install minimap2 from Heng Li's github repository
#'
#' @param source_directory Source directory to install minimap2. Do not include minimap2 name in the 
#'  source directory
#' @param verbose Logical value to print progress of the installation
#' 
#' @return This function returns the line needed to add minimap2 to PATH
#' 
#' @examples
#' install_dir <- file.path("/dir/to/install")
#' path_line <- minimap2_install(source_directory = install_dir, verbose = FALSE)
#' @export
#' @import git2r
minimap2_install <- function(source_directory, verbose = TRUE) {
    # Check if minimap2 is already installed
    if (!is.null(Sys.which("minimap2"))) {
        # Install minimap2
        install_dir <- paste0(source_directory, "/minimap2")
        if (!dir.exists(install_dir)) {
            dir.create(install_dir)
        }

        if (verbose) {
            message("Installing minimap2 to directory", install_dir, "...")
        }

        # Git clone minimap
        download_out <- tryCatch({git2r::clone(url = "https://github.com/lh3/minimap2", 
            local_path = install_dir, 
            progress = TRUE)}, 
            error = function(e) {
                message("Error installing minimap2: ", e)
            }, warn = function(w) {
                message("Warning installing minimap2: ", w)
            }, finally = function(f) {
                message("minimap2 successfully downloaded.")
            })
        print(download_out)

        # Install minimap2
        install_out <- tryCatch({system(paste0("cd ", install_dir, " && make"), intern = TRUE)}, 
            error = function(e) {
                message("Error installing minimap2: ", e)
            }, warn = function(w) {
                message("Warning installing minimap2: ", w)
            }, finally = function(f) {
                message("minimap2 successfully installed.")
            })

        print(install_out)

        # Add minimap2 to PATH
        message("Please add minimap2 ", install_dir, " to .bashrc or respective windows path.", 
                "\n\texport PATH=$PATH:", install_dir)

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
#' minimap2_check(return == TRUE)
#'
#' @export
minimap2_check <- function(return = TRUE) {
    if (!is.null(Sys.which("minimap2"))) {
        message("minimap2 is installed.")
        if (return == TRUE) {
            return(Sys.which("minimap2"))
        }
    } else {
        message("minimap2 is not installed.",
                "\nPlease run mm2_install() to install minimap2.")
    }
}
