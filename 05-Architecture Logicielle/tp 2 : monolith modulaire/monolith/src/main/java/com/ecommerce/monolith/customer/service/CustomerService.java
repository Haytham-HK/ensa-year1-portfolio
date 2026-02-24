package com.ecommerce.monolith.customer.service;

import com.ecommerce.monolith.customer.dto.CreateCustomerRequest;
import com.ecommerce.monolith.customer.dto.CustomerDTO;

import java.util.List;

public interface CustomerService {
    List<CustomerDTO> getAllCustomers();
    CustomerDTO getCustomerById(Long id);
    CustomerDTO createCustomer(CreateCustomerRequest request);
    CustomerDTO updateCustomer(Long id, CreateCustomerRequest request);
    void deleteCustomer(Long id);
    boolean customerExists(Long id);
}
