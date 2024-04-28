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
directory_to_scan = 'z:\\wiki\Bibliothek'
count_pdf_pages(directory_to_scan)
