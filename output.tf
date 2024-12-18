output "vpc_id"{
    value=aws_vpc.main.id
}

output "az_info"{
    value=data.aws_availability_zones.available
}

output "vpc_default_info"{
    value=data.aws_vpc.default
}

output "route_table_default_info"{
    value=data.aws_route_table.default
}