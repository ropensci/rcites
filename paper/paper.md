---
title: 'citesr: An R package to access the CITES Speciesplus database'
tags:
- CITES
- trade
- endangered species
authors:
- name: Jonas Geschke
  orcid: 0000-0002-5654-9313
  affiliation: 1
- name: Ignasi Bartomeus
  orcid: 0000-0001-7893-4389
  affiliation: 2
- name: Kevin Cazelles
  orcid: 0000-0001-6619-9874
  affiliation: 3
affiliations:
  - name: "Museum für Naturkunde - Leibniz Institute for Research on Evolution and Biodiversity Berlin, Germany"
    index: 1
  - name:  Department of Integrative Biology, University Of Guelph, Guelph, Ontario, Canada N1G 2W1.
    index: 2
  - name: "Estacion Biologica de Donana (EBD-CSIC), Avda. Americo Vespucio s/n, Isla de la Cartuja, E-41092 Sevilla, Spain"
    index: 3
date: 09 July 2018
bibliography: paper.bib
output: pdf_document
---

# Introduction

In 1992, the United Nations Conference on Environment and Development (UNCED) took place in Rio de Janeiro. This conference also is known as Rio Conference, where three major agreements were agreed on: The Convention on Biological Diversity (CBD), the Framework Convention on Climate Change (UNFCCC) and the United Nations Convention to Combat Desertification (UNCCD). With this, biodiversity, its conservation and sustainable use got a highly discussed policital issue.

However, the issue of endangered species and their trade already was politically important far before the Rio Conference with its broad media response. CITES, the Convention on International Trade in Endangered Species of Wild Fauna and Flora, already was established in 1975 [@CITES_about]. On the CBD website, CITES is listed as one of the eight main international conventions relevant to biodiversity [@CBD_biodiv-conv]. It aims to monitor and regulate the trade of endangered spcies so that their trade does not threaten the survival of the species [@CITES_about].

# The Speciesplus database

In 2013, the UNEP World Conservation Monitoring Centre (UNEP-WCMC) and the CITES Secretariat initiated a partnership funded by UNEP, the European Commission and the CITES Secretariat, which puts together a comprehensive database of not only CITES listed species and their status within CITES but also the species' status within the EU legislation and last but not least the species' status within the Convention on the Conservation of Migratory Species of Wild Animals (CMS) [@Speciesplus_about]. The database, called Species+ or Speciesplus, is publicly availably at https://speciesplus.net.

# The citesr package

With citesr we provide an R package that gives access to the Speciesplus database. We provide functions to directly access the species' country-wise distribution, the species' legislation status within CITES, as well as the species' legislation status within the EU. The package is available at https://github.com/ibartomeus/citesr.

Citesr may support researchers and national authorities in more efficiently dealing with taxonomy information of endangered species, their legislation status as well as their distribution range and trade status. Recent publications with data extraction from the Speciesplus database illustrate how citesr can be used [@Robinson:2018, @Hensz:2018, @Hinsley:2018].

# Acknowledgements

Many thanks to the British Ecological Society for bringing us together during the "Ecology Hackathon: Developing R Packages for Accessing, Synthesizing and Analysing Ecological Data" part of the BES, GFÖ, NecoV and EEF Joint Annual Meeting 2017: Ecology Across Borders.


----- just for background info -----
- A summary describing the high-level functionality and purpose of the software
for a diverse, non-specialist audience
- A clear statement of need that illustrates the purpose of the software
- A list of key references including a link to the software archive
- Mentions (if applicable) of any ongoing research projects using the software
or recent scholarly publications enabled by it

JOSS welcomes submissions from broadly diverse research areas. For this reason, we request that authors include in the paper some sentences that would explain the software functionality and domain of use to a non-specialist reader. Your submission should probably be somewhere between 250-1000 words.
https://joss.readthedocs.io/en/latest/submitting.html
----- just for background info -----

# References
