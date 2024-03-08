locals {
    web_name = "${var.coarse_name}-${var.vpc_name}-${var.base_name}-${var.destination_web_name}"
    db_name  = "${var.coarse_name}-${var.vpc_name}-${var.base_name}-${var.destination_db_name}"
}