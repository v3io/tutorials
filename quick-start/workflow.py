from kfp import dsl
import mlrun

DATASET = 'cleaned_data'

# Create a Kubeflow Pipelines pipeline
@dsl.pipeline(
    name="Getting-started-tutorial",
    description="Demonstrate some of the main capabilities of MLRun"
)
def kfpipeline(source_url, model_name="iris"):
    project = mlrun.get_current_project()

    # Ingest the data set
    ingest = mlrun.run_function(
        'prep-data',
        handler='prep_data',
        inputs={'source_url': source_url},
        params={'label_column': project.get_param("label_column")},
        outputs=[DATASET])
    
    # Train a model   
    train = mlrun.run_function(
        "train",
        params={"label_column": project.get_param("label_column")},
        inputs={"dataset": ingest.outputs[DATASET]},
        outputs=['model', 'test_set'])
    
    # Test and visualize the model
    test = mlrun.run_function(
        "hub://test_classifier",
        params={"label_column": project.get_param("label_column")},
        inputs={"models_path": train.outputs['model'],
                "test_set": train.outputs['test_set']})
    
    # Deploy the model as a serverless function
    serving = mlrun.import_function("hub://v2_model_server", new_name="serving")
    deploy = mlrun.deploy_function(serving,
                                   models=[{"key":model_name, "model_path": train.outputs['model']}])