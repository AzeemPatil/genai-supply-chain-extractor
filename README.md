# Unstructured Supply Chain & Catalog Extractor (GenAI)

## Overview
In the global import/export industry, product data often arrives in highly unstructured formats—such as vendor emails, PDF text dumps, and messy spreadsheets. This Data Engineering project leverages Generative AI (LLMs) to automatically parse these unstructured texts, extracting structured attributes (Product Name, Category, Quantity, Unit Price, Origin) into a clean, queryable SQL database.

## Architecture
1. **Data Ingestion:** Reads messy, semi-structured text data representing vendor correspondence and raw catalog entries.
2. **GenAI Processing:** Uses Python and the Google Gemini/OpenAI API to parse the text with a strict system prompt, forcing the output into a standardized JSON schema.
3. **Database Integration:** Flattens the JSON outputs and loads them into a relational SQL database for business intelligence.
4. **Analytics:** SQL scripts utilizing CTEs and aggregations to calculate total inventory value and categorize supply chain metrics.

## Tech Stack
* **Language:** Python (Pandas, JSON, API Integration)
* **GenAI:** LLM APIs (Prompt Engineering, Structured Output)
* **Database:** SQLite / PostgreSQL / Google BigQuery
