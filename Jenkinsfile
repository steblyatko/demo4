node {
    stage ("Scm Checkout"){
      git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/steblyatko/demo4' 
    }

    stage("Mvn Package"){
        def mvnHome = tool name: 'maven', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
    }
    stage("Build Docker Image"){
        def dockerHome = tool name: 'docker', type: 'dockerTool'
        def dockerCMD = "${dockerHome}"
        sh "docker build -t profan97/testoms:latest ."
    }
    stage("Push Docker Image"){
        withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
            sh "docker login -u profan97 -p ${dockerHubPwd}"
        }
        sh 'docker push profan97/testoms:latest'
    }
}

