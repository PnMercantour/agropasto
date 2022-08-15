import requests
import json
import psycopg
from psycopg.rows import dict_row

# https://pypi.org/project/requests/
# https://requests.readthedocs.io
# https://taxref.mnhn.fr/taxref-web/api/doc

taxon_url = "https://taxref.mnhn.fr/api/taxa/{id}"
synonyms_url = taxon_url + "/synonyms"

# Téléchargement de la liste des taxons (cd_ref v15)
with psycopg.connect(service='projets', row_factory=dict_row) as connection:
    with connection.cursor() as cur:
        cur.execute(
            f"select cd_ref from ag_pasto.tr_entomo_taxref")
        print(cur)
        taxons = set([d['cd_ref'] for d in cur.fetchall()])


# On construit la liste des cd_ref v15, avec correspondance avec l'ancien cd_ref


def synonyms(id):
    response = requests.get(synonyms_url.format(id=id))
    return response.json().get('_embedded', {'taxa': []})['taxa']

# mise à jour du nom_complet

# connection = psycopg2.connect(service='projets')
# cur = connection.cursor()

# for taxon in taxons:
#     response = requests.get(taxon_url.format(id=taxon))
#     # print(response)
#     record = response.json()
#     print(record['id'], record['referenceId'], record['referenceName'])
#     cur.execute(
#         f"update ag_pasto.tr_entomo_enjeu set nom_complet = '{record['referenceName']}' where cd_ref = {record['id']}")
# cur.close()
# connection.commit()

# synonymes


with psycopg.connect(service='projets', row_factory=dict_row) as connection:
    with connection.cursor() as cur:
        cur.execute("truncate ag_pasto.tr_entomo_taxref")
        for taxon in taxons:
            print(f"Processing taxon {taxon}")
            cur.execute(
                f"insert into ag_pasto.tr_entomo_taxref(cd_ref,cd_nom) values({taxon}, {taxon}) on conflict do nothing")
            for record in synonyms(taxon):
                print(f"Process synonym: {record['id']}")
                cur.execute(
                    f"insert into ag_pasto.tr_entomo_taxref(cd_ref,cd_nom) values({taxon}, {record['id']}) on conflict do nothing")
