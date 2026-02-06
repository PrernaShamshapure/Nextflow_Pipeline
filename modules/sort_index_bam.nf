process SORT_INDEX_BAM {
    tag "sort_index"
    publishDir "${params.outdir}/bam", mode: 'symlink'

    input:
    path bam

    output:
    path "sample_sorted.bam", emit: sorted_bam
    path "sample_sorted.bam.bai", emit: bai

    script:
    """
    ${params.samtools} sort $bam -o sample_sorted.bam
    ${params.samtools} index sample_sorted.bam
    """
}