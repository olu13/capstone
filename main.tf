provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

// Task Definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                = "my-task-family"
  container_definitions = <<-EOT
    [
      {
        "name": "my-web-app",
        "image": "471112982662.dkr.ecr.us-east-1.amazonaws.com/my-web-app:latest",
        "cpu": 256,
        "memory": 512,
        "essential": true,
        "portMappings": [
          {
            "containerPort": 80,
            "hostPort": 80
          }
        ]
      }
    ]
  EOT
}

// ECS Service
resource "aws_ecs_service" "my_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1
  launch_type     = "EC2"
}

// Load Balancer
resource "aws_lb" "my_load_balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-07a91622ffb6ac848"]
  subnets            = [
    "subnet-08b974908240191aa",
    "subnet-0a52736d51a6edaf5",
    "subnet-0981d8102bbdb520f",
    "subnet-0f0bb9795e0215303",
    "subnet-02c28d9ea478551a8",
    "subnet-02e8d4b46a4f7d51f",
  ]
}

// Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-080ae127d0fdadb00"
}

// Listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    type             = "forward"
  }
}

// ECS Task Attachment to Target Group
resource "aws_lb_target_group_attachment" "ecs_attachments" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_ecs_service.my_service.id
}

/* Uncomment this section if you want to configure Route 53 record for your web app
resource "aws_route53_record" "my-webapp-dns" {
  depends_on = [aws_lb.my_load_balancer]  # Wait for the load balancer to be created
  zone_id    = "Z0535352AWZD8KPMMKDN"
  name       = "www.developerolu.com"
  type       = "CNAME"  # Use CNAME instead of A
  ttl        = "300"
  records    = [aws_lb.my_load_balancer.dns_name] # Use the DNS name created by the LB
}
*/
