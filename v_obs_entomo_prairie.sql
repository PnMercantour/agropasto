SELECT
  vm.id,
  e.*,
  s.*
FROM
  gn_synthese.synthese_avec_partenaires s
  JOIN ag_pasto.vm_entomo_prairie vm USING (id_synthese)
  JOIN ag_pasto.tr_entomo_enjeu e USING (cd_ref);
