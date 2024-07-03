## minimapR-helper.R
## LICENSE: MIT License

## Install minimap2 from Heng Li's github repository
### Requires: git2r
### Source directory should not include minimap2 name
#' @title minimap2_install
#'
#' @description Install \code{minimap2} from Heng Li's github repository. If using a Windows operating system, installation of the MSYS2 Linux emulator is required.
#'
#' @param source_directory Source directory to install minimap2. Do not include minimap2 name in the
#'  source directory. Note that this must be entered as a full path location.
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @return If '\code{minimap2}' is not installed, this function installs it on linux and returns the path of the installed '\code{minimap2}' tool (character). 
#' @examples
#' \dontrun{
#' install_dir <- file.path("/dir/to/install")
#' minimap2_path <- mm2_install(source_directory = install_dir, verbose = FALSE)
#' }
#' @export
#' @import git2r
mm2_install <- function(source_directory, verbose = TRUE, return = FALSE) {
  # Check if minimap2 is already installed
  check <- Sys.which("minimap2")
  if (nchar(check) <= 1) {
    # Install minimap2
    install_dir <- paste0(source_directory, "/minimap2")
    if (!dir.exists(install_dir)) {
      dir.create(install_dir)
    }

    if (verbose) {
      cat("Installing minimap2 to directory", install_dir, "...")
    }

    # Git clone minimap
    download_out <- tryCatch({git2r::clone(
          url = "https://github.com/lh3/minimap2",
          local_path = install_dir,
          progress = TRUE
        )}, 
        error = function(e) {
          cat("Error downloading minimap2: ", e)
        },
        warn = function(w) {
          cat("Warning downloading minimap2: ", w)
        },
        finally = function(f) {
          cat("minimap2 successfully downloaded.")
        })

    print(download_out)

    # Install minimap2
    install_out <- tryCatch(
      {
        system(paste0("cd ", install_dir, " && make"), intern = TRUE)
      },
      error = function(e) {
        cat("Error installing minimap2: ", e)
      },
      warn = function(w) {
        cat("Warning installing minimap2: ", w)
      },
      finally = function(f) {
        cat("minimap2 successfully installed.")
      }
    )

    print(install_out)

    # Add minimap2 to PATH
    cat(
      "Please add minimap2 ", install_dir, " to .bashrc or respective windows path.",
      "\n\texport PATH=$PATH:", install_dir, "\n"
    )

    if (return == TRUE) {
      return(paste0("export PATH=$PATH:", install_dir))
    }
  } else {
    cat("minimap2 is already installed.")
  }
}

## Check path of minimap2 and if installed
## If return is true then the path of the executable is returned
##   given that minimap2 is installed
#' @title minimap2_check
#' @description Check if minimap2 is installed
#' @param return Logical value to return the path of minimap2
#' @return If minimap2 is installed, this function returns the path of minimap2 (character).
#' @examples
#' minimap2_check(return = TRUE)
#'
#' @export
minimap2_check <- function(return = TRUE) {
  check <- Sys.which("minimap2")
  if (nchar(check) > 1) {
    cat("minimap2 is installed.")
    if (return == TRUE) {
      return(Sys.which("minimap2"))
    }
  } else {
    cat(
      "minimap2 is not installed.",
      "\nPlease run minimap2_installation() to install minimap2."
    )
  }
}

## Install samtools with conda
### Requires: conda
#' @title samtools_install
#' @description Install samtools with conda
#' @param verbose Logical value to print progress of the installation
#' @return If '\code{samtools}' is not installed, this function installs it on linux and returns the path of the installed \code{'samtools'} tool (character).
#' @examples
#' \dontrun{
#' samtools_install()
#' }
#'
#' @export
samtools_install <- function(verbose = TRUE) {
  # Check if samtools is already installed
  check <- Sys.which("samtools")
  if (nchar(check) <= 1) {
    if (!is.null(Sys.which("samtools"))) {
      # Install samtools
      if (verbose) {
        cat("\nInstalling samtools with conda ...")
      }
      Sys.sleep(3)

      # Install samtools
      install_out <- tryCatch(
        {
          system(paste0("conda install -c bioconda -y samtools"),
            intern = TRUE
          )
        },
        error = function(e) {
          cat("Error installing samtools: ", e)
        },
        warn = function(w) {
          cat("Warning installing samtools: ", w)
        },
        finally = function(f) {
          cat("samtools successfully installed.")
        }
      )

      # Print output
      print(install_out)

      # Add samtools to PATH
      cat("Samtools successfully installed.")
    } else {
      cat("samtools is already installed.")
    }
  }
}

