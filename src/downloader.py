import urllib.request
import json
import os
from multiprocessing import Pool
import multiprocessing as mp
from functools import partial
import sys
import requests
import time

ehri_terms_query_end = """\"){
      items {
        id
        identifier
        links {
          targets {
            id
            type
          }
        }
      }
      pageInfo {
        hasPreviousPage
        previousPage
        hasNextPage
        nextPage
      }
    }
  }
}"""

ehri_terms_query_start = """{
  CvocVocabulary(id: \""""

ehri_terms_query_middle = """\") {
    id
    concepts(after: \""""
    
ehri_historical_query_end = """\") {
      items {
          id
          identifier
          description {
            languageCode
            name
            identifier
            lastName
            firstName
            source
            typeOfEntity
            datesOfExistence
            biographicalHistory
            legalStatus
            structure
            generalContext
            occupation
            otherFormsOfName
            parallelFormsOfName
          }
          links {
            targets {
              id
              type
            }
          }
      }
      pageInfo {
        hasPreviousPage
        previousPage
        hasNextPage
        nextPage
  		}
    }
  }
}"""

ehri_historical_query_start = """{
  AuthoritativeSet(id: \""""
  
ehri_historical_query_middle = """\") {
    authorities(after: \""""



def get_number_of_pages(url):
    with urllib.request.urlopen(url) as response:
        json_content = response.read()
        data = json.loads(json_content)
        return data['meta']['pages']

def download_content_to_disk(type_name, url, pages, wait_seconds=0):
    number_of_cpus = mp.cpu_count()
    parallel = sys.argv[1] if len(sys.argv) > 1 else None
    if parallel is not None and parallel == "--parallel":
        with Pool(number_of_cpus) as p:
            p.map(partial(download_by_page, type_name=type_name, url=url, pages=pages), range(1, pages + 1))
    else:
        for i in range(1, pages + 1):
            download_by_page(i, type_name, url, pages, wait_seconds)
        
def download_by_page(i, type_name, url, pages, wait_seconds=0):
    final_url = url + "&page=" + str(i)
    filename = type_name + "/" + type_name + "_" + str(i) + ".json"
    print(type_name + ": " + str(i) + " of " + str(pages))
    if os.path.isfile(filename):
        print(filename + " not downloaded as it already exists")
    else:
        success = False
        while not(success):
            try:
                time.sleep(wait_seconds)
                urllib.request.urlretrieve(final_url, filename)
                success = True
            except Exception as err:
                print("Error while downloading the file " + filename + ": " + err)

def download_from_graphql(type_name, url, query_start, query_end, wait_seconds=0):
    i = 1
    after = ""
    next_page = True
    while next_page:
        filename = type_name + "/" + type_name + "_" + str(i) + ".json"
        final_query = query_start + after + query_end
        json_query = {'query': final_query}
        headers = {'Content-type': 'application/json'}
        success = False
        while not(success):
            try:
                time.sleep(wait_seconds)
                r = requests.post(url=url, json=json_query, headers=headers)
                with open(filename, "w", encoding="utf-8") as file:
                    file.write(r.text)
                json_content = r.text
                data = json.loads(json_content)
                if 'CvocVocabulary' in data['data']:
                    next_page = data['data']['CvocVocabulary']['concepts']['pageInfo']['hasNextPage']
                    after = data['data']['CvocVocabulary']['concepts']['pageInfo']['nextPage']
                else:
                    next_page = data['data']['AuthoritativeSet']['authorities']['pageInfo']['hasNextPage']
                    after = data['data']['AuthoritativeSet']['authorities']['pageInfo']['nextPage']
                success = True
            except Exception as err:
                print("Error while downloading from GraphQL URL " + url + ": " + err)
        i += 1

if __name__ == '__main__':
    print("Downloading contents from the EHRI portal API")

    wait_seconds = 5
    
    countries_url = "https://portal.ehri-project.eu/api/v1/search?type=country&limit=100"
    institutions_url = "https://portal.ehri-project.eu/api/v1/search?type=Repository&limit=100"
    holdings_url = "https://portal.ehri-project.eu/api/v1/search?type=DocumentaryUnit&limit=100"
    grapql_url = "https://portal.ehri-project.eu/api/graphql"

    countries_pages = get_number_of_pages(countries_url)
    institutions_pages = get_number_of_pages(institutions_url)
    holdings_pages = get_number_of_pages(holdings_url)

    print("Downloading countries...")
    download_content_to_disk("countries", countries_url, countries_pages, wait_seconds)

    print("Downloading institutions...")
    download_content_to_disk("institutions", institutions_url, institutions_pages, wait_seconds)

    print("Downloading holdings...")
    download_content_to_disk("holdings", holdings_url, holdings_pages, wait_seconds)
    
    print("Downloading EHRI terms and links...")
    query_start = ehri_terms_query_start + "ehri_terms" + ehri_terms_query_middle
    download_from_graphql("terms", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI ghettos and links...")
    query_start = ehri_terms_query_start + "ehri_ghettos" + ehri_terms_query_middle
    download_from_graphql("ghettos", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI camps and links...")
    query_start = ehri_terms_query_start + "ehri_camps" + ehri_terms_query_middle
    download_from_graphql("camps", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI people...")
    query_start = ehri_historical_query_start + "ehri_pers" + ehri_historical_query_middle
    download_from_graphql("people", grapql_url, query_start, ehri_historical_query_end, wait_seconds)

    print("Downloading EHRI corporate bodies...")
    query_start = ehri_historical_query_start + "ehri_cb" + ehri_historical_query_middle
    download_from_graphql("cb", grapql_url, query_start, ehri_historical_query_end, wait_seconds)

