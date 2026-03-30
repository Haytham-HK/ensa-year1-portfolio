package com.ecommerce.monolith.order.mapper;

import com.ecommerce.monolith.order.dto.OrderDTO;
import com.ecommerce.monolith.order.dto.OrderItemDTO;
import com.ecommerce.monolith.order.model.Order;
import com.ecommerce.monolith.order.model.OrderItem;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-02-24T22:18:28+0000",
    comments = "version: 1.5.2.Final, compiler: javac, environment: Java 17.0.18 (Ubuntu)"
)
@Component
public class OrderMapperImpl implements OrderMapper {

    @Override
    public OrderDTO toOrderDTO(Order order) {
        if ( order == null ) {
            return null;
        }

        OrderDTO orderDTO = new OrderDTO();

        orderDTO.setId( order.getId() );
        orderDTO.setCustomerId( order.getCustomerId() );
        orderDTO.setItems( toOrderItemDTOList( order.getItems() ) );
        orderDTO.setTotalPrice( order.getTotalPrice() );
        orderDTO.setStatus( order.getStatus() );
        orderDTO.setOrderDate( order.getOrderDate() );

        return orderDTO;
    }

    @Override
    public List<OrderDTO> toOrderDTOList(List<Order> orders) {
        if ( orders == null ) {
            return null;
        }

        List<OrderDTO> list = new ArrayList<OrderDTO>( orders.size() );
        for ( Order order : orders ) {
            list.add( toOrderDTO( order ) );
        }

        return list;
    }

    @Override
    public OrderItemDTO toOrderItemDTO(OrderItem orderItem) {
        if ( orderItem == null ) {
            return null;
        }

        OrderItemDTO orderItemDTO = new OrderItemDTO();

        orderItemDTO.setId( orderItem.getId() );
        orderItemDTO.setProductId( orderItem.getProductId() );
        orderItemDTO.setQuantity( orderItem.getQuantity() );
        orderItemDTO.setPrice( orderItem.getPrice() );

        return orderItemDTO;
    }

    @Override
    public List<OrderItemDTO> toOrderItemDTOList(List<OrderItem> orderItems) {
        if ( orderItems == null ) {
            return null;
        }

        List<OrderItemDTO> list = new ArrayList<OrderItemDTO>( orderItems.size() );
        for ( OrderItem orderItem : orderItems ) {
            list.add( toOrderItemDTO( orderItem ) );
        }

        return list;
    }
}
