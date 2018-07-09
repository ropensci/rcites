---
title: 'citesr: An R package to access the CITES Speciesplus database'
tags:
- CITES species+
- taxonomy
- endangered species
- illegal wildlife trade
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
---

# Introduction

Biodiversity, its conservation and sustainable use are a highly policital issue.

CITES, the Convention on International Trade in Endangered Species of Wild Fauna and Flora, is a multilateral environmental agreement that was established in 1975 [@CITES_about] and today is one of the eight main international agreements relevant to biodiversity [@CBD_biodiv-conv]. It aims to monitor and regulate the trade of endangered spcies so that their trade does not threaten the survival of the species in the wild [@CITES_about].

# The Speciesplus database

In 2013, the UNEP World Conservation Monitoring Centre (UNEP-WCMC) and the CITES Secretariat initiated a partnership funded by UNEP, the European Commission and the CITES Secretariat. Together, they created Speciesplus (or Species+), a comprehensive database of not only CITES listed species and their status within CITES but also the species' status within the EU legislation and last but not least the species' status within the Convention on the Conservation of Migratory Species of Wild Animals (CMS) [@Speciesplus_about]. Speciesplus is publicly availably at https://speciesplus.net [@UNEP].

# The ``citesr`` package

With ``citesr`` we provide an R package that gives access to the Speciesplus database. We provide functions to

1. access the Speciesplus taxon concept,
2. get a species' legislation status, both from CITES and from the European Union,
3. get a species' country-wise distribution range, as listed in Speciesplus, and
4. get the references that a Speciesplus listing is based on.

``citesr`` is available at Github (https://github.com/ibartomeus/citesr) and CRAN (?).

``citesr`` may support researchers and national authorities in more efficiently dealing with taxonomy information of endangered species and their legislation status. Recent publications with data extraction from the Speciesplus database illustrate in what kind of research the package may be of help [@Hinsley:2018; @Robinson:2018]. In the spirit of CITES, taxonomic research in regard to illegal wildlife trade may be pointed out especially [@Zhou:2016; @Ingram:2015; @Zhou:2015].

# Acknowledgements

Many thanks to the British Ecological Society for bringing us together during the "Ecology Hackathon: Developing R Packages for Accessing, Synthesizing and Analysing Ecological Data" part of the BES, GFÖ, NecoV and EEF Joint Annual Meeting 2017 "Ecology Across Borders". Also, thanks to our hackathon group for the fruitful discussions about the very early stages of the package.


----- just for background info -----
JOSS welcomes submissions from broadly diverse research areas. For this reason, we request that authors include in the paper some sentences that would explain the software functionality and domain of use to a non-specialist reader. Your submission should probably be somewhere between 250-1000 words.

In addition, your paper should include:

A list of the authors of the software and their affiliations
A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience
A clear statement of need that illustrates the purpose of the software
A list of key references including a link to the software archive
Mentions (if applicable) of any ongoing research projects using the software or recent scholarly publications enabled by it

https://joss.readthedocs.io/en/latest/submitting.html
----- just for background info -----

# References