## Checks if samtools is installed
## If return is true then the path of the executable is returned
##   given that samtools is installed
#' @title samtools_check
#' @description Check if samtools is installed
#' @param return Logical value to return the path of samtools
#' @return If '\code{samtools}' is installed, this function returns the path of samtools (character).
#' @examples
#' samtools_check(return = TRUE)
#'
#' @export
#' @import Rsamtools
samtools_check <- function(return = TRUE) {
  check <- Sys.which("samtools")
  if (nchar(check) > 1) {
    cat("samtools is installed.")
    if (return == TRUE) {
      return(Sys.which("samtools"))
    }
  } else {
    cat(
      "samtools is not installed.",
      "\nPlease run samtools_install() or minimap2_installation to install samtools."
    )
  }
}

# Function for OS-specific documentation and installation
#' @title minimap2_installation
#' @description This function prints installation instructions specific to the user's operating system.
#' @param source_directory Source directory to install minimap2. Do not include minimap2 name in the
#'  source directory. Note that this must be entered as a full path location.
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @returns This function returns a character.
#'  source directoryro
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @returns Character value that is the path of the installed 'minimap2' tool.
#'  source directory
#' @param verbose Logical value to print progress of the installation
#' @param return This logical value causes the \code{minimap2_install} function to return the path of minimap2
#' @return This function returns the path of the installed 'minimap2' tool (character).
#' @examples
#' \dontrun{
#' install_dir <- file.path("/dir/to/install")
#' minimap2_path <- minimap2_installation(source_directory = install_dir, verbose = FALSE)
#' }
#' @export
#' @import git2r
minimap2_installation <- function(source_directory, verbose = TRUE, return = FALSE) {
  # Check if minimap2 is already installed
  minimap2_path <- file.exists(Sys.which("minimap2"))
  if (.Platform$OS.type == "windows") {
    if (!minimap2_path) {
      cat("minimap2 is not installed on your system, detailed installation instructions are provided below.\n")
      cat("Documentation for Windows install:\n")
      cat("1. Install the 'MSYS2' Linux emulator.\n")
      cat("2. In the 'MSYS2' terminal, type 'pacman -Syu'\n")
      cat("3. In the 'MSYS2' terminal, type 'pacman -S mingw-w64-x86_64-samtools autotools gcc'\n")
      cat("4. In the 'MSYS2' terminal, type 'add C:\\msys64\\mingw64\\bin to windows PATH'\n")
      cat("5. To install 'minimap2': \n\t")
      cat("a) In the 'MSYS2' terminal, type 'git clone https://github.com/lh3/minimap2' \n\t")
      cat("b) In the 'MSYS2' terminal, type 'cd minimap2 && make' \n")
      cat("6. Create symbolic link to 'MSYS2' command: 'ln -s ~/minimap2/minimap2 C:/mingw64/bin'\n")
    } else {
      cat("'minimap2' is already installed. \n")
    }
  } else if (.Platform$OS.type == "unix" && Sys.info()["sysname"] != "Darwin") {
    if (!minimap2_path) {
      cat("minimap2 is not installed on your system, installing now...\n")
      Sys.sleep(3)
      file_path <- mm2_install(source_directory, verbose = verbose, return = return)
      Sys.sleep(5)
      samtools_install(verbose = verbose)
      if(return == TRUE) {
        return(file_path)
      }
    } else {
      cat("'minimap2' is already installed.\n")
    }
  } else if (Sys.info()["sysname"] == "Darwin") {
    cat("Documentation for macOS:\n")
    # Add macOS specific instructions here
  } else {
    cat("Documentation for other OS:\n")
    # Add other OS specific instructions here
  }
}