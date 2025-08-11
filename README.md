# 📊 Indonesia's Tax Policy Analysis: A LaTeX Academic Review

[![LaTeX](https://img.shields.io/badge/LaTeX-Project-blue?style=flat-square&logo=latex)](https://www.latex-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Academic](https://img.shields.io/badge/Type-Academic%20Analysis-green?style=flat-square)](/)
[![Language](https://img.shields.io/badge/Language-Bahasa%20Indonesia-red?style=flat-square)](/)

> **A LaTeX-based review of two Kompas.id articles on Indonesia's VAT reform**  
> *Written for Economic Analyst Intern (Batch 3–2025) technical test at Harian Kompas*

---

## 🎯 **Project Overview**

This repository contains a LaTeX-based review of two articles by **Budiawan Sidik Arifianto** published on *Kompas.id*, examining Indonesia's VAT (PPN) reform debate. It contains my LaTeX source files (and the compiled PDF), data visualizations created using RStudio, and policy analysis  originally prepared for a writing-focused technical assesment.

The articles reviewed are “[Kunci Pembangunan Ekonomi Bukan Hanya Soal Besaran Pajak, Melainkan Juga Tata Kelolanya](https://www.kompas.id/artikel/kunci-pembangunan-ekonomi-bukan-hanya-soal-besaran-pajak-melainkan-juga-tata-kelolanya)” and “[Kebijakan Pajak yang Rasional Menstimulasi Kemajuan Ekonomi Nasional](https://www.kompas.id/artikel/kebijakan-pajak-yang-rasional-menstimulasi-kemajuan-ekonomi-nasional)”.

### 📝 **Technical Features**
- **Document Type**: Academic article review in LaTeX format
- **Template Base**: Customized from APSR (American Political Science Review) submission template
- **Analysis Focus**: Critical examination of selected Kompas.id articles
- **Technical Scope**: Custom data tables, TikZ diagrams, and BibTeX references
- **Assessment Purpose**: Demonstrates analytical and advanced typesetting skills

---

## 📚 **Document Structure**

```
📄 main.tex                 # Main document controller
├── 📄 Referensi.bib        # Bibliography database
├── 📄 template_artikel.cls # Custom LaTeX class file
├── 📄 R_visualization.R    # Data analysis & visualization
├── 📁 sections/            # Document sections
│   ├── 00_abstract.tex     # Executive summary
│   ├── 01_introduction.tex # Research context & motivation
│   ├── 02_summary.tex      # Article summaries
│   ├── 03_analysis.tex     # Critical evaluation
│   └── 05_conclusion.tex   # Findings & implications
└── 📄 README.md            # Project documentation
```

---

## 🔍 **Analysis Framework**

| Component | Description |
|-----------|-------------|
| **Article Review** | Systematic analysis of two selected Kompas.id articles on tax policy |
| **Fiscal Paradox** | Examination of Indonesia's tax governance challenges |
| **International Comparison** | Benchmarking against ASEAN and emerging market countries |
| **Policy Critique** | Critical evaluation of proposed VAT reform approaches discussed in two Kompas.id articles |

---

## 📊 **Technical Implementation**

### 🎨 **LaTeX Features**
- **Custom Template**: APSR (American Political Science Review) template customized and adapted for Indonesian academic standards
- **TikZ Diagrams**: Self-created complex causal relationship visualizations
- **Data Tables**: Custom-formatted comparative international tax performance data
- **BibTeX Integration**: APA-style citations with Indonesian localization
- **Advanced Typography**: Professional footnote system and cross-referencing

### 📈 **Data Sources & Visualization**
```r
# Self-created R visualizations from official datasets:
- ICTD/UNU-WIDER Government Revenue Dataset
- World Governance Indicators (WGI)
- Heritage Foundation Economic Freedom Index
- IMF Fiscal Capacity Database
- Kompas Survey Data (December 2024)

# All R code and visualizations are original work
```

### 🛠️ **Required Packages**
```latex
\usepackage{amsmath}          % Mathematical typesetting
\usepackage{graphicx}         % Image inclusion
\usepackage{tikz}             % Diagram creation
\usepackage[natbibapa]{apacite} % APA citations
\usepackage[hidelinks]{hyperref} % PDF links
```

---

## 📋 **Prerequisites**

### **LaTeX Distribution**
```bash
# Ubuntu/Debian
sudo apt-get install texlive-full

# macOS
brew install --cask mactex

# Windows
# Download MiKTeX from https://miktex.org/
```

### **R Environment** (for data visualization)
```r
# Required R packages
install.packages(c("ggplot2", "viridis", "corrplot", 
                   "patchwork", "dplyr", "tidyr"))
```

---

## ⚡ **Quick Start**

### **1. Clone Repository**
```bash
git clone https://github.com/adinramaadin/LaTeX_KompasArticleReview.git
cd LaTeX_KompasArticleReview
```

### **2. Compile Document**
```bash
# Method 1: Standard compilation
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex

# Method 2: Using latexmk (recommended)
latexmk -pdf main.tex
```

### **3. Generate Visualizations**
```bash
# Run R analysis script
Rscript R_visualization.R
```

---

## 📖 **Key Analysis Points**

### 🔑 **Main Research Questions**

> How can Indonesia address the fundamental tension between needing fiscal resources to improve tax administration while requiring better administration to generate those resources?

### 📊 **Empirical Findings**
- **Tax Performance Gap**: Indonesia's 10.4% tax-to-GDP ratio vs. regional averages
- **Governance Correlation**: Relationship between institutional quality and tax capacity  
- **Public Resistance**: Cross-sectional opposition to VAT increases
- **International Benchmarks**: Comparative analysis with ASEAN neighbors

### 🌏 **Comparative Data**
| Country | VAT Rate | Tax-to-GDP | Governance Index |
|---------|----------|------------|------------------|
| **Thailand** | 7% | 15.14% | 0.18 |
| **Vietnam** | 10% | 12.8% | -0.31 |
| **Singapore** | 8% | 12.03% | 2.24 |
| **Indonesia** | 11% | 10.4% | -0.18 |

---

## 🎓 **Academic Context**

### **Literature Integration**
- Fiscal capacity theory (Brautigam et al., 2008)
- State-building and taxation (Chang, 2011)  
- Tax tipping point research (Gaspar et al., 2016)
- Institutional economics framework

### **Methodological Approach**
- **Literature Synthesis**: Comprehensive review and integration of existing fiscal capacity research
- **Comparative Analysis**: Cross-national benchmarking using government datasets
- **Advanced LaTeX Typesetting**: Professional academic document preparation
- **Data Visualization**: R-based charts and statistical analysis from official sources

---

## 👤 **Author Information**

**Farhan Aditya Ramadhan**  
📧 adin.ramaadin@gmail.com  
🎓 Universitas Indonesia  

### **Project Context**
- **Purpose**: Prepared for a writing-focused technical assessment
- **Skills Demonstrated**: LaTeX typesetting, data analysis, policy critique

---

## 📄 **Citation**

```bibtex
@article{ramadhan2025tax,
    title={Ulasan Artikel: Dilema Perpajakan Indonesia dalam Dua Perspektif Budiawan Sidik Arifianto},
    author={Ramadhan, Farhan Aditya},
    institution={Universitas Indonesia},
    year={2025},
    type={Article Review},
}
```

---

## 📁 **File Descriptions**

- `main.tex` - Primary LaTeX document controlling compilation process
- `Referensi.bib` - BibTeX bibliography database with academic references
- `template_artikel.cls` - Customized LaTeX class adapted from APSR submission template
- `R_visualization.R` - Self-created data analysis script with original visualizations
- `sections/` - Modular LaTeX files organized by document sections
- `README.md` - Project documentation and usage guide

---

## 🛠️ **Technical Notes**

### **Compilation Requirements**
- Full LaTeX distribution (TexLive, MiKTeX, or MacTeX)
- BibTeX for reference management
- R environment for visualization generation

### **Output Format**
- PDF document with embedded fonts and hyperlinks
- Professional academic formatting
- Integrated charts and diagrams

---

## 📜 **License**

This project is available under the MIT License for educational and academic purposes.

### **Usage Guidelines**
- ✅ **Academic Use**: Freely available for research and learning
- ✅ **Attribution**: Please cite when referencing this work
- ✅ **Modification**: Adapt for similar analysis projects
- ⚠️ **Assessment Integrity**: Do not copy for academic assessments

---

## 📞 **Contact**

- **GitHub Issues**: [Project Issues](https://github.com/adinramaadin/LaTeX_KompasArticleReview/issues)
- **Email**: adin.ramaadin@gmail.com
- **Academic**: Universitas Indonesia

---

<div align="center">

**⭐ If this project was helpful for your LaTeX or policy analysis work, please consider starring it!**

[![GitHub stars](https://img.shields.io/github/stars/adinramaadin/LaTeX_KompasArticleReview?style=social)](https://github.com/adinramaadin/LaTeX_KompasArticleReview/stargazers)

*Created for Indonesian policy research and academic excellence*

</div>
