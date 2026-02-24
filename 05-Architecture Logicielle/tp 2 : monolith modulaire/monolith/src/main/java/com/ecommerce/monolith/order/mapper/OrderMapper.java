package com.ecommerce.monolith.order.mapper;

import com.ecommerce.monolith.order.dto.OrderDTO;
import com.ecommerce.monolith.order.dto.OrderItemDTO;
import com.ecommerce.monolith.order.model.Order;
import com.ecommerce.monolith.order.model.OrderItem;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderMapper {
    OrderDTO toOrderDTO(Order order);
    List<OrderDTO> toOrderDTOList(List<Order> orders);

    OrderItemDTO toOrderItemDTO(OrderItem orderItem);
    List<OrderItemDTO> toOrderItemDTOList(List<OrderItem> orderItems);
}
