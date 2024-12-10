# Welcome to the Iguazio AI Platform

An initial introduction to the Iguazio AI Platform and the platform tutorials:

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

The Iguazio AI Platform (**"the platform"**) is a fully integrated and secure data science platform that powers operational and responsible (gen) AI pipelines.
The platform provides:

- **Data Management**: Ensure data quality through data ingestion, transformation, cleansing, versioning, tagging, 
labeling, indexing and more.
- **Development and CI/CD**: Train and customize LLMs and AI models with high-quality model fine-tuning, RAG, 
RAFT & more. Validate and deploy with CI/CD for AI/ML.
- **Deployment/Inference**: Bring business value to live applications through a real-time application 
pipeline that handles requests, data, model and validations.
- **Monitoring & LiveOps**: Continuously monitor AI applications to improve performance, address regulation needs, 
remove PII, mitigate bias and more.

The platform components/capabilities used to implement the workflow are:

- A data science workbench that includes integrated analytics engines, and Python packages. You can work with your favorite 
IDE (e.g. Pycharm, VScode, Jupyter, Colab, etc.). Read how to configure your client against the deployed MLRun server in 
[Setting up your Environment](https://www.iguazio.com/docs/latest-release/intro/setup-env/).
- The [MLRun](https://mlrun.readthedocs.io) open-source orchestration framework for simplified management of your continuous 
ML and gen AI applications across their lifecycles.
- The [Nuclio](https://nuclio.io/) real-time serverless functions framework for model serving.
- Integration with third-party data sources such as Amazon S3, HDFS, SQL databases, and streaming or messaging protocols
- Real-time dashboards based on Grafana.

<a id="data-science-workflow"></a>
## Data Science Workflow

The platform provides a complete data science workflow in a single ready-to-use platform that includes all the required building blocks for creating data science applications from research to production:

- Collect, explore, and label data from various real-time or offline sources
- Run gen AI and ML training and validation, at scale, over multiple CPUs and GPUs
- Deploy models and applications into production with serverless functions
- Log, monitor, and visualize all your data and services

<br><img src="/assets/images/data-science-workflow.png" alt="Data science workflow" width="700"/></a><br>

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

<a id="demos"></a>
## Demos
Iguazio provides full end-to-end use-case application demos that demonstrate how to use the platform, its MLRun service, and related 
tools to address data science requirements for different industries and implementations.

 <a id="end-to-end-use-case-applications"></a>

### Gen AI Demos

<table width='100%' align="left"> 
    <tr align="left" style="border-bottom: 1pt solid black;">
    <th style="width:15%; vertical-align:'top'; font-weight:bold;">Demo</th>
    <th style="width:85%; vertical-align:'top'; font-weight:bold;">Description</th>
    </tr>
    <tr>
    <td style='min-width:45px;'>
        <b>	<a href="https://github.com/mlrun/demo-call-center/blob/main/README.md">Call center</a></b>
        </td>
        <td>This demo showcases how to use LLMs to turn audio files, from call center conversations between 
		customers and agents, into valuable data &mdash; all in a single workflow orchestrated by MLRun.
        MLRun automates the entire workflow, auto-scales resources as needed, and automatically logs and 
		parses values between the different workflow steps.		
        </td>
    </tr>
    <tr>
    <td align="left" style='min-width:45px;'>
        <b>	<a href="https://github.com/mlrun/demo-llm-tuning/blob/main/README.md">Build & deploy custom (fine-tuned) 
            LLM models and applications</a></b>
        </td>
        <td align="left" >This demo shows how to fine-tune an LLM and build a chatbot that can answer 
            all your questions about MLRun's MLOps. It starts with a pre-trained model from Hugging Face, 
            fine tunes the model, creates an automated training pipeline, and deploys a serving graph. 
            The serving graph includes post-processing for accuracy of generated text, and filtering for toxicity.		
        </td>
    </tr>	
   	<tr>
    <td style='min-width:45px;'>
        <b>	<a href="https://github.com/mlrun/demo-monitoring-and-feedback-loop/blob/main/README.md">Build & deploy custom (fine-tuned) LLM models and applications</a></b>
        </td>
        <td align="left" >This demo showcases how to train, deploy, and monitor LLM using an approach described as LLM 
            as a judge. It demo illustrates training an open-source model to answer banking-related questions only. 
            It does this by analyzing the responses that were generated by the model traffic, and retraining the model 
            according to the performance. The model performance analysis is done by a separate LLM that judges the 
            results. Once the dataset is large enough, you can then retrain the model and mesure the performance again.		
        </td>
    </tr>	
    <tr>
    <td style='min-width:45px;'>
        <b>	<a href="https://github.com/mlrun/demo-llm-bot/blob/main/README.md">Interactive Bot Demo using LLMs and MLRun</a></b>
        </td>
        <td align="left" >This repository demonstrates the usage of Language Models (LLMs) and MLRun to build an 
            interactive chatbot using your own data for Retrieval Augmented Question Answering. The data is 
            ingested and indexed into a Vector Database to be queried by an LLM in real-time.<br>            
            The project utilizes MLRun for orchestration/deployment, HuggingFace embeddings for indexing data, 
            Milvus for the vector database, OpenAI's GPT-3.5 model for generating responses, Langchain to 
            retrieve relevant data from the vector store and augment the response from the LLM, and Gradio 
            for building an interactive frontend.	
        </td>
    </tr>	
</table>

<a id="howto-demos"></a>
### ML Demos

You can update these demos with the [**update-demos.sh**](https://github.com/mlrun/demos/blob/master/update_demos.sh) 
script to get latest demos from this repository. 
By default, the script retrieves the files from the latest release that matches the version of the installed `mlrun` package (see [Installing and Updating the MLRun Python Package](#mlrun-python-pkg-install-n-update)).
The files are copied to the **/v3io/users/&lt;username&gt;/demos** directory, where `<username>` is the name of the running user (`$V3IO_USERNAME`) unless you set the `-u|--user` flag to another username.
> **Note:** Before running the script, close any open files in the **demos** directory.

```
# Get additional demos
!/User/update-demos.sh
```
For full usage instructions, run the script with the -h or --help flag:
```
!/User/update-demos.sh --help
```


<table align="left" width='100%'>
       <tr align="left" style="border-bottom: 1pt solid black;">
    <th style="width:15%; vertical-align:'top'; font-weight:bold;">Demo</th>
    <th style="width:15%; vertical-align:'top'; font-weight:bold;">Local</th>
           <th style="width:15%; vertical-align:'top'; font-weight:bold;">Github</th>
           <th style="width:85%; vertical-align:'top'; font-weight:bold;">Description</th>
    </tr>
	<tr>
        <td><b>Mask detection</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/mask-detection/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demo-mask-detection.git">
                <img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo contains 3 notebooks that:
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
            <a target="_blank" href="https://github.com/mlrun/demo-fraud">
                <img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>Demonstrates the feature store usage for fraud prevention: Data ingestion & preparation; Model training & testing; Model serving; Building An Automated ML Pipeline.
        </td>
    </tr>
    <tr>
        <td><b>Building Production Pipelines with AzureML and MLRun</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/news-article-nlp/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demo-azure-ML.git"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td>This demo uses the MLRun Feature Store to ingest and prepare data, create an offline feature vector (snapshot) for training, run AzureML AutoML Service as an automated step (function) in MLRun, view and compare the AzureML Models using MLRun tools, Build a real-time serving pipeline, and provide real-time model monitoring
        </td>
    </tr>
    <tr>
        <td><b>AWS SageMaker</b></td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a href="demos/network-operations/README.md"><img src="./assets/images/Jupyter-Logo-32px.png"/><br>Open locally</a>
        </td>
        <td align="center", style="min-width:45px; padding: 10px;">
            <a target="_blank" href="https://github.com/mlrun/demo-sagemaker/blob/main/README.md"><img src="./assets/images/GitHub-Mark-32px.png"/><br>View on GitHub</a>
        </td>
        <td >This demo showcases how to build, manage, and deploy ML models using AWS SageMaker and MLRun. 
		It emphasizes the automation of ML workflows from development to production.
        </td>
    </tr>
</table>

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
**&#x25B6; [View the MLRun documentation](https://docs.mlrun.org/en/stable/)**

You might also find the following resources useful:

- [Introduction video](https://www.youtube.com/watch?v=GS_4XUIudsY)
- [Platform Services](https://www.iguazio.com/docs/latest-release/services/)
- [Python SDK for management APIs](https://www.iguazio.com/docs/latest-release/cluster-mgmt/mgmt-sdk/): A Python SDK for controlling and performing operations on the the Iguazio system via REST-API.
- [Nuclio](https://docs.nuclio.io/en/stable/) for creating and deploying Nuclio functions

<a id="misc"></a>

## Miscellaneous

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virtual-env](virtual-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="v3io-dir"></a>
### The v3io Directory

The **v3io** directory that you see in the file browser of the Jupyter UI displays the contents of the `v3io` data mount for browsing the platform data containers. For information about the platform's data containers and how to reference data in these containers, see [Data Containers](https://www.iguazio.com/docs/latest-release/services/data-layer/containers/).

<a id="support"></a>
### Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.
