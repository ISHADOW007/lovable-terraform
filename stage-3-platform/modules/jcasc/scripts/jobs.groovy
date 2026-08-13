folder("Lovable") {

    description("Lovable CI/CD Pipelines")

}

def pipelines = [

    [
        name : "frontend",
        script : "frontend/Jenkinsfile"
    ],

    [
        name : "api-gateway",
        script : "api-gateway/Jenkinsfile"
    ],

    [
        name : "account-service",
        script : "account-service/Jenkinsfile"
    ],

    [
        name : "config-service",
        script : "config-service/Jenkinsfile"
    ],

    [
        name : "workspace-service",
        script : "workspace-service/Jenkinsfile"
    ],

    [
        name : "intelligence-service",
        script : "intelligence-service/Jenkinsfile"
    ]

]

pipelines.each { pipeline ->

    pipelineJob("Lovable/${pipeline.name}") {

        description("${pipeline.name} Pipeline")

        logRotator {

            daysToKeep(30)

            numToKeep(20)
        }

        definition {

            cpsScm {

                scm {

                    git {

                        remote {

                            url("https://github.com/ISHADOW007/distributed-lovable.git")

                            credentials("github-creds")
                        }

                        branch("*/main")
                    }
                }

                scriptPath(pipeline.script)
            }
        }

        triggers {

            githubPush()

        }
    }
}