                    #!/bin/bash
                    set -e  # Exit immediately if a command exits with a non-zero status

                    # Update the instance
                    sudo yum update -y

                    # Install necessary packages
                    sudo yum install -y ruby wget

                    # Install Docker
                    sudo yum -y install docker
                    sudo service docker start
                    sudo systemctl enable docker
                    sudo usermod -a -G docker ec2-user
                    sudo chmod 666 /var/run/docker.sock

                    # Install CodeDeploy agent
                    cd /home/ec2-user
                    wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
                    chmod +x ./install
                    sudo ./install auto

                    # Start the CodeDeploy agent service
                    sudo service codedeploy-agent start