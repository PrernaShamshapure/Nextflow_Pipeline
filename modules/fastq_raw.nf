process FASTQC_RAW {
   tag "raw_qc"
   publishDir "${params.outdir}/fastqc/raw",mode:'symlink'

   input:
   path fastq

   output:
   path "*_fastqc.{html,zip}"
   

   script:
   """
   ${params.fastqc} ${fastq}
   """
}