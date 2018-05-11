all: Transfer_data_MPT_18_Impeller_0002_ref_APS_ok.ttl

# source: https://stackoverflow.com/questions/241579/what-is-the-easiest-or-most-effective-way-to-convert-months-abbreviation-to-a-n/241589#241589
%.cleaned.csv: %.csv
	perl -pe 'BEGIN { %mon2num = qw(Jan 1	Feb 2	Mar 3	Apr 4	May 5	Jun 6	Jul 7	Aug 8	Sep 9	Oct 10	Nov 11	Dec 12); } s/^([0-9]{2})-([[:alpha:]]{3})-([0-9]{4})/sprintf("%s-%02d-%s", $$3, $$mon2num{"Sep"}, $$1)/e' $< > $@

# retrieve CSV file from https://github.com/Fiware/showcase.IDS.ZeroDefects
%.csv:
	wget -N https://github.com/Fiware/showcase.IDS.ZeroDefects/raw/master/MM_data_output/$@

%.ttl: %.cleaned.csv mapping.sparql
	tarql -d ';' mapping.sparql $< > $@
