#!/bin/bash
DATABASE_PATH=$1
SEQUENCES_PATH=$2

# Run the blastn command
blastn -db "$DATABASE_PATH" -query "$SEQUENCES_PATH" -evalue 1e-3 -word_size 11 -outfmt 6 > sequences.reference

echo "BLAST search completed. Results saved in sequences.reference."

tr "|" "\t" < "sequences.reference" > "new_sequences.tsv"

echo "Replaced pipes with tabs. Saved in new_sequences.tsv"

awk 'BEGIN {OFS="\t"} $8 >= 90 {print $1,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17}' new_sequences.tsv > mod_sequences.tsv

echo "Filtered and processed the table. Saved in mod_sequences.tsv"

cat seq_headers.txt mod_sequences.tsv > final_result.tsv

echo "Added the headers and saved to final_result.tsv"
