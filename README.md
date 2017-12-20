# dgidb

### IMPORTANT NOTE:
This script **does not duplicate** the DGIDB API for these databases and should not be used as an exact replacement.
For discussion, see https://github.com/UCSC-Treehouse/protocol/issues/59 .

--------

Scripts to extract gene to drug interactions from (dgidb)[http://www.dgidb.org/] into tsv for use in
the Treehouse tertiary analysis protocol.

See the Makefile for details but on a bare machine:

`make download up import extract down`

Will download the latest schema database for DGIdb, run postgres in a 
docker container, import the DGIdb data, retrieve all known drugs from the Treehouse
approved databases, and export the gene-drug correspondance to druggable\_genes.tsv.

The approved databases are :
* CIViC
* MyCancerGenomeClinicalTrial
* MyCancerGenome
* CancerCommons
