# resource "aws_instance" "cluster-workers" {
#   count         = var.worker_count
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.cluster_flavor
#   subnet_id = var.private_subnet_id

#   tags = {
#     Name = "worker"
#   }
#   key_name                    = aws_key_pair.cluster-key.key_name
#   vpc_security_group_ids      = [aws_security_group.cluster_allow_ssh.id]
#   associate_public_ip_address = true
#   source_dest_check = false

#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 20
#   }
# }

resource "aws_spot_instance_request" "cluster-workers" {
  count                       = var.worker_count
  availability_zone           = var.availability_zone
  ami                         = data.aws_ami.ubuntu.id
  spot_price                  = var.spot_price
  instance_type               = var.cluster_flavor
  spot_type                   = "one-time"
  block_duration_minutes      = 0
  wait_for_fulfillment        = "true"
  key_name                    = aws_key_pair.cluster-key.key_name
  vpc_security_group_ids      = [aws_security_group.cluster_allow_ssh.id]
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "worker"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
  }

}