// Create IAM Role + Instance Profile if it doesn't exists

resource "aws_iam_instance_profile" "susapi_instance_profile" {
  count = var.create_iam_role ? 1 : 0
  name = "SusApiInstanceProfile"
  role = aws_iam_role.susapi_role[0].name
}

data "aws_iam_policy_document" "assume_role_ec2" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy" "ec2_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
data "aws_iam_policy" "amazon_s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
 

resource "aws_iam_role_policy_attachment" "attach_ec2_policy" {
  count      = var.create_iam_role ? 1 : 0
  role       = aws_iam_role.susapi_role[0].name
  policy_arn = data.aws_iam_policy.ec2_full_access.arn
}
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  count      = var.create_iam_role ? 1 : 0
  role       = aws_iam_role.susapi_role[0].name
  policy_arn = data.aws_iam_policy.amazon_s3_full_access.arn
}


resource "aws_iam_role" "susapi_role" {
  count              = var.create_iam_role ? 1 : 0
  name               = "SusApiInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
}