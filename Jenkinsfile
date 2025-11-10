pipeline {
    agent {
        label "slave"
    }

    stages {
        stage('Hello') {
            steps {
               git 'https://github.com/Charan394/zomato_clone.git'
            }
        }
        stage("building the image"){
            steps{
                sh'''
                
                docker build -t charan027/test:1.0 .
                
                '''
            }
        }
         stage("pushing  the image and clean up"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'psw', usernameVariable: 'user')]) {
   

                
                sh"""
                echo "${psw}" | docker login -u ${user} --password-stdin
		            docker push ${user}/test:1.0
		            docker image rm ${user}/test:1.0
		
                
                """
			}
            }
        }

        stage("Deploy to EKS") {
            steps {
                script {
                    echo "Deploying to EKS cluster..."
                    
                  
                    //    This works because the slave has the 'Jenkins-EKS-Role'
                    sh "aws eks update-kubeconfig --name zomato-cluster --region us-east-1"
                    
                    // 2. Apply the new configuration from our k8s folder
                    //    This will update the deployment with the new image
                    sh "kubectl apply -f k8/"
                    
                    echo "Deployment complete."
                }
            }
        }
    }

	post{
	
	always{
	
		cleanWs()

	}


	}

}
