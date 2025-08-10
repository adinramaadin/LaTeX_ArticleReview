library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(ggthemes)
library(viridis)      # Colorblind-friendly palettes
library(patchwork)    # For combining plots
library(ggrepel)      # For better text positioning
library(corrplot)     # For correlation matrix
library(RColorBrewer) # Additional color palettes

#importing datasets
freedom <- read_excel("_1_Skripsi/Data/_1_raw data/human-freedom-index-2024.xlsx") %>% 
  select(country = ...3, 
         code = ...2,
         year = ...1,
         size_government = `A  Size of Government`,
         legal_property_rights = `B  Legal System & Property Rights -- Without Gender Adjustment`,
         sound_money = `C  Sound Money`,
         trade_freedom = `D  Freedom to trade internationally`,
         regulation = `E  Regulation`)

governance <- read_dta("_1_Skripsi/Data/_1_raw data/wgidataset_with_sourcedata.dta") %>% 
  select(country = countryname, code, year, indicator, estimate) %>% 
  pivot_wider(names_from  = indicator,
              values_from = estimate
  ) %>% 
  rename(
    gov_effectiveness      = ge,
    rule_of_law            = rl,
    regulatory_quality     = rq,
    voice_accountability   = va,
    political_stability    = pv,
    corruption_control     = cc
  )

korupsi <- read_dta("_1_Skripsi/Data/_1_raw data/vdem.dta") %>% 
  select(country = country_name, 
         code = country_text_id,
         year,
         corruption = v2x_corr)

govrevenue <- read_dta("_1_Skripsi/Data/_1_raw data/govrevenue.dta") %>% 
  select(country, code = iso, year, tax = tax_ex_sc)

democracy <- readRDS("~/_1_Skripsi/Data/_1_raw data/vdem_r.rds") %>% 
  select(country = country_name, 
         code = country_text_id,
         year,
         electoral = v2x_polyarchy,
         liberal = v2x_libdem,
         participatory = v2x_partipdem,
         deliberative = v2x_delibdem,
         egalitarian = v2x_egaldem
  )

#Merging
full_uncleaned <- freedom %>% 
  inner_join(governance %>%  select(-country), by = c("code", "year")) %>% 
  inner_join(korupsi %>%  select(-country), by = c("code", "year")) %>% 
  inner_join(govrevenue %>%  select(-country), by = c("code", "year")) %>% 
  inner_join(democracy %>%  select(-country), by = c("code", "year"))

names(full_uncleaned)
full_uncleaned %>% 
  count(country) %>% 
  print(n = Inf)

