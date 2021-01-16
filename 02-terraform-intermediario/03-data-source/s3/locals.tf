locals {
  instance = {
    id  = data.terraform_remote_state.instance.id
    ami = data.terraform_remote_state.instance.ami
    arn = data.terraform_remote_state.instance.arn
  }
}
