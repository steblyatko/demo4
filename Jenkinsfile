node {
	def app
	def image = 'registry.hub.docker.com/steblyatko/demo4'
	def branch = 'main'
	
	try {
		stage('Clone repository') {               
	    	git branch: branch,
	        	credentialsId: 'GitHub Credentials',
	        	url: 'https://github.com/steblyatko/demo4.git'
	    } 
	
		stage('Build WAR') {
	    	docker.image('maven:3.6.2-jdk-11').inside('-v /root/.m2:/root/.m2') {
	        	sh 'mvn -B clean package'
	        	stash includes: '**/target/*.war', name: 'war'
	    	}
	    }
	     
	    stage('Build Image') {
	    	unstash 'war'
			app = docker.build image
	    }
	    
	    stage('Push') {
	    	docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {            
				app.push("${env.BUILD_NUMBER}")
	        }    
	    }
	} catch (e) {
		echo 'Error occurred during build process!'
		echo e.toString()
		currentBuild.result = 'FAILURE'
	} finally {
        junit '**/target/surefire-reports/TEST-*.xml'		
	}
}
