
output "aws_instance.public_instance.public_dns" {
  value = "${aws_instance.public_instance.public_dns}"
}
output "aws_instance.public_instance.private_ip" {
  value = "${aws_instance.public_instance.private_ip}"
}

output "aws_db_instance.default.address" {
  value = "${aws_db_instance.default.address}"
}
output "aws_db_instance.default.port" {
  value = "${aws_db_instance.default.port}"
}
output "aws_db_instance.default.username" {
  value = "${aws_db_instance.default.username}"
}
output "aws_db_instance.default.password" {
  value = "${aws_db_instance.default.password}"
}
output "aws_db_instance.default.engine" {
  value = "${aws_db_instance.default.engine}"
}   
output "aws_db_instance.default.db_name" {
  value = "${aws_db_instance.default.db_name}"
}

output "aws_security_group.public_sg.id" {
  value = "${aws_security_group.public_sg.id}"
}
output "aws_security_group.public_sg.name" {
  value = "${aws_security_group.public_sg.name}"
}
output "aws_security_group.db_sg.id" {
  value = "${aws_security_group.db_sg.id}"
}

output "aws_security_group.db_sg.name" {
  value = "${aws_security_group.db_sg.name}"
}

output "aws_security_group.elb_sg.id" {
  value = "${aws_security_group.elb_sg.id}"
}

output "aws_security_group.elb_sg.name" {
  value = "${aws_security_group.elb_sg.name}"
}

output "aws_elb.web_elb.dns_name" {
  value = "${aws_elb.web_elb.dns_name}"
}

output "aws_elb.web_elb.id" {
  value = "${aws_elb.web_elb.id}"
}
output "aws_elb.web_elb.name" {
  value = "${aws_elb.web_elb.name}"
}

output "aws_elb.web_elb.instances" {
  value = "${aws_elb.web_elb.instances}"
}

output "aws_elb.web_elb.listeners" {
  value = "${aws_elb.web_elb.listeners}"
}
output "aws_elb.web_elb.health_check" {
  value = "${aws_elb.web_elb.health_check}"
}
output "aws_elb.web_elb.security_groups" {
  value = "${aws_elb.web_elb.security_groups}"
}
output "aws_elb.web_elb.subnets" {
  value = "${aws_elb.web_elb.subnets}"
}
output "aws_elb.web_elb.zone_id" {
  value = "${aws_elb.web_elb.zone_id}"
}
output "aws_elb.web_elb.source_security_group" {
  value = "${aws_elb.web_elb.source_security_group}"
}
output "aws_elb.web_elb.tags" {
  value = "${aws_elb.web_elb.tags}"
}
output "aws_elb.web_elb.cross_zone_load_balancing" {
  value = "${aws_elb.web_elb.cross_zone_load_balancing}"
}

output "aws_iam_instance_profile.ec2_instance_profile.id" {
  value = "${aws_iam_instance_profile.ec2_instance_profile.id}"
}

output "aws_iam_instance_profile.ec2_instance_profile.name" {
  value = "${aws_iam_instance_profile.ec2_instance_profile.name}"
}

output "aws_iam_role.ec2_role.id" {
  value = "${aws_iam_role.ec2_role.id}"
}

output "aws_iam_role.ec2_role.name" {
  value = "${aws_iam_role.ec2_role.name}"
}

output "aws_iam_role.ec2_role.arn" {
  value = "${aws_iam_role.ec2_role.arn}"
}

output "aws_iam_role.ec2_role.assume_role_policy" {
  value = "${aws_iam_role.ec2_role.assume_role_policy}"
}

output "aws_iam_role_policy.ec2_role_policy.id" {
  value = "${aws_iam_role_policy.ec2_role_policy.id}"
}

output "aws_iam_role_policy.ec2_role_policy.role" {
  value = "${aws_iam_role_policy.ec2_role_policy.role}"
}