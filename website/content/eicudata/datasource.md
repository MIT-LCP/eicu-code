+++
date = "2015-09-01T19:34:46-04:00"
title = "Interfaces"
linktitle = "Interfaces"
weight = 3
toc = "true"

[menu]
  [menu.main]
    parent = "Data details"

+++

# Data interfaces

Data from each patient is collected into a common warehouse only if certain "interfaces" are available. Each interface is used to transform and load a certain type of data: vital sign interfaces incorporate vital signs, laboratory interfaces provide measurements on blood samples, and so on. It is important to be aware that different care units may have different interfaces in place, and that the lack of an interface will result in no data being available for a given patient, even if those measurements were made in reality.

<!-- ## Vital signs interface

All patients have a vital sign interface.

## Laboratory interface

Almost all patients have a laboratory interface.

## Inputs/Outputs interface

TBD. -->
