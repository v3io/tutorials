
# GPU Demos

- [Overview](#gpu-demos-overview)
- [Horovod Demos Prerequisites](#horovod-prereq)
- [RAPIDS Demos Prerequisites](#rapids-prereq)
- [GPU Resources Note](#gpu-resources-note)

<a id="gpu-demos-overview"></a>
## Overview

The GPU demos are aimed at demonstrating how to run code over graphics processing units (GPUs) in the Iguazio Data Science Platform (**the platform**).
The **demos/gpu** directory includes the following:

- A **horovod** directory with applications that use Uber's [Horovod](https://eng.uber.com/horovod/) distributed deep-learning framework, which can be used to convert a single-GPU TensorFlow, Keras, or PyTorch model-training program to a distributed program that trains the model simultaneously over multiple GPUs.
    The objective is to speed up your model training with minimal changes to your existing single-GPU code and without complicating the execution.
    Horovod code can also run over CPUs with only minor modifications.
    The Horovod tutorials include the following:

    - An image-recognition demo application for execution over GPUs (**image-classification**).
    - A slightly modified version of the GPU image-classification demo application for execution over CPUs (**cpu/image-classification**).
    - Benchmark tests (**benchmark-tf.ipynb**, which executes **tf_cnn_benchmarks.py**).

- A **rapids** directory with applications that use NVIDIA's [RAPIDS](https://rapids.ai/) open-source libraries suite for executing end-to-end data science and analytics pipelines entirely on GPUs.
  The RAPIDS tutorials include the following:

    - Demo applications that use the [cuDF](https://rapidsai.github.io/projects/cudf/en/latest/index.html) RAPIDS GPU DataFrame library to perform batching and aggregation of data that's read from a Kafaka stream, and then write the results to a Parquet file.<br>
      The **nuclio-cudf-agg.ipynb** demo implements this by using a Nuclio serverless function while the **python-agg.ipynb** demo implements this by using a standalone Python function.
    - Benchmark tests that compare the performance of RAPIDS cuDF to pandas DataFrames (**benchmark-cudf-vs-pd.ipynb**).

<a id="horovod-prereq"></a>
## Horovod Demos Prerequisites

The following prerequisites must be met to successfully run the Horovod demo tutorials (**demos/horovod**):

- The parent platform tenant has an enabled Horovod service.
- To run the GPU demos &mdash;
  - The platform environment has one or more [NVIDIA](https://www.nvidia.com/en-us/) GPUs that are available for consumption by Horovod.
    See also the [GPU Resources Note](#gpu-resources-note).
  - The Jupyter Notebook service from which the code is executed uses the **"Jupyter Full Stack with GPU"** flavor.

<a id="rapids-prereq"></a>
## RAPIDS Demos Prerequisites

The following prerequisites must be met to successfully run the RAPIDS demo tutorials (**demos/rapids**):

- Your environment has one or more GPUs with the [NVIDIA Pascal](https://www.nvidia.com/en-us/geforce/products/10series/architecture/) architecture or better and [compute capability](https://developer.nvidia.com/cuda-gpus) 6.0+.
- At least one GPU resource has been configured for the parent Jupyter Notebook service (**Common Parameters > Resources > GPU > Limit**).
  See also the [GPU Resources Note](#gpu-resources-note).
- The Jupyter Notebook service from which the code is executed uses the **"Jupyter Full Stack with GPU"** flavor.

<a id="gpu-resources-note"></a>
## GPU Resources Note

In environments with GPUs, the platform's Jupyter Notebook service has an optional GPU-limit parameter (**Common Parameters > Resources > GPU > Limit**), which guarantees the configured number of GPUs for use by each replica.
While the Jupyter Notebook service is enabled, it monopolizes the configured amount of GPUs even when the GPUs aren't in use.
The RAPIDS demos use the GPUs that were allocated for the Jupyter Notebook service from which the code is executed.
However, the Horovod demos don't use the GPUs of the Jupyter Notebook service; they use GPUs that are allocated dynamically by Horovod.
Therefore, note that on systems with limited GPU resources you might need to reduce the amount of GPU resources allocated to the Jupyter Notebook service or set it to 0 to successfully run the Horovod code over GPUs.
