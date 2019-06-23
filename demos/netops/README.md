# Netops
## Predictive Infrastructure Monitoring 

**Overview**   

The netops demo demonstrates predictive infrastructure monitoring: the application builds, trains, and deploys a machine-learning model for analyzing and predicting failure in network devices as part of a network operations (NetOps) flow.

This full system demo is used to showcase multiple ways to build machine learning pipelines:

- [**Jupyter-Dask**](#jupyter-dask): Using jupyter as our IDE: generating the data, exploring, training a model, deploying a nuclio function for inference and a grafana dashboard to monitor.  All parallelized with Dask.

- [**Nuclio**](#nuclio): Deploying a full real-time streaming system incl. Data generation, Preprocessing, Model training and Inference function on Nuclio from Jupyter

### Demo structure
The demo is comprised of four main parts:  

**Generator**:  
\[[Jupyter-Dask](01-generator.ipynb) | [Nuclio](pipelines/nuclio-generator.ipynb)]  

Using our open source [deployment generator](https://github.com/zilbermanor/deployment_generator/tree/master/v3io_generator) (Which you can pip install [here](https://test.pypi.org/manage/project/v3io-generator/releases/)) we create a network deployment (Defaults to Company, Data center, Device).  
We then add our metrics via [metrics configuration](configurations/metrics_configuration.yaml). (Defaults to CPU Utilization, Latency, Throughput, Packet loss).   

The generator can create both normal device metrics as defined by the Yaml, and error scenarios that cascade through the metrics until the device reaches a critical failure.

To see the devices behaviour you can look at the **[Exploration](02-explore.ipynb)** notebook.

**Data Preprocessing**:  
\[[Jupyter-Dask](01-generator.ipynb) | [Nuclio](pipelines/nuclio-data-preperations.ipynb)]  

Turning the device's metrics stream to a feature vector using aggregations from multiple timespans (Current, Minutely, Hourly)  

**Training**:  
\[[Jupyter-Dask](03-training.ipynb) | [Nuclio](pipelines/nuclio-training.ipynb)]  

Using the feature vectors from the previous steps, and the **is_error** metrics given by the generator, train a ML model (Spans from scikit based to XGBoost & TF).  
The model is then saved to a file for future usage.  

**Inference**:  
\[[Jupyter-Dask](04-infer.ipynb) | [Nuclio](pipelines/nuclio-inference.ipynb)] 

Using the model file from the previous step and the feature vectors created by the Preprocessing stage, predict if a device is about to fail.

## Jupyter-Dask
 - [Generator](01-generator.ipynb)
 - [Exploration](02-explore.ipynb)
 - [Training](03-training.ipynb)
 - [Inference](04-infer.ipynb)
 - [Dashboard](05-grafana.ipynb)
 
 ## Nuclio
 - [Generator](pipelines/nuclio-generator.ipynb)
 - [PreProcessing](pipelines/nuclio-data-preperations.ipynb)
 - [Training](pipelines/nuclio-training.ipynb)
 - [Inference](pipelines/nuclio-inference.ipynb)