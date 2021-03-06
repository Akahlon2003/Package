node{
    // Get Artifactory server instance, defined in the Artifactory Plugin administration page.
    def server = Artifactory.server "CHDSEZ296396L"
    // Create an Artifactory Maven instance.
    def rtMaven = Artifactory.newMavenBuild()

    def buildInfo
             
		    stage('Artifactory configuration') {
				// Tool name from Jenkins configuration
				rtMaven.tool = "maven_3_6_3"
				// Set Artifactory repositories for dependencies resolution and artifacts deployment.
				rtMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
				rtMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server
			}

			stage('Clone sources') {
                script{
                     
                     git(
					       url: 'https://github.com/Akahlon2003/Package.git',
					       credentialsId: 'Git-akahlon2003',
					       branch: 'master'
					     )
                }
            }
            
			stage('Maven build') {
				buildInfo = rtMaven.run pom: 'pom.xml', goals: 'clean install'
			}

			stage('Publish build info') {
				server.publishBuildInfo buildInfo
			}

}