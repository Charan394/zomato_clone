pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
               git 'https://github.com/Charan394/zomato_clone.git'
            }
        }
        stage("building the image"){
            steps{
                sh'''
                
                docker build -t test:1.0 .
                
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
    }

	post{
	
	always{
	
		cleanWs()

	}


	}

}
