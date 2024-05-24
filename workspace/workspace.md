# Commands:

+ new workspace: `terraform workspace new Proj1`
+ list workspaces: `terraform workspace list`
+ you can use `terraform.workspace` in the terraform code to access current workspace name.
+ select workspace: `terraform workspace select Proj1`

> When using workspaces, tfstate files are saved in `terraform.tfsate.d`:
  ```
  terraform.tfsate.d/
  |--Proj1
  |  `-- terraform.tfstate
  |--Proj2
  |  `-- terraform.tfstate
  ```

# Links
[Handling environmental variables in Terraform Workspaces](https://medium.com/@milescollier/handling-environmental-variables-in-terraform-workspaces-27d0278423df)
