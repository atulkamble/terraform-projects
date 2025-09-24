import json

def lambda_handler(event, context):
    message = {
        "message": "Hello from Terraform-managed Lambda!",
        "input": event,
    }
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(message),
    }
