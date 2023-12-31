pipeline {
    agent any
    environment {
	AWS_ACCOUNT_ID="775956577581"
	AWS_DEFAULT_REGION="us-west-1" 
	IMAGE_REPO_NAME="hello-repository"
	IMAGE_TAG="latest"
	REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {

	stage('Logging into AWS ECR') {
	    steps {
		script {
		    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
		}

	    }
	}

	stage('Building Docker image') {
	    steps{
		script {
		    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
		}
	    }
	}

	stage('Pushing container to ECR') {
	    steps{ 
		script {
		    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
		    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
		}
            }
	}
	stage('Deploying container to K8s') {
	    steps {
		sh 'pwd'
		sh 'ls'
		sh '/usr/local/bin/kubectl apply -f k8s/deployment.yaml'
		sh '/usr/local/bin/kubectl apply -f k8s/service.yaml'
	    }
	}
    }
}
