// =============================================================================
// Jenkinsfile - CI/CD Pipeline Guide
// =============================================================================
// This file will define your automated Continuous Integration & Continuous
// Deployment pipeline using Jenkins Declarative Pipeline syntax.
//
// Key Concepts:
// - Declarative Pipelines use a 'pipeline { ... }' block.
// - 'agent any': Tells Jenkins to run on any available worker node.
// - 'environment { ... }': Store variables and credential references.
// - 'stages { ... }': Contains individual steps executed sequentially.
// - 'post { ... }': Runs cleanup or notifications on success or failure.
//
// Step-by-Step Guide for when you write this pipeline:
//
// 1. Root Block:
//    pipeline {
//        agent any
//
// 2. Define Environment Variables:
//    environment {
//        APP_NAME = "notification-gateway"
//        DOCKER_IMAGE = "your-dockerhub-or-ecr-repo:${env.BUILD_NUMBER}"
//    }
//
// 3. Define Stages:
//    stages {
//        stage('Checkout') {
//            // Step: Check out source code from git
//            // steps { checkout scm }
//        }
//
//        stage('Lint & Quality') {
//            // Step: Run flake8 or black to verify code style
//            // steps { sh 'flake8 app/src' }
//        }
//
//        stage('Run Tests') {
//            // Step: Run pytest with test coverage
//            // steps { sh 'pytest app/tests' }
//        }
//
//        stage('Build Docker Image') {
//            // Step: Build the container image using app/Dockerfile
//            // steps { sh 'docker build -t $DOCKER_IMAGE app/' }
//        }
//
//        stage('Deploy to Kubernetes') {
//            // Step: Apply Kubernetes manifests using kubectl or kustomize
//            // steps { sh 'kubectl apply -k k8s/base/' }
//        }
//    }
//
// 4. Post Actions:
//    post {
//        always {
//            // Clean up workspace
//            // cleanWs()
//        }
//        failure {
//            // Optional: Ping your Telegram if the build fails!
//        }
//    }
// }
