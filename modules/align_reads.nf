process ALIGN_READS {
    tag "alignment"
    publishDir "${params.outdir}/alignment",mode:'symlink'

    input: 
    path trimmed
    path ref

    output:
    path "sample_aligned.sam"

    script:
    """

    ${params.bwa} index ${ref}
    ${params.bwa} mem ${ref} ${trimmed} > sample_aligned.sam
    """
}