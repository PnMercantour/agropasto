SELECT
  e.cd_ref,
  e.enjeu,
  e.surpaturage,
  e.embroussaillement,
  e.brulage,
  e.dyn_forest,
  e.zoosanit,
  e.rechauffement,
  s.*
FROM
  gn_synthese.synthese_avec_partenaires s
  JOIN ag_pasto.tr_entomo_taxref t USING (cd_nom)
  JOIN ag_pasto.tr_entomo_enjeu e USING (cd_ref)
WHERE
  date_min >= '2000-01-01'
