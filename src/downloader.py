import urllib.request
import json
import os


def get_number_of_pages(url):
    with urllib.request.urlopen(url) as response:
        json_content = response.read()
        data = json.loads(json_content)
        return data['meta']['pages']

def download_content_to_disk(type_name, url, pages):
    for i in range(1, pages + 1):
        final_url = url + "&page=" + str(i)
        filename = type_name + "/" + type_name + "_" + str(i) + ".json"
        print(type_name + ": " + str(i) + " of " + str(pages))
        if os.path.isfile(filename):
            print(filename + " not downloaded as it already exists")
        else:
            urllib.request.urlretrieve(final_url, filename)


print("Downloading contents from the EHRI portal API")

countries_url = "https://portal.ehri-project.eu/api/v1/search?type=country&limit=100"
institutions_url = "https://portal.ehri-project.eu/api/v1/search?type=Repository&limit=100"
holdings_url = "https://portal.ehri-project.eu/api/v1/search?type=DocumentaryUnit&limit=100"

countries_pages = get_number_of_pages(countries_url)
institutions_pages = get_number_of_pages(institutions_url)
holdings_pages = get_number_of_pages(holdings_url)

print("Downloading countries...")
download_content_to_disk("countries", countries_url, countries_pages)

print("Downloading institutions...")
download_content_to_disk("institutions", institutions_url, institutions_pages)

print("Downloading holdings...")
download_content_to_disk("holdings", holdings_url, holdings_pages)
