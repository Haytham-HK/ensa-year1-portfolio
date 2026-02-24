package com.ecommerce.monolith.order.dto;

import com.ecommerce.monolith.order.model.OrderStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderDTO {
    private Long id;
    private Long customerId;
    private List<OrderItemDTO> items;
    private BigDecimal totalPrice;
    private OrderStatus status;
    private LocalDateTime orderDate;
}
