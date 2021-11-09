resource "aws_instance" "instance" {
  ami                  = "ami-02d36247c5bc58c23"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public0.id
  iam_instance_profile = aws_iam_instance_profile.instance.name
}

resource "aws_iam_instance_profile" "instance" {
  name = "InstanceProfile"
  role = aws_iam_role.instance.name
}

resource "aws_iam_role" "instance" {
  name               = "instance-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    sid     = "AssumeServiceRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "instance" {
  role       = aws_iam_role.instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

output "instance_id" {
  value = aws_instance.instance.id
}
