resource "aws_vpc_peering_connection" "main"{
    count=var.is_peering_required ? 1 : 0
    vpc_id=aws_vpc.main.id
    peer_vpc_id=data.aws_vpc.default.id
    auto_accept=true
    tags=merge(
        var.common_tags,
        var.vpc_peering_connection_tags,
        {
            Name="${local.resource_name}-default"
        }
    )
}

resource "aws_route" "public_peering"{
    count=var.is_peering_required ? 1 : 0
    route_table_id=aws_route_table.public.id
    destination_cidr_block=data.aws_vpc.default.cidr_block
    vpc_peering_connection_id=aws_vpc_peering_connection.main[count.index].id
}

resource "aws_route" "private_peering"{
    count=var.is_peering_required ? 1 : 0
    route_table_id=aws_route_table.private.id 
    destination_cidr_block=data.aws_vpc.default.cidr_block
    vpc_peering_connection_id=aws_vpc_peering_connection.main[count.index].id
}

resource "aws_route" "default_peering"{
    count=var.is_peering_required ? 1 : 0
    route_table_id=data.aws_route_table.default.id
    destination_cidr_block=var.cidr_block
    vpc_peering_connection_id=aws_vpc_peering_connection.main[count.index].id
}