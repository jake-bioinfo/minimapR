% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/minimapR-helper.R
\name{minimap2_installation}
\alias{minimap2_installation}
\title{minimap2_installation}
\usage{
minimap2_installation(source_directory, verbose = TRUE, return = FALSE)
}
\arguments{
\item{source_directory}{Source directory to install minimap2. Do not include minimap2 name in the
source directory. Note that this must be entered as a full path location.}

\item{verbose}{Logical value to print progress of the installation}

\item{return}{This logical value causes the \code{minimap2_install} function to return the path of minimap2}
}
\value{
This function returns the path of the installed 'minimap2' tool (character).
}
\description{
This function prints installation instructions specific to the user's operating system.
}
\examples{
\dontrun{
install_dir <- file.path("/dir/to/install")
minimap2_path <- minimap2_installation(source_directory = install_dir, verbose = FALSE)
}
}
