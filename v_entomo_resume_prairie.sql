WITH attributes AS (
  SELECT
    vm.id,
    e.enjeu,
    max(e.surpaturage) surpaturage,
    max(e.embroussaillement) embroussaillement,
    max(e.brulage) brulage,
    max(e.dyn_forest) dyn_forest,
    max(e.zoosanit) zoosanit,
    max(e.rechauffement) rechauffement
  FROM
    gn_synthese.synthese_avec_partenaires s
    JOIN ag_pasto.vm_entomo_prairie vm USING (id_synthese)
    JOIN ag_pasto.tr_entomo_enjeu e USING (cd_ref)
  WHERE
    s.date_min >= '2000-01-01'
  GROUP BY
    vm.id, enjeu
)
SELECT
  attributes.enjeu,
  attributes.surpaturage,
  attributes.embroussaillement,
  attributes.brulage,
  attributes.dyn_forest,
  attributes.zoosanit,
  attributes.rechauffement,
  prairie.*
FROM
  ag_pasto.c_prairie_pra prairie
  JOIN attributes USING (id)
