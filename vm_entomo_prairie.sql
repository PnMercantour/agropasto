-- ag_pasto.vm_entomo_prairie source
CREATE MATERIALIZED VIEW ag_pasto.vm_entomo_prairie TABLESPACE pg_default AS
SELECT
  p.id,
  t.cd_ref,
  s.id_synthese
FROM
  gn_synthese.synthese_avec_partenaires s
  JOIN ag_pasto.tr_entomo_taxref t USING (cd_nom)
  JOIN ag_pasto.c_prairie_pra p ON st_contains (p.geom, s.geom
)
  WITH DATA;

-- Permissions
ALTER TABLE ag_pasto.vm_entomo_prairie OWNER TO "admin";

GRANT ALL ON TABLE ag_pasto.vm_entomo_prairie TO "admin";

GRANT SELECT ON TABLE ag_pasto.vm_entomo_prairie TO cdm_agpasto;

GRANT SELECT ON TABLE ag_pasto.vm_entomo_prairie TO consult_agpasto;
