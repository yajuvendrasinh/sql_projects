# Music Store Analysis Project Structure

## Directory Structure

```
music_store_analysis/
├── data/                      # Raw CSV data files
├── sql/                       # SQL scripts
│   ├── 01_setup_database.sql  # Database and table creation
│   ├── 02_basic_analysis.sql  # Basic analysis queries (Q1-Q5)
│   ├── 03_customer_analysis.sql # Customer-focused queries (Q5, Q6, Q11)
│   ├── 04_music_analysis.sql  # Music-focused queries (Q7, Q8, Q12, Q13)
│   ├── 05_sales_analysis.sql  # Sales and financial queries (Q9, Q14)
│   ├── 06_geographic_analysis.sql # Country/location queries (Q10, Q15)
│   └── 07_advanced_analysis.sql # Additional advanced queries
├── results/                   # Results and findings
│   ├── basic_analysis.md      # Results from basic analysis
│   ├── customer_analysis.md   # Results from customer analysis
│   ├── music_analysis.md      # Results from music analysis
│   ├── sales_analysis.md      # Results from sales analysis
│   ├── geographic_analysis.md # Results from geographic analysis
│   └── advanced_analysis.md   # Results from advanced analysis
├── docs/                      # Documentation
│   ├── schema.md              # Database schema documentation
│   └── data_dictionary.md     # Data dictionary explaining fields
├── README.md                  # Project overview and instructions
└── LICENSE                    # License information
```

## Analysis Plan

### 1. Basic Analysis (Questions 1-5)
- Employee hierarchy analysis
- Country invoice distribution
- Top invoice values
- Best customer cities
- Best individual customers

### 2. Customer Analysis (Questions 5, 6, 11)
- Best customers by spending
- Rock music listeners
- Top customers by country

### 3. Music Analysis (Questions 7, 8, 12, 13)
- Top rock bands
- Longer-than-average tracks
- Most popular artists
- Most popular songs

### 4. Sales Analysis (Questions 9, 14)
- Customer spending by artist
- Average prices by music type

### 5. Geographic Analysis (Questions 10, 15)
- Most popular genres by country
- Most popular countries for music purchases

### 6. Advanced Analysis (Additional Insights)
- Seasonal trends in music purchases
- Customer lifetime value analysis
- Employee sales performance
- Genre popularity over time
- Customer retention analysis

## Implementation Approach

1. Each SQL script will:
   - Include detailed comments explaining the business question
   - Provide context for why the analysis is valuable
   - Include the SQL query with proper formatting and comments
   - Document any assumptions or limitations

2. Each results document will:
   - Summarize the findings in business terms
   - Include relevant metrics and key figures
   - Provide business recommendations based on the analysis
   - Include references to the corresponding SQL queries

3. Documentation will:
   - Explain how to set up and run the analysis
   - Provide context for the business questions
   - Include a data dictionary explaining all fields
   - Document the database schema with relationships
