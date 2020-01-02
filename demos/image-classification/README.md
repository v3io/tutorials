# Image Classification Using Distributed Training

- [Overview](#image-classif-demo-overview)
- [Notebooks and Code](#image-classif-demo-nbs-n-code)

<a id="image-classif-demo-overview"></a>
## Overview

This demo demonstrates an end-to-end solution for image recognition: the application uses TensorFlow, Keras, Horovod, and Nuclio to build and train an ML model that identifies (recognizes) and classifies images. 
The application consists of four MLRun and Nuclio functions for performing the following operations:

1. Import an image archive from from an Amazon Simple Storage (S3) bucket to the platform's data store.
2. Tag the images based on their name structure.
3. Train the image-classification ML model by using [TensorFlow](https://www.tensorflow.org/) and [Keras](https://keras.io/); use [Horovod](https://eng.uber.com/horovod/) to perform distributed training over either GPUs or CPUs.
4. Automatically deploy a Nuclio model-serving function from [Jupyter Notebook](nuclio-serving-tf-images.ipynb) or from a [Dockerfile](./inference-docker).

<br><p align="center"><img src="workflow.png" width="600"/></p><br>

This demo also provides an example of an [automated pipeline](image-classification/02-create_pipeline.ipynb) using [MLRun](https://github.com/mlrun/mlrun) and [Kubeflow pipelines](https://github.com/kubeflow/pipelines).

<a id="image-classif-demo-nbs-n-code"></a>
## Notebooks and Code

- [**01-image-classification.ipynb**](01-image-classification.ipynb) &mdash; all-in-one: import, tag, launch train, deploy, and serve
- [**horovod-training.py**](horovod-training.py) &mdash; train function code
- [**nuclio-serving-tf-images.ipynb**](nuclio-serving-tf-images.ipynb) &mdash; serve function development and test
- [**02-create_pipeline.ipynb**](02-create_pipeline.ipynb) &mdash; auto-generate a Kubeflow pipeline workflow
- **inference-docker/** &mdash; build and serve functions using a Dockerfile:
  - [**main.py**](./inference-docker/main.py) &mdash; function code
  - [**Dockerfile**](./inference-docker/Dockerfile) &mdash; a Dockerfile
