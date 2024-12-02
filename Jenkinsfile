def appSourceRepo = 'https://github.com/nvthao710/migration-database.git'
def appSourceBranch = 'main'

def githubAccount = 'github-account'

pipeline {
    agent any
    
    parameters {
        string(name: 'TARGET', defaultValue: 'Default', description: 'TARGET')
        string(name: 'USERID', defaultValue: 'sa', description: 'USERID')
        string(name: 'PASSWORD', defaultValue: '123456x@X', description: 'PASSWORD')
        string(name: 'CONNECTION_STRING', defaultValue: 'Release', description: 'Configuration to build (Debug/Release/...)')
        string(name: 'DATABASE_NAME', defaultValue: 'RoundHouse2', description: 'DATABASE_NAME')
        string(name: 'ENVIRONMENT', defaultValue: 'Sandbox', description: 'ENVIRONMENT')
        string(name: 'SERVER_NAME', defaultValue: '172.16.97.207,1422', description: 'SERVER_NAME')
    }
    
    environment {
        TARGET = "${params.TARGET}"
        USERID = "${params.USERID}"
        PASSWORD = "${params.PASSWORD}"
        CONNECTION_STRING = "${params.CONNECTION_STRING}"
        DATABASE_NAME = "${params.DATABASE_NAME}"
        ENVIRONMENT = "${params.ENVIRONMENT}"
        SERVER_NAME = "${params.SERVER_NAME}"
    }

    stages {
        stage('Checkout project') {
            steps {
                git branch: appSourceBranch,
                    credentialsId: githubAccount,
                    url: appSourceRepo
            }
        }
        stage('Build and Run Docker') {
            steps {
                sh "docker build -t roundhouse-image ."
                sh "docker run --rm -e TARGET=$TARGET -e ENVIRONMENT=$ENVIRONMENT -e DATABASENAME=$DATABASE_NAME -e SERVERNAME=$SERVER_NAME -e USERID=$USERID -e PASSWORD=$PASSWORD roundhouse-image:latest"
                // sh 'docker build -t roundhouse-image .'
                // sh "docker run -e ENVIRONMENT=$ENVIRONMENT roundhouse-image"
            }
        }
    }
}