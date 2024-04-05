resource "aws_ecs_task_definition" "back_task" {
  family                   = "backend-image"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 1024

  container_definitions = <<DEFINITION
[
  {
    "image": "${var.account_id}.dkr.ecr.us-east-1.amazonaws.com/backend-image:latest",
    "cpu": 256,
    "memory": 1024,
    "name": "backend-image",
    "networkMode": "awsvpc",
    "linuxParameters": {
      "initProcessEnabled": true
    },
    "enableExecuteCommand": true,
    "portMappings": [
      {
        "containerPort": 5002,
        "hostPort": 5002
      }
    ],
    "environment": [
        {
          "name": "AUTH_URI",
          "value": "string"
        },
        {
          "name": "TOKEN_URI",
          "value": "string"
        },
        {
          "name": "AUTH_PROVIDER_CERT_URL",
          "value": "string"
        },
        {
          "name": "DB_ROOT_USERNAME",
          "value": "string"
        },
        {
          "name": "DB_ROOT_PASSWORD",
          "value": "string"
        },
        {
          "name": "DB_HOST",
          "value": "mongodb"
        },
        {
          "name": "DB_PORT",
          "value": "27017"
        },
        {
          "name": "MONGODB_URI",
          "value": "string"
        },
        {
          "name": "DEFAULT_DB",
          "value": "mongodb"
        },
        {
          "name": "PORT",
          "value": "5002"
        },
        {
          "name": "AUTH_PRIVATE_KEY_ID",
          "value": "string"
        },
        {
          "name": "AUTH_PRIVATE_KEY",
          "value": "string"
        },
        {
          "name": "AUTH_CLIENT_EMAIL",
          "value": "string"
        },
        {
          "name": "AUTH_CLIENT_ID",
          "value": "string"
        },
        {
          "name": "AUTH_CLIENT_CERT_URL",
          "value": "string"
        },
        {
          "name": "AUTH_API_KEY",
          "value": "string"
        },
        {
          "name": "AUTH_DOMAIN",
          "value": "string"
        },
        {
          "name": "AUTH_PROJECT_ID",
          "value": "string"
        },
        {
          "name": "AUTH_STORAGE_BUCKET",
          "value": "string"
        },
        {
          "name": "AUTH_MESSAGING_SENDER_ID",
          "value": "string"
        },
        {
          "name": "AUTH_APP_ID",
          "value": "string"
        },
        {
          "name": "AUTH_MEASUREMENT_ID",
          "value": "string"
        },
        {
          "name": "PRIVATE_KEY_V2",
          "value": "string"
        },
        {
          "name": "PRIVATE_KEY_ADMIN_V2",
          "value": "string"
        }
    ]
  }
]

DEFINITION
  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn         = aws_iam_role.ecsTaskRole.arn

  tags = {
    Project = var.tag_project_name
  }
}
