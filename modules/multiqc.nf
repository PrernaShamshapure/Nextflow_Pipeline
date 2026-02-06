process MULTIQC {
     tag "multiqc"
    publishDir "${params.outdir}/multiqc",mode:'symlink'

    input :
    path qc_files

    output :
    path "multiqc_report.html"

    script:
    """

    ${params.multiqc} .
    """
}