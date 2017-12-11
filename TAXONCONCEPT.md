#Description of Taxon Concept
#Lists taxon concepts - The following taxon concept fields are returned:

(Source: http://api.speciesplus.net/documentation/v1/taxon_concepts/index.html)

- id
unique identifier of a taxon concept

- full_name
scientific name [max 255 characters]

- author_year
author and year (parentheses where applicable) [max 255 characters]

- rank
one of KINGDOM, PHYLUM, CLASS, ORDER, FAMILY, SUBFAMILY, GENUS, SPECIES, SUBSPECIES, VARIETY [max 255 characters]

- name_status
A for accepted names, S for synonyms (both types of names are taxon concepts in Species+) [max 255 characters]

- updated_at
timestamp of last update to the taxon concept in Species+

- active
if false, taxon concept has been deleted

- synonyms
list of synonyms (only for accepted names, i.e. name_status == A) [full_name, author_year and rank follow the same length constraints as respective properties of the main taxon concept]

- higher_taxa
object that gives scientific names of ancestors in the taxonomic tree (only for active accepted names) [higher taxa names follow the same length constraint as full_name of the main taxon concept]

- common_names
list of common names (with language given by ISO 639-1 code; only for accepted names) [name, language max 255 characters]

- cites_listing
value of current CITES listing (as per CITES Checklist). When taxon concept is removed from appendices this becomes NC. When taxon is split listed it becomes a concatenation of appendix symbols, e.g. I/II/NC (only for accepted names) [max 255 characters]
In the event of removal from CITES appendices, a taxon is not deleted from the Species+ DB. As a historically listed taxon it remains in the database, and in most cases the value of current CITES listing becomes 'NC'. In some cases the value is affected by listed subspecies, e.g. Pseudomys fieldi has been removed from Appendix I, but since there is a listed subspecies, the current listing is 'I/NC'.

- cites_listings
list of current CITES listings with annotations (there will be more than one element in this list in case of split listings; only for accepted names) [appendix max 255 characters; annotation, hash_annotation unlimited length]

- accepted_names
list of accepted names (only for synonyms, i.e. name_status == S) [full_name, author_year and rank follow the same length constraints as respective properties of the main taxon concept]