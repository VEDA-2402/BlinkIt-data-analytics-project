import os

# Base project name
PROJECT_NAME = "blinkit-sql-analysis"

# Folder and file structure
STRUCTURE = {
    "analysis": [
        "01_data_sanity_checks.sql",
        "02_customer_economics.sql",
        "03_product_portfolio.sql",
        "04_inventory_efficiency.sql",
        "05_delivery_performance.sql",
        "06_marketing_effectiveness.sql",
        "07_end_to_end_funnel.sql",
    ],
    "insights": [
        "customer_insights.md",
        "product_insights.md",
        "inventory_insights.md",
        "delivery_insights.md",
        "marketing_insights.md",
        "executive_summary.md",
    ],
    "schema": [
        "er_diagram.png"
    ],
    "data_model": [
        "table_relationships.md"
    ],
    "assets/charts_or_exports": []
}

ROOT_FILES = [
    "README.md"
]

def create_project_structure():
    # Create root directory
    os.makedirs(PROJECT_NAME, exist_ok=True)

    # Create root files
    for file in ROOT_FILES:
        file_path = os.path.join(PROJECT_NAME, file)
        open(file_path, "w").close()

    # Create folders and files
    for folder, files in STRUCTURE.items():
        folder_path = os.path.join(PROJECT_NAME, folder)
        os.makedirs(folder_path, exist_ok=True)

        for file in files:
            file_path = os.path.join(folder_path, file)
            open(file_path, "w").close()

    print("✅ Blinkit SQL Analysis project structure created successfully!")

if __name__ == "__main__":
    create_project_structure()
