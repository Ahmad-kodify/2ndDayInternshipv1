pipeline {
    agent any

    environment {
        SSH_KEY = credentials('jenkins-ssh-key')   // SSH private key stored in Jenkins
        SERVER_USER = "ubuntu"                     // change if needed
        SERVER_IP = "16.171.39.254"                  // your EC2 instance IP
        PROJECT_DIR = "/var/www/laravel-app"       // your Laravel app path on EC2
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['jenkins-ssh-key']) {

                    sh """
                    ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP '
                        cd $PROJECT_DIR &&
                        sudo git pull origin main &&
                        composer install --no-interaction --prefer-dist &&
                        php artisan migrate --force &&
                        npm install &&
                        npm run build &&
                        php artisan config:cache &&
                        php artisan route:cache &&
                        sudo systemctl restart nginx
                    '
                    """
                }
            }
        }
    }
}
