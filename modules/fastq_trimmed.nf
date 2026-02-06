process FASTQC_TRIMMED {
    tag "trimmed_qc"
    publishDir "${params.outdir}/fastqc/trimmed",mode : 'symlink'

    input : 
    path trimmed 

    output:
    path "*_fastqc.{html,zip}"

    script:
    """

    ${params.fastqc} ${trimmed}
    """ 
}