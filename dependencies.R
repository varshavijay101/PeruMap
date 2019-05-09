# List the package and version as below
dependencies <- read.csv(textConnection("
                Package,     Min.Version, repo
                shiny,       1.3.2,
                leaflet,     2.0.2,
                sf,          0.7-4,
                dplyr,       0.8.0.1,
                htmlwidgets, 1.3,
                htmltools,   0.3.6,
                fs,          1.3.1
                "), stringsAsFactors = FALSE, strip.white = TRUE)



## No changes necessary below. ##

# Import installed package versions
pkgs <- installed.packages()
rownames(pkgs) <- c()
pkgs <- data.frame(pkgs, stringsAsFactors = FALSE)

# Compare requirements to installed packages
pkgs <- merge(dependencies, pkgs, by="Package", all.x=TRUE)

# Filter out packages meeting minimum version requirement
pkgs <- pkgs[mapply(compareVersion, pkgs$Min.Version, pkgs$Version) > 0, ]

# Install missing and newer packages
cran <- pkgs[is.na(pkgs$repo), ]
lapply(cran$Package, install.packages)
github <- pkgs[!is.na(pkgs$repo), ]
lapply(github$repo, devtools::install_github)

# Require dependencies [optional]
lapply(dependencies$Package, require, character.only=TRUE)

