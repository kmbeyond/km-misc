resource "aws_s3_bucket" "km_s3_tf" {
  bucket = "km-s3-tf"

}

resource "aws_s3_bucket_policy" "km_s3_tf_policy" {
  bucket = aws_s3_bucket.km_s3_tf.id
  policy = data.aws_iam_policy_document.km_s3_policy.json
}

data "aws_iam_policy_document" "km_s3_policy" {
    statement {
        sid = "AllowFinanceListBucket"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = [ "arn:aws:iam::377569489066:user/km_finance" ]
        }
        actions = [ "s3:ListBucket" ]
        resources = [ aws_s3_bucket.km_s3_tf.arn ]
        condition {
            test = "StringLike"
            variable = "s3:prefix"
            #values = [ "Finance/" ]
            values = [ "Finance/*" ]   #ALSO WORKS
        }
    }

    statement {
        sid = "AllowFinanceGetObject"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = [ "arn:aws:iam::377569489066:user/km_finance" ]
        }
        actions = [ "s3:GetObject" ]
        #resources = [ "${aws_s3_bucket.km_s3_tf.arn}/Finance/*" ]
        resources = [ format("%s/%s", aws_s3_bucket.km_s3_tf.arn, "Finance/*") ]
    }

}