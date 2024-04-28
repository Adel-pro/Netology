pipeline{
    agent{
        label 'ansible'
    }
    stages{
        stage('First'){
            steps{
                sh 'cd /opt/jenkins_agent/workspace/freestyle'
            }
        }
        stage('Second'){
            steps{
                sh 'molecule test'
            }
        }    
    }
}
