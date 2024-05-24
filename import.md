# Steps to import a resource 

1. Create a empty resource:
```
resource "aws_instance" "jade-mw" {

}
```
2. Find the uniq field (ID) of the real resource
3. Import the resource with `terraform import `:
```
terraform import aws_instance.jade-mw <id-of-the-resource>
```
4. Now state is updated, you must check the terraform state and fill the resource fileds:
   + Use commands like the follow to show the resource fileds from tf.state:
    ```
    terraform show -json | jq '.values.root_module.resources[] | select(.type == "aws_instance" and .name == "jade-mw")'
    ```
    + Now fill the resource fields:
   ```
    resource "aws_instance" "jade-mw" {
      ami           = "ami-082b3eca746b12a89"
      instance_type = "t2.large"
      key_name      = "jade"
      tags = {
        Name = "jade-mw"
    }
   ```
