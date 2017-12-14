SELECT distinct
	genes.name AS gene,
	drug_claims.primary_name AS drug
FROM 
	genes,
	gene_claims,
	interaction_claims,
	interaction_claims interaction_claims2,
	sources,
	sources sources2,
	drug_claims
WHERE
	genes.id = gene_claims.gene_id
	AND interaction_claims.gene_claim_id = gene_claims.id
	AND sources.id = interaction_claims.source_id
	AND interaction_claims2.interaction_id = interaction_claims.interaction_id
	AND interaction_claims2.source_id = sources2.id
	AND interaction_claims2.drug_claim_id = drug_claims.id
	
	AND sources.source_db_name in ('CIViC','MyCancerGenomeClinicalTrial','MyCancerGenome','CancerCommons')
;
