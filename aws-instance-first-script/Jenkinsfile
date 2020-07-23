
pipeline {

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
        options {
                timestamps ()
                ansiColor('xterm')
            }
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/easyawslearn/Terraform-Tutorial.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/aws-instance-first-script ; terraform init -input=false'
                sh 'pwd;cd terraform/aws-instance-first-script ; terraform workspace new ${environment}'
                sh 'pwd;cd terraform/aws-instance-first-script ; terraform workspace select ${environment}'
                sh "pwd;cd terraform/aws-instance-first-script ;terraform plan -input=false -out tfplan "
                sh 'pwd;cd terraform/aws-instance-first-script ;terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/aws-instance-first-script/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/aws-instance-first-script ; terraform apply -input=false tfplan"
            }
        }
    }

  }
