import requests
import json
import csv
# from nytimesarticle import articleAPI
# API_KEY = articleAPI('2c5f5cb74bd6411fbc293f1734613a63')

CACHE_FILENAME = 'shuttle_articles.json'
API_KEY = '2c5f5cb74bd6411fbc293f1734613a63'


def params_unique_combination(baseurl, params_d, private_keys=["api_key"]):
    alphabetized_keys = sorted(params_d.keys())
    res = []
    for k in alphabetized_keys:
        if k not in private_keys:
            res.append("{}-{}".format(k, params_d[k]))
    return baseurl + "_".join(res)

# caching step
try:
    f = open(CACHE_FILENAME)
    fstr = f.read()
    CACHE_DICTION = json.loads(fstr)
    f.close()
except:
    CACHE_DICTION = {}

# data request step
def get_from_nyt(search_term,begin_date,end_date):
    url = 'https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key={}'.format(API_KEY)
    params_d = {}
    params_d['q'] = search_term
    params_d['begin_date'] = begin_date
    params_d['end_date'] = end_date
    # params_d['page'] = page
    unique_ID = params_unique_combination(url,params_d)
    if unique_ID in CACHE_DICTION:
        nyt_data = CACHE_DICTION[unique_ID]
    else:
        resp_obj = requests.get(url, params=params_d)
        json_string = resp_obj.text #converts response object to text
        nyt_data = json.loads(json_string)
        CACHE_DICTION[unique_ID] = nyt_data

        f = open(CACHE_FILENAME, 'w')
        f.write(json.dumps(CACHE_DICTION))
        f.close()
    return (nyt_data) # json object

def json_diction(response_object):
    return (response_object['response']['docs'])
    # returns list of json dictionaries, each representing an article


class Article:
    def __init__(self, jsondict):
        try:
            self.headline = jsondict['headline']['main']
            self.date = jsondict['pub_date'] # 1986-01-28T00:00:00Z
            self.url = jsondict['web_url']
        except:
            self.headline = ""
            self.date = None
            self.url = ""

    def __str__(self):
        return (self.headline)

    def date_format(self):
        # mm/dd/yyyy
        split = self.date.split('-')
        split2 = split[2].split('T')
        month = split[1]
        day = split2[0]
        year = split[0]
        return ("{}/{}/{}".format(month,day,year))


def csv_content(file_name,list_name):
    with open(file_name, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['Date','Headline','URL'])
        for obj in list_name:
            writer.writerow([obj.date_format(), obj.headline, obj.url])


'''TESTING...'''
# grabbing search query data for each shuttle; based on their commission date ranges
challenger_data = get_from_nyt('challenger shuttle',19830404,19860128)
# columbia_data = get_from_nyt('columbia shuttle',19810412,20030106)
# atlantis_data = get_from_nyt('atlantis shuttle',19851003,20110708)
# discovery_data = get_from_nyt('discovery shuttle',19840830,20110224)
# endeavor_data = get_from_nyt('endeavor shuttle',19920507,20110516) #API rate limit exceeded

# creating article list, each a json dictionary
challenger_diction = json_diction(challenger_data)
# columbia_diction = json_diction(columbia_data)
# atlantis_diction = json_diction(atlantis_data)
# discovery_diction = json_diction(discovery_data)
# json_diction(endeavor_data) #API rate limit exceeded

#creating list of Article instances for each data dictionary
challenger_articles = [Article(json_dict) for json_dict in challenger_diction]
# columbia_articles = [Article(json_dict) for json_dict in columbia_diction]
# atlantis_articles = [Article(json_dict) for json_dict in atlantis_diction]
# discovery_articles = [Article(json_dict) for json_dict in discovery_diction]

# writing article data for each shuttle to a separate file
csv_content('challenger.csv',challenger_articles)

# challenger_art_objs = [x for x in challenger_data['response']['docs']]
# sample_art_obj = challenger_art_objs[0]
# c_art_instance = Article(sample_art_obj)
# print (c_art_instance)
# print (c_art_instance.date)
# print (c_art_instance.url)
# print (c_art_instance.date_format())
