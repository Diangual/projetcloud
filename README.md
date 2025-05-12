
```markdow
# Terraform Kubernetes Cluster Module 🚀

[![Trivy Security Scan](https://github.com/Diangual/projetcloud/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/Diangual/projetcloud/actions/workflows/trivy-scan.yml)
[![Terratest](https://github.com/Diangual/projetcloud/actions/workflows/terratest.yml/badge.svg)](https://github.com/Diangual/projetcloud/actions/workflows/terratest.yml)
[![Terraform Docs](https://img.shields.io/badge/docs-terraform--docs-blue)](https://github.com/Diangual/projetcloud/blob/main/README.md)

Un module Terraform modulaire pour déployer des clusters Kubernetes (EKS) avec des bonnes pratiques DevOps intégrées.

## 📺 Vidéo de Démonstration
[![Voir la démo](https://drive.google.com/file/d/1wqAwBn0r6ot3SP3cza0TFd4thi9i7-WW/view?usp=drive_link)](https://drive.google.com/file/d/1wqAwBn0r6ot3SP3cza0TFd4thi9i7-WW/view?usp=drive_link)

## 🛠 Fonctionnalités

- **Infrastructure as Code** : Provisionnement reproductible de clusters Kubernetes
- **Sécurité intégrée** : 
  - Analyse Trivy pour détecter les vulnérabilités
  - Politiques de sécurité pré-configurées
- **Tests automatisés** :
  - Tests d'intégration avec Terratest
  - Validation Terraform intégrée
- **Documentation auto-générée** via `terraform-docs`

## 📦 Structure du Module

```
│   .gitattributes
│   .gitignore
│   .pre-commit-config.yaml
│   .terraform-docs.yml
│   .terraform.lock.hcl
│   large_files.txt
│   main.tf
│   Makefile
│   test-project.sh
│
├───.github
│   └───workflows
│           terraform-validate.yml
│           trivy-scan.yml
│
├───examples
│   └───basic-eks
│           .terraform.lock.hcl
│           main.tf
│           outputs.tf
│           terraform.tfstate
│           terraform.tfstate.backup
│           tfplan
│           variables.tf
│
├───modules
│   └───eks-cluster
│           .terraform.lock.hcl
│           main.tf
│           networking.tf
│           outputs.tf
│           security.tf
│           variables.tf
│
└───tests
    └───terratest
            eks_test.go
            go.mod
            go.sum
            k8s_test.go
            README.md
```

## 🔧 Prérequis

- Terraform >= 1.6.0
- Go >= 1.20 (pour Terratest)
- Trivy >= 0.49

## 🚀 Installation

```bash
git clone https://github.com/Diangual/projetcloud.git
cd projetcloud
terraform init
```

## 📝 Documentation Auto-générée

<!-- BEGIN_TF_DOCS -->
```bash
terraform-docs markdown table --output-file README.md --output-mode inject .
```
<!-- END_TF_DOCS -->

## 🔒 Sécurité

Analyse des vulnérabilités avec Trivy :
```bash
trivy config --severity HIGH,CRITICAL .
```

## ✅ Tests

Exécuter les tests Terratest :
```bash
cd tests/terratest
go test -v -timeout 30m
```

## 🔄 Workflow CI/CD

![Diagramme CI/CD]

1. Pré-commit hooks :
   - Formatage Terraform
   - Validation de la syntaxe
   - Mise à jour de la documentation
   - Scan de sécurité

2. Pipeline GitHub Actions :
   - Déploiement de test
   - Exécution des tests Terratest
   - Analyse Trivy



## 📚 Ressources

- [Documentation Terraform](https://developer.hashicorp.com/terraform/docs)
- [Guide Terratest](https://terratest.gruntwork.io/)
- [Trivy pour IaC](https://aquasecurity.github.io/trivy/latest/docs/scanners/terraform/)

## 👥 Contribution

1. Forkez le projet
2. Créez une branche (`git checkout -b feature/ma-fonctionnalite`)
3. Commitez vos changements (`git commit -am 'Ajout d'une fonctionnalité'`)
4. Poussez vers la branche (`git push origin feature/ma-fonctionnalite`)
5. Ouvrez une Pull Request

---

✨ **Démo Complète** : [Voir la vidéo de démonstration](https://drive.google.com/file/d/1wqAwBn0r6ot3SP3cza0TFd4thi9i7-WW/view?usp=drive_link)
```
