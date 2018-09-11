---
title: 'rcites: An R package to access the CITES Speciesplus database'
authors:
- affiliation: 1
  name: Jonas Geschke
  orcid: 0000-0002-5654-9313
- affiliation: 2
  name: Kevin Cazelles
  orcid: 0000-0001-6619-9874
- affiliation: 3
  name: Ignasi Bartomeus
  orcid: 0000-0001-7893-4389
date: "12 August 2018"
bibliography: paper.bib
tags:
- CITES species+
- taxonomy
- endangered species
- illegal wildlife trade
- species legislation
- species distribution
affiliations:
- index: 1
  name: Museum für Naturkunde - Leibniz Institute for Research on Evolution and Biodiversity Berlin, Germany
- index: 2
  name: Department of Integrative Biology, University Of Guelph, Guelph, Ontario, Canada
- index: 3
  name: Estacion Biologica de Donana, Avda. Americo Vespucio, Isla de la Cartuja, Sevilla, Spain
---


# Introduction

The conservation of biodiversity is a complex problem strongly tight to political actions. CITES, the Convention on International Trade in Endangered Species of Wild Fauna and Flora, is a multilateral environmental agreement that was established in 1975 [@CITES_about] and aims to monitor and regulate the trade of endangered species so that their trade does not threaten the survival of the species in the wild [@CITES_about]. CITES is one of the eight main international agreements relevant to biodiversity [@CBD_biodiv-conv] and constitutes a key tool for conservationists, scientists and policy makers.

# The Speciesplus database

In 2013, the UNEP World Conservation Monitoring Centre (UNEP-WCMC) and the CITES Secretariat initiated a partnership funded by UNEP, the European Commission and the CITES Secretariat. Together, they created Speciesplus (or Species+), a comprehensive database of not only CITES listed species and their regulation status within CITES but also the species' status within the EU legislation and last but not least the species' status within the Convention on the Conservation of Migratory Species of Wild Animals (CMS) [@Speciesplus_about]. Speciesplus is publicly available at https://speciesplus.net [@UNEP]. 

# The ``rcites`` R package

With ``rcites`` we provide an R [@R] client to the Species+/CITES Checklist API, giving access to the Speciesplus database. The ability to query the Speciesplus database directly from one of the most used programming languages for data analyses will improve the efficiency and reproducibility of biodiversity conservation analysis workflows.

We provide functions to:

1. access the Speciesplus taxon concept, and thereafter
2. get a species' legislation status, both from CITES and from the European Union,
3. get a species' country-wise distribution range, as listed in Speciesplus, and
4. get the references on which a Speciesplus listing is based.

Overall information about ``rcites`` and the package vignette can be found at https://ibartomeus.github.io/rcites/. The package is available for download from CRAN (stable version; https://cran.r-project.org/package=rcites) and Github (development version; https://github.com/ibartomeus/rcites).

``rcites`` will support researchers and national authorities in more efficiently dealing with taxonomy information of endangered species and their legislation status.

Recent publications with data extraction from the Speciesplus database illustrate in what kind of research the package may be of help [@Hinsley:2018; @Robinson:2018]. In the spirit of CITES, taxonomic research in regard to illegal wildlife trade may be pointed out especially [@Zhou:2016; @Ingram:2015; @Zhou:2015].


# Acknowledgments

Many thanks to the British Ecological Society for bringing us together during the "Ecology Hackathon: Developing R Packages for Accessing, Synthesizing and Analysing Ecological Data", part of the BES, GfÖ, NecoV and EEF Joint Annual Meeting 2017 "Ecology Across Borders". Also, thanks to our hackathon group for the fruitful discussions and contributions to the package.


# References
