+++
date = "2015-09-01T14:02:13-04:00"
title = "Times"
linktitle = "Times"
weight = 2
toc = "true"

[menu]
[menu.main]
parent = "Data details"

+++

# Times

* The time stamp of all events are stored as offsets from the time of ICU admission, in minutes. As a result, hospital admission time will in general be negative. 
* It may help to add a pre-ICU admission "fuzz" because sometimes laboratory measurements are measured pre-ICU, e.g., look at all the labs measured from (-6*24) minutes to (24*60) minutes from ICU admission.
