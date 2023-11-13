output "instance" {
  value = {
    id  = aws_instance.example.id
    arn = aws_instance.example.arn
  }
}

output "pet" {
  value = random_pet.this[0].id
}
