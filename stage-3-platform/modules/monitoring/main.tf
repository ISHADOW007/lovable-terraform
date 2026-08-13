


resource "helm_release" "this" {


  name = "monitoring"


  repository = "https://prometheus-community.github.io/helm-charts"


  chart = "kube-prometheus-stack"


  namespace = "monitoring"


  values = [

    file("${path.module}/values.yaml")

  ]


  depends_on = [

    

  ]

}