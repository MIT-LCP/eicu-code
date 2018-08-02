# Style guide for the eICU Code Repository

## Overview

This guide provides some general guidelines on formatting code for the eICU Code Repository. Maintaining a consistent-ish style across the repository should make the code simpler to read and reuse.

## Required header information

Please include the following header information at the top of your code:

```
-- ------------------------------------------------------------------
-- Title: Short descriptive title.
-- Description: More detailed description explaining the purpose.
-- eICU version: Version of eICU Collaborative Research Database (e.g. v1.1). 
-- References: References to relevant academic papers etc (optional). 
-- ------------------------------------------------------------------
```

We would also recommend adding in any relevant references or usage notes in the top of the query.

Please don't include author names or dates, which are tracked in the commit history.

## SQL

- Always use uppercase for the reserved keywords like SELECT and WHERE.
- Use lower case for other words such as table and column names.

For more detail, following the guidelines at: http://www.sqlstyle.guide/

## Python

Following PEP8 guidelines is recommended. Read more here: https://www.python.org/dev/peps/pep-0008/
