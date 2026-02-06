process VARIANT_CALLING {
    tag "variant_calling"
    publishDir "${params.outdir}/variantcalling",mode:'symlink'

    input:
    path bam
    path bai
    path ref

    output:
    path "variants.vcf" , emit :vcf

    script:
    """

    ${params.bcftools} mpileup -f ${ref} ${bam} | ${params.bcftools}  call -mv -o variants.vcf
    """

}