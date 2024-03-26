# Welcome to the Iguazio MLOps Platform

An initial introduction to the Iguazio MLOps Platform and the platform tutorials

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
- [The Tutorial Notebooks](#the-tutorial-notebooks)
- [Getting-Started Tutorial](#getting-started-tutorial)
- [End-to-End Use-Case Application and How-To Demos](#demos)
- [Installing and Updating the MLRun Python Package](#mlrun-python-pkg-install-n-update)
- [Additional Platform Resources](#platform-resources)
- [Miscellaneous](#misc)

<a id="platform-overview"></a>

## Platform Overview

The Iguazio MLOps Platform (**"the platform"**) is a fully integrated and secure data science platform as a service (PaaS), which simplifies development, accelerates performance, facilitates collaboration, and addresses operational challenges.
The platform incorporates the following components:

- A data science workbench that includes Jupyter Notebook, integrated analytics engines, and Python packages. You can work with your favorite IDE (e.g. Pycharm, VScode, Jupyter, Colab, etc.). Read how to configure your client against the deployed MLRun server in [Setting Up your Environment](https://www.iguazio.com/docs/latest-release/intro/setup-env/).
- The [MLRun](https://mlrun.readthedocs.io) open-source MLOps orchestration framework for ML model management with experiments tracking and pipeline automation
- Managed data and machine-learning (ML) services over a scalable Kubernetes cluster.
- A real-time serverless functions framework for model serving ([Nuclio](https://nuclio.io/)).
- Integration with third-party data sources such as Amazon S3, HDFS, SQL databases, and streaming or messaging protocols.
- Real-time dashboards based on Grafana.

<br><img src="./assets/images/igz-self-service-platform.png" alt="Self-service data science platform" width="650"/><br>

<a id="data-science-workflow"></a>

## Data Science Workflow

The platform provides a complete data science workflow in a single ready-to-use platform that includes all the required building blocks for creating data science applications from research to production:

- Collect, explore, and label data from various real-time or offline sources
- Run ML training and validation at scale over multiple CPUs and GPUs
- Deploy models and applications into production with serverless functions
- Log, monitor, and visualize all your data and services

![Data Science Workflow](./assets/images/igz-data-science-workflow.gif)

<a id="the-tutorial-notebooks"></a>

## The Tutorial Notebooks

The home directory of the platform's running-user directory (**/User/&lt;running user&gt;**) contains pre-deployed tutorial Jupyter notebooks with code samples and documentation to assist you in your development &mdash; including a [**demos**](https://github.com/mlrun/demos) directory with end-to-end use-case applications (see the next section).

> **Note:**
> - To view and run the tutorials from the platform, use your IDE. See [Setting up your Environment](https://www.iguazio.com/docs/latest-release/intro/setup-env/). (Alternatively, you can create a Jupyter Notebook service).
> - The **welcome.ipynb** notebook and main **README.md** file provide the same introduction in different formats.

<a id="getting-started-tutorial"></a>

## Getting-Started Tutorial

Start out by running the getting-started tutorial to familiarize yourself with the platform and experience firsthand some of its main capabilities.

<a href="https://docs.mlrun.org/en/stable/tutorials/01-mlrun-basics.html"><img src="./assets/images/view-tutorial-button.png" alt="View tutorial"/></a>

You can also view the tutorial on [GitHub](https://docs.mlrun.org/en/latest/tutorials/01-mlrun-basics.html).

<a id="demos"></a>

## End-to-End Use-Case Application and How-To Demos

Iguazio provides full end-to-end use-case application and how-to demos that demonstrate how to use the platform, its MLRun service, and related tools to address data science requirements for different industries and implementations.
These demos are available in the [MLRun demos repository](https://github.com/mlrun/demos).
Use the provided [**update-demos.sh**](https://github.com/mlrun/demos/blob/master/update_demos.sh) script to get updated demos from this repository.
By default, the script retrieves the files from the latest release that matches the version of the installed `mlrun` package (see [Installing and Updating the MLRun Python Package](#mlrun-python-pkg-install-n-update)).
The files are copied to the **/v3io/users/&lt;username&gt;/demos** directory, where `<username>` is the name of the running user (`$V3IO_USERNAME`) unless you set the `-u|--user` flag to another username.
> **Note:** Before running the script, close any open files in the **demos** directory.


```python
# Get additional demos
!/User/update-demos.sh
```

For full usage instructions, run the script with the `-h` or `--help` flag:


```python
!/User/update-demos.sh --help
```

<a id="end-to-end-use-case-applications"></a>

### End-to-End Use-Case Application Demos

<table align="left">
    <tr align="left" style="border-bottom: 1pt solid black;">
    <th>Demo</th>
    <th/>
    <th/>
    <th>Description</th>
    </tr>
    <tr>
        <td><b>Mask detection</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/mask-detection/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/mask-detection/">
                <img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo contains 3 notebooks where we:
      1. Train and evaluate a model for detecting if a person is wearing a mask in an image by using Tensorflow.Keras or PyTorch.<br>
      2. Serve the model as a serverless function in a http endpoint.<br>
      3. Write an automatic pipeline where we download a dataset of images, train and evaluate the model, then optimize the model (using ONNX) and serve it.
        </td>
    </tr>
    <tr>
        <td><b>Fraud Prevention - Iguazio Feature Store</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/fraud-prevention-feature-store/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/fraud-prevention-feature-store/">
                <img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates the feature store usage for fraud prevention: Data ingestion & preparation; Model training & testing; Model serving; Building An Automated ML Pipeline.
        </td>
    </tr>
    <tr>
        <td><b>News Article Summarization and Keyword Extraction via NLP</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/news-article-nlp/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/news-article-nlp/"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo creates an NLP pipeline that summarizes and extract keywords from a news article URL. We will be using state-of-the-art transformer models. such as BERT. to perform these NLP tasks.
Additionally, we will use MLRun's real-time inference graphs to create the pipeline. This allows for easy containerization and deployment of the pipeline on top of a production-ready Kubernetes cluster.
        </td>
    </tr>
    <tr>
        <td><b>NetOps Demo: Predictive Network Operations/Telemetry</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/network-operations/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/network-operations/"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo demonstrates how to build an automated machine-learning (ML) pipeline for predicting network outages based on network-device telemetry, also known as Network Operations (NetOps).
The demo implements feature engineering, model training, testing, inference, and model monitoring (with concept-drift detection).
The demo uses a offline/real-time metrics simulator to generate semi-random network telemetry data that is used across the pipeline.
        </td>
    </tr>
	 <tr>
        <td><b>Stocks Prediction</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demosstocke-prediction/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/stocks-prediction/"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo illustrates using Iguazio's latest technologies and methods for model serving, the platform feature store, and the MLRun frameworks (sub-modules for the most commonly 
		used machine and deep learning frameworks, providing features such as automatic logging, model management, and distributed training). The demo predicts stock prices, 
		and it creates a Grafana dashbord for model analysis.
        </td>
    </tr>
</table>

<a id="howto-demos"></a>

### How-To Demos

<table align="left">
    <tr align="left" style="border-bottom: 1pt solid black;">
    <th>Demo</th>
    <th/>
    <th/>
    <th>Description</th>
    </tr>
    <tr>
        <td><b>How-To: Converting existing ML code to an MLRun project</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/howto/converting-to-mlrun/mlrun-code.ipynb"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/master/howto/converting-to-mlrun"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates how to convert existing ML code to an MLRun project.
            The demo implements an MLRun project for taxi ride-fare prediction based on a <a href="https://www.kaggle.com/jsylas/python-version-of-top-ten-rank-r-22-m-2-88">Kaggle notebook</a> with an ML Python script that uses data from the <a href="https://www.kaggle.com/c/new-york-city-taxi-fare-prediction">New York City Taxi Fare Prediction competition</a>.
        </td>
    </tr>
    <tr>
        <td><b>How-To: Running a Spark job for reading a CSV file</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/howto/spark/spark-mlrun-read-csv.ipynb"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/howto/spark/spark-mlrun-read-csv.ipynb"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates how to run a Spark job that reads a CSV file and logs the data set to an MLRun database.
        </td>
    </tr>
    <tr>
        <td><b>How-To: Running a Spark job for analyzing data</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/howto/spark/spark-mlrun-describe.ipynb"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/howto/spark/spark-mlrun-describe.ipynb"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates how to create and run a Spark job that generates a profile report from an Apache Spark DataFrame based on pandas profiling.
        </td>
    </tr>
    <tr>
        <td><b>How-To: Running a Spark Job with Spark Operator</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/howto/spark/spark-operator.ipynb"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demos/tree/release/v1.6.x-latest/howto/spark/spark-operator.ipynb"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates how to use <a target="_blank" href="https://github.com/GoogleCloudPlatform/spark-on-k8s-operator">Spark Operator</a> to run a Spark job over Kubernetes with MLRun.
        </td>
    </tr>
</table>

<a id="mlrun-python-pkg-install-n-update"></a>

## Installing and Updating the MLRun Python Package

The demo applications and many of the platform tutorials use [MLRun](https://docs.mlrun.org) &mdash; Iguazio's end-to-end open-source MLOps solution for managing and automating your entire analytics and machine-learning life cycle, from data ingestion through model development to full pipeline deployment in production.
MLRun is available in the platform via a default (pre-deployed) shared platform service (`mlrun`).
However, to use MLRun from Python code (such as in the demo and tutorial notebooks), you also need to install the [MLRun Python package](https://docs.mlrun.org/) (`mlrun`).
The version of the installed package must match the version of the platform's MLRun service and must be updated whenever the service's version is updated.

The platform provides an [**align_mlrun.sh**](./align_mlrun.sh) script for simplifying the MLRun package installation and version synchronization with the MLRun service.
The script is available in the running-user directory (your Jupyter home directory), which is accessible via the `/User` data mount.
Use the following command to run this script for the initial package installation (after creating a new Jupyter Notebook service) and whenever the MLRun service is updated; (the command should be run for each Jupyter Notebook service):


```python
!/User/align_mlrun.sh
```

<a id="platform-resources"></a>

## Additional Platform Resources

You can find more information and resources in the MLRun documentation:
<br>
**&#x25B6; [View the MLRun documentation](https://docs.mlrun.org)**

You might also find the following resources useful:

- [Introduction video](https://www.youtube.com/watch?v=GS_4XUIudsY)
- [Platform Services](https://www.iguazio.com/docs/latest-release/services/)
- [Python SDK for management APIs](https://www.iguazio.com/docs/latest-release/cluster-mgmt/mgmt-sdk/): A Python SDK for controlling and performing operations on the the Iguazio system via REST-API.


<a id="misc"></a>

## Miscellaneous

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virtual-env](virtual-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="update-notebooks"></a>
### Updating the Tutorial Notebooks

You can use the provided **igz-tutorials-get.sh** script to get updated platform tutorials from the [tutorials GitHub repository](igz-tutorials-get.sh).
By default, the script retrieves the files from the latest release that matches the current platform version.
For details, see the [**update-tutorials.ipynb**](update-tutorials.ipynb) notebook.

<a id="v3io-dir"></a>
### The v3io Directory

The **v3io** directory that you see in the file browser of the Jupyter UI displays the contents of the `v3io` data mount for browsing the platform data containers. For information about the platform's data containers and how to reference data in these containers, see [Data Containers](https://www.iguazio.com/docs/latest-release/services/data-layer/containers/).

<a id="support"></a>
### Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.
