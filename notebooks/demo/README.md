# Tutorials using the demo dataset

These tutorials use a demo of the eICU-CRD. This dataset contains 1000 patients who eventually died, but not necessarily during their first ICU stay. The demo allows users to quickly access and investigate a subset of eICU-CRD before getting approval for the full dataset.

## Downloading the demo

The demo is available on PhysioNetWorks:
https://physionet.org/works/eICUCollaborativeResearchDatabaseDemo/

You will need a PhysioNetWorks account to access this page, which you can register for instantly.

If this is the first time you are visiting the page, you will be asked if you agree to certain conditions of access to the data. If you agree, click "I agree".

There are two options for downloading the demo: as a collection of comma separated value (CSV) files, or as a single SQLite file. We will use the latter option. Download the `eicu_demo.sqlite` file, and move it to this directory afterward.

And that's it! You will now be able to run all the notebooks in this folder, and navigate the data using software which can open SQLite database files. If you are unsure what software you could use, we go over one option in the following section.

## Mozilla FireFox + SQLite Manager

We have found SQLite Manager, an extension for the Mozilla FireFox browser, to be a useful tool for navigating SQLite files. Installation is fairly straightforward.

1. Download and install the latest Mozilla FireFox browser: https://www.mozilla.org/firefox/
2. Open FireFox and navigate to: https://addons.mozilla.org/en-US/firefox/
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/sqlite_search.png" height="200">
3. Search for "sqlite" (no quotes)
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/sqlite_addtofirefox.png" height="200">
4. Look for "SQLite Manager" (should be the top hit) and click the "Add to FireFox" button on the right side
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/add_sqlite.png" height="200">
5. Click "Install" at the top left
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/install_addon.png" height="200">
6. Restart FireFox
7. Add the SQLite Manager button to your menu
  1. Click the "Customize" button in the FireFox menu (the three bars on the right)
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/add_sqlite.png" height="200">
  2. Drag the "SQLite Manager" button from the left to the dashed empty box on the right (see below).
<img align = "right" src="https://raw.githubusercontent.com/MIT-LCP/eicu-code/master/tutorials/demo/img/drag_button.png" height="200">

Once the extension has been installed, open SQLite manager and click "Database -> Connect to database", then navigate to where you saved the SQLite file and open it. You should now be able to navigate all the tables in the demo.