# Step 1: Calculate country averages with improved error handling
country_averages <- full_uncleaned %>%
  group_by(country) %>%
  summarise(
    tax_rate = mean(tax, na.rm = TRUE),
    gov_effectiveness = mean(gov_effectiveness, na.rm = TRUE),
    political_stability = mean(political_stability, na.rm = TRUE),
    rule_of_law = mean(rule_of_law, na.rm = TRUE),
    regulatory_quality = mean(regulatory_quality, na.rm = TRUE),
    voice_accountability = mean(voice_accountability, na.rm = TRUE),
    trade_freedom = mean(trade_freedom, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  filter(!is.na(tax_rate), 
         !is.infinite(tax_rate),
         tax_rate > 0) %>%
  # Add country classification for better insights
  mutate(
    tax_category = case_when(
      tax_rate < 15 ~ "Pajak Rendah (< 15%)",
      tax_rate < 25 ~ "Pajak Sedang (15-25%)",
      tax_rate < 35 ~ "Pajak Tinggi (25-35%)",
      TRUE ~ "Pajak Sangat Tinggi (> 35%)"
    ),
    tax_category = factor(tax_category, levels = c("Pajak Rendah (< 15%)", 
                                                   "Pajak Sedang (15-25%)", 
                                                   "Pajak Tinggi (25-35%)", 
                                                   "Pajak Sangat Tinggi (> 35%)"))
  )

# Step 2: Transform to long format with improved labeling
governance_long <- country_averages %>%
  pivot_longer(
    cols = c(gov_effectiveness, political_stability, rule_of_law, 
             regulatory_quality, voice_accountability, trade_freedom),
    names_to = "indicator",
    values_to = "score"
  ) %>%
  mutate(
    indicator_label = case_when(
      indicator == "gov_effectiveness" ~ "Efektivitas\nPemerintah",
      indicator == "political_stability" ~ "Stabilitas Politik\n& Tanpa Kekerasan",
      indicator == "rule_of_law" ~ "Supremasi Hukum",
      indicator == "regulatory_quality" ~ "Kualitas\nRegulasi",
      indicator == "voice_accountability" ~ "Suara &\nAkuntabilitas",
      indicator == "trade_freedom" ~ "Kebebasan\nPerdagangan"
    ),
    indicator_label = factor(indicator_label, levels = c(
      "Efektivitas\nPemerintah", "Stabilitas Politik\n& Tanpa Kekerasan", 
      "Supremasi Hukum", "Kualitas\nRegulasi", 
      "Suara &\nAkuntabilitas", "Kebebasan\nPerdagangan"
    ))
  )

# Step 3: Calculate correlation coefficients for each indicator
correlations <- governance_long %>%
  group_by(indicator_label) %>%
  summarise(
    correlation = cor(tax_rate, score, use = "complete.obs"),
    r_squared = correlation^2,
    .groups = 'drop'
  ) %>%
  mutate(
    corr_label = paste0("r = ", round(correlation, 3), 
                        "\nR² = ", round(r_squared, 3))
  )

# Step 4: Create the main scatter plot with enhanced features
main_plot <- governance_long %>%
  left_join(correlations, by = "indicator_label") %>%
  ggplot(aes(x = tax_rate, y = score)) +
  
  # Add confidence intervals
  geom_smooth(method = "lm", se = TRUE, 
              color = "#2166ac", fill = "#92c5de", 
              alpha = 0.3, linewidth = 1.2) +
  
  # Points with colorblind-friendly palette - LARGER POINTS
  geom_point(aes(fill = tax_category), 
             shape = 21, size = 3.5, alpha = 0.8, 
             stroke = 0.5, color = "white") +
  
  # Add correlation info to each panel - LARGER TEXT
  geom_text(data = correlations,
            aes(label = corr_label),
            x = Inf, y = Inf, hjust = 1.1, vjust = 1.1,
            size = 4, fontface = "bold",
            color = "#2166ac") +
  
  # Facet with clean layout
  facet_wrap(~indicator_label, scales = "free_y", ncol = 3) +
  
  # Colorblind-friendly scale
  scale_fill_viridis_d(name = "Kategori Pajak", 
                       option = "plasma", 
                       begin = 0.2, end = 0.9) +
  
  # Professional axis formatting
  scale_x_continuous(
    labels = label_percent(scale = 1, accuracy = 1),
    breaks = pretty_breaks(n = 4)
  ) +
  scale_y_continuous(
    labels = label_number(accuracy = 0.1),
    breaks = pretty_breaks(n = 4)
  ) +
  
  # Professional labels
  labs(
    title = "Hubungan antara Penerimaan Pajak dan Kualitas Institusi",
    subtitle = "Analisis indikator tata kelola di berbagai negara | Titik menunjukkan rata-rata negara dengan tren linear dan interval kepercayaan 95%",
    x = "Rata-rata Penerimaan Pajak (% terhadap PDB)",
    y = "Skor Indikator Tata Kelola",
    caption = "Sumber: World Governance Indicators, Heritage Foundation | Koefisien korelasi dan nilai R² ditampilkan untuk setiap indikator",
    fill = "Kategori\nPenerimaan Pajak"
  ) +
  
  # Clean, professional theme with larger text
  theme_minimal(base_size = 14, base_family = "Arial") +
  theme(
    # Title formatting - LARGER
    plot.title = element_text(size = 20, face = "bold", 
                              margin = margin(b = 8), color = "#2c3e50"),
    plot.subtitle = element_text(size = 14, color = "#34495e", 
                                 margin = margin(b = 20)),
    plot.caption = element_text(size = 12, color = "#7f8c8d", 
                                hjust = 0, margin = margin(t = 20)),
    
    # Panel formatting - LARGER
    strip.text = element_text(size = 13, face = "bold", 
                              color = "#2c3e50", margin = margin(b = 8)),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#ecf0f1", size = 0.5),
    panel.background = element_rect(fill = "#fafafa", color = NA),
    
    # Axis formatting - LARGER
    axis.title = element_text(size = 14, face = "bold", color = "#2c3e50"),
    axis.text = element_text(size = 11, color = "#34495e"),
    axis.ticks = element_line(color = "#bdc3c7", size = 0.3),
    
    # Legend formatting - MUCH LARGER
    legend.position = "bottom",
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1.2, "cm"),
    legend.margin = margin(t = 15),
    
    # Overall plot formatting
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(25, 25, 25, 25)
  ) +
  
  # Guide formatting with larger legend
  guides(
    fill = guide_legend(
      title.position = "top",
      title.hjust = 0.5,
      nrow = 1,
      override.aes = list(size = 5)
    )
  )

# Step 5: Display the main plot (full size)
print(main_plot)