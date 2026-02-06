include {MY_PIPELINE} from './workflows/workflow'

workflow {

    fastq_ch = channel.fromPath(params.fastq, checkIfExists: true)
    ref_ch   = channel.fromPath(params.ref, checkIfExists: true)

    MY_PIPELINE(fastq_ch, ref_ch)

}