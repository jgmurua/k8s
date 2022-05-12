resource "aws_ebs_volume" "ebscontroler" {
  count             = var.controller_count
  availability_zone = var.availability_zone
  size              = var.ebs_size
  type              = "gp3"
}

resource "aws_volume_attachment" "ebs_att_controler" {
  count       = var.controller_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebscontroler[count.index].id
  instance_id = aws_instance.cluster-controller[count.index].id
}

resource "aws_ebs_volume" "ebs_sec" {
  count             = var.worker_count
  availability_zone = var.availability_zone
  size              = var.ebs_size
  type              = "gp3"
}

resource "aws_volume_attachment" "ebs_att_sec" {
  count       = var.worker_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_sec[count.index].id
  instance_id = aws_spot_instance_request.cluster-workers[count.index].spot_instance_id
}

