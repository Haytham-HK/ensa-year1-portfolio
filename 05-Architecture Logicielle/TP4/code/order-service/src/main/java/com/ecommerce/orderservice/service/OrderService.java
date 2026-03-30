package com.ecommerce.orderservice.service;

import com.ecommerce.orderservice.client.ProductClient;
import com.ecommerce.orderservice.dto.ProductDTO;
import com.ecommerce.orderservice.model.Order;
import com.ecommerce.orderservice.repository.OrderRepository;
import com.ecommerce.orderservice.exceptions.OrderCreationException; // Import the custom exception
import lombok.RequiredArgsConstructor;
import feign.FeignException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductClient productClient;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order createOrder(Long productId, Integer quantity) {
        try {
            ProductDTO product = productClient.getProductById(productId);

            if (product.getStock() < quantity) {
                throw new OrderCreationException("Insufficient stock for product: " + product.getName());
            }
            
            productClient.updateStock(productId, quantity);

            Order order = new Order();
            order.setProductId(productId);
            order.setProductName(product.getName());
            order.setQuantity(quantity);
            order.setTotalPrice(product.getPrice() * quantity);
            order.setOrderDate(LocalDateTime.now());
            order.setStatus("PENDING");

            return orderRepository.save(order);
        } catch (FeignException e) { // Catch general FeignException
            throw new OrderCreationException(e.getMessage());
        }
    }
}
