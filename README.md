# Numerical Simulations of Dusty Colliding Wind Binaries

This is my GitHub repo containing an up-to-date copy of my thesis, which covers Colliding Wind Binary systems.

Read the thesis here: [Numerical Simulations of Dusty Colliding Wind Binaries](https://raw.githubusercontent.com/atomsite/Thesis/master/Thesis.pdf)

## Style Guide

This is more for my reference, and is a series of best practices for various styles in my Thesis

### Units
- Unless more natural units are otherwise used, all data will be presented in CGS forms
  - Other important units:
    - AU: Astronomical Unit
    - Msol: Solar Mass
    - 

### Tables
- Tables should contain hlines at the beginning and end, which another hline after the column headers
- Column headers should be bold, but not column header units
- Column header units should be in their own row
- Centered text as much as possible
- `[h]` alignment to be used for tables as much as possible

### Figures and Data
- For single figures, 5x3 inches will be used, 5x4 for double plots with joined `x` axes
- Each line plot will be rendered with `gnuplot` using the `cariolatex` terminal, **all** gnuplot files will be stored in this repo, as well as copies of each diagram and container diagram
- Likewise, simple data will be stored in this repo, numerical models will not be due to space constraints
- Raw data from Athena++ history files will be filtered and appropriately scaled, automatically generated gnuplot files will be kept
- `[h]` alignment to be used for figures as much as possible

### Referencing and Citations
- Citations to be carried out using `biber`, `bibLaTeX`
- All management to be done with Zotero
- Keep an eye out for capitalisations in titles
- Reference list to be split into books and other references, as books are used heavily in this thesis

- Sections labelled with prefix `sec:`
- Figures to be labelled with prefix `fig:`
- Equations to be labelled with prefix `eq:`
- Tables to be labelled with prefix `tab:`

- All important symbols to be added to list of common symbols at the start of the thesis, with a link to either the section explaining the symbol or the equation deriving them, whichever is more useful
- Same with acronyms!