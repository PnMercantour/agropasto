-- ag_pasto.vm_entomo_up source
CREATE MATERIALIZED VIEW ag_pasto.vm_entomo_up TABLESPACE pg_default AS
SELECT
  up.id,
  t.cd_ref,
  s.id_synthese
FROM
  gn_synthese.synthese_avec_partenaires s
  JOIN ag_pasto.tr_entomo_taxref t USING (cd_nom)
  JOIN ag_pasto.c_unite_pastorale_unp up ON st_contains (up.geom, s.geom
)
  WITH DATA;

-- View indexes:
CREATE INDEX vm_entomo_up_cd_ref_idx ON ag_pasto.vm_entomo_up USING btree (cd_ref);

CREATE INDEX vm_entomo_up_id_idx ON ag_pasto.vm_entomo_up USING btree (id);

CREATE INDEX vm_entomo_up_id_synthese_idx ON ag_pasto.vm_entomo_up USING btree (id_synthese);

-- Permissions
ALTER TABLE ag_pasto.vm_entomo_up OWNER TO "admin";

GRANT ALL ON TABLE ag_pasto.vm_entomo_up TO "admin";

GRANT SELECT ON TABLE ag_pasto.vm_entomo_up TO cdm_agpasto;

GRANT SELECT ON TABLE ag_pasto.vm_entomo_up TO consult_agpasto;
