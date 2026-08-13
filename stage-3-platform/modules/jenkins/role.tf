#########################################################
# Jenkins Role
#########################################################

resource "kubernetes_role" "jenkins" {

  metadata {

    name = "jenkins"

    namespace = var.namespace

  }

  #######################################################
  # Pods
  #######################################################

  rule {

    api_groups = [""]

    resources = [

      "pods",

      "pods/log",

      "pods/exec"

    ]

    verbs = [

      "create",

      "delete",

      "get",

      "list",

      "watch",

      "patch"

    ]

  }

  #######################################################
  # Secrets
  #######################################################

  rule {

    api_groups = [""]

    resources = [

      "secrets"

    ]

    verbs = [

      "get",

      "list"

    ]

  }

  #######################################################
  # ConfigMaps
  #######################################################

  rule {

    api_groups = [""]

    resources = [

      "configmaps"

    ]

    verbs = [

      "get",

      "list"

    ]

  }

  #######################################################
  # PVC
  #######################################################

  rule {

    api_groups = [""]

    resources = [

      "persistentvolumeclaims"

    ]

    verbs = [

      "get",

      "list"

    ]

  }

}