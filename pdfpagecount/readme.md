
# PDF Page Count 

Generated with ChatGPT (4)

## Prompt: 
In Python: Write me an application that recursively iterates through a folder, finds all PDF documents and finds the number of pages per PDF document. Print the number of pages per document to the console and at the very end of processing print the total number of pages and the average number of pages per document to the console.

## ChatGPT: Generated Solution

To create a Python application that iterates through folders recursively, finds all PDF documents, and counts the number of pages in each, you can use the `os` module for navigating directories and the `PyPDF2` library for handling PDF files. Here's how you can do it:

1. Install the `PyPDF2` library, if you don't have it installed yet. You can install it via pip:
   ```bash
   pip install PyPDF2
   ```

2. Write the Python script that accomplishes the task:

```python
import os
import PyPDF2

def count_pdf_pages(directory):
    total_pages = 0
    num_documents = 0
    pdf_pages = []

    # Walk through all directories and files in the provided directory
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.pdf'):
                # Construct full file path
                path = os.path.join(root, file)
                try:
                    # Open the PDF file
                    with open(path, 'rb') as pdf_file:
                        reader = PyPDF2.PdfReader(pdf_file)
                        num_pages = len(reader.pages)
                        pdf_pages.append((path, num_pages))
                        total_pages += num_pages
                        num_documents += 1
                except Exception as e:
                    print(f"Failed to process {path}: {str(e)}")

    # Print number of pages for each document
    for path, pages in pdf_pages:
        print(f"{path}: {pages} pages")

    # Calculate and print the total and average number of pages
    if num_documents > 0:
        average_pages = total_pages / num_documents
        print(f"Total number of pages: {total_pages}")
        print(f"Average number of pages per document: {average_pages:.2f}")
    else:
        print("No PDF documents found.")

# Specify the directory to scan
directory_to_scan = '/path/to/your/directory'
count_pdf_pages(directory_to_scan)
```

### How to Use This Script

1. Replace `'/path/to/your/directory'` with the path to the directory you want to scan for PDF files.
2. Run the script. It will print the number of pages for each PDF found and provide the total and average number of pages at the end.

This script navigates through all subdirectories starting from the specified root directory, opening each PDF file it finds, and uses `PyPDF2` to count the pages. It handles exceptions to deal with any unreadable or encrypted files and provides a summary of the results.

### Result
```
> python app.py
[...]
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\ID98 Massgeschneiderte Medienerwerbung Acquisition spécialisée.pdf: 1 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\Ignite_Talk_ETH-Bibliothek_Wie_ verändert_KI _IK_2023_V2.pdf: 59 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\Lienhard_Co-Creation_ETH-Bibliothek_Bibliothekskongress_20231103.pdf: 11 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\PRAE_RDM-Network-Bibliosuisse_20231025_chb_ili.pdf: 25 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\PresentationSwissLib.pdf: 11 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\PRE_AKORD_bibliosuisse_Gero-Iris_20231025_final.pdf: 21 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\Schweizer Bibliothekskongress 2023 Referat Schmidt Webversion.pdf: 25 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\Session_3-The-potential-of-open-infrastructures-Bibliosuisse-Slides.pdf: 37 pages
z:\wiki\Bibliothek\BiblioSuisse\2023\Kongress 2023\Söllner Bibliosuisse 2023_kurz.pdf: 12 pages
z:\wiki\Bibliothek\BiblioSuisse\2024\2024-02_Wir_sind_Bibliosuisse.pdf: 1 pages
z:\wiki\Bibliothek\SLSP\5738-Artikeltext-21402-1-10-20210928.pdf: 16 pages
Total number of pages: 1613
Average number of pages per document: 11.52
```