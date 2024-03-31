library(tidyverse)

df_pids <- read_csv("metadata/GSE129788.sample.portal_id.csv", skip=1,
                          col_names=c("n_cells", "sample_pid", "sample_id"),
                          col_types="_icc")

df_celltypes <- read_tsv("metadata/celltype.codes.tsv", skip=1,
                         col_names=c("cell_type", "cell_type_long"),
                         col_types="cc")

df_tsne <- read_tsv("metadata/tsne_Aging_mouse_brain_portal_data.txt", skip=2,
                    col_names=c("cell_pid", "tsne_1", "tsne_2"),
                    col_types="cdd")

df_annots <- read_tsv("metadata/GSE129788_Supplementary_meta_data_Cell_Types_Etc.txt", skip=2,
                      col_names=c("cell_pid", "n_gene", "n_umi", "cell_type", "age", "cell_lineage"),
                      col_types="ciiccc_") %>%
    inner_join(df_celltypes, by="cell_type") %>%
    mutate(barcode=str_extract(cell_pid, "[ACGT]{16}$"),
           sample_pid=str_match(cell_pid, "([0-9]+)_[ACGT]+$")[,2]) %>%
    inner_join(df_pids, by="sample_pid") %>%
    mutate(cell_id=str_c(sample_id, "_", barcode)) %>%
    inner_join(df_tsne, by="cell_pid") %>%
    select(cell_id, cell_pid, barcode,
           cell_type, cell_type_long, cell_lineage,
           n_gene, n_umi, tsne_1, tsne_2,
           sample_id, sample_pid, age, n_cells)

write_csv(df_annots, "metadata/cell_annots.csv")
