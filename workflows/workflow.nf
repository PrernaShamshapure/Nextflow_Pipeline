include { FASTQC_RAW }      from '../modules/fastq_raw'
include { TRIM_READS }      from '../modules/trim_reads'
include { FASTQC_TRIMMED }  from '../modules/fastq_trimmed'
include { ALIGN_READS }     from '../modules/align_reads'
include { SAM_TO_BAM }      from '../modules/sam_to_bam'
include { SORT_INDEX_BAM }  from '../modules/sort_index_bam'
include { VARIANT_CALLING } from '../modules/variant_calling'
include { MULTIQC }         from '../modules/multiqc'


workflow MY_PIPELINE {
    take:
        fastq_input
        ref_input

    main:
        // Quality control on raw reads
        raw_qc_ch = FASTQC_RAW(fastq_input)
        
        // Trim adapters
        trimmed_fq_ch = TRIM_READS(fastq_input)
        
        // Quality control on trimmed reads
        trimmed_qc_ch = FASTQC_TRIMMED(trimmed_fq_ch)
        
        // Align reads to reference
        aligned_ch = ALIGN_READS(trimmed_fq_ch, ref_input)
        
        // Convert SAM to BAM
        bam_ch = SAM_TO_BAM(aligned_ch)
        
        // Sort and index BAM
        SORT_INDEX_BAM(bam_ch)
        
        // Call variants
        VARIANT_CALLING(
            SORT_INDEX_BAM.out.sorted_bam, 
            SORT_INDEX_BAM.out.bai, 
            ref_input
        )
        
        // Generate MultiQC report
        qc_files_ch = raw_qc_ch.mix(trimmed_qc_ch).collect()
        MULTIQC(qc_files_ch)
}