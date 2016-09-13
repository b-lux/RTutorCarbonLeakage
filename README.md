This package constitutes an interactive R problem set based on the RTutor package (https://github.com/skranz/RTutor). 

RTutor problem set replicating the findings of the paper “Industry Compensation under Relocation Risk: A Firm-Level Analysis of the EU Emissions Trading Scheme” by Ralf Martin, Mirabelle Muûls, Laure B. de Preux and Ulrich J. Wagner (2014). Published in American Economic Review 2014, 104(8): 2482–2508 (https://www.aeaweb.org/articles.php?doi=10.1257/aer.104.8.2482).

## 1. Installation

RTutor and this package is hosted on Github. To install everything, run the following code in your R console.
```s
if (!require(devtools))
  install.packages("devtools")
source_gist("gist.github.com/skranz/fad6062e5462c9d0efe4")
install.rtutor(update.github=TRUE)

devtools::install_github("b-lux/RTutorCarbonLeakage", upgrade_dependencies=FALSE)
```

## 2. Show and work on the problem set
To start the problem set first create a working directory in which files like the data sets and your solution will be stored. Then adapt and run the following code.
```s
library(RTutorCarbonLeakage)

# Adapt your working directory to an existing folder
setwd("C:/problemsets/RTutorCarbonLeakage")
# Adapt your user name
run.ps(user.name="Jon Doe", package="RTutorCarbonLeakage",
       load.sav=TRUE, sample.solution=FALSE)
```
If everything works fine, a browser window should open, in which you can start exploring the problem set.
