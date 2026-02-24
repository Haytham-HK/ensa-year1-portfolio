package com.ecommerce.monolith.customer.service;

import com.ecommerce.monolith.customer.dto.CreateCustomerRequest;
import com.ecommerce.monolith.customer.dto.CustomerDTO;
import com.ecommerce.monolith.customer.mapper.CustomerMapper;
import com.ecommerce.monolith.customer.model.Customer;
import com.ecommerce.monolith.customer.repository.CustomerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CustomerServiceImpl implements CustomerService {

    private final CustomerRepository repository;
    private final CustomerMapper mapper;

    @Override
    @Transactional(readOnly = true)
    public List<CustomerDTO> getAllCustomers() {
        return mapper.toDTOList(repository.findAll());
    }

    @Override
    @Transactional(readOnly = true)
    public CustomerDTO getCustomerById(Long id) {
        Customer customer = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found with id: " + id));
        return mapper.toDTO(customer);
    }

    @Override
    public CustomerDTO createCustomer(CreateCustomerRequest request) {
        Customer customer = mapper.toEntity(request);
        Customer saved = repository.save(customer);
        return mapper.toDTO(saved);
    }

    @Override
    public CustomerDTO updateCustomer(Long id, CreateCustomerRequest request) {
        Customer customer = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found with id: " + id));
        mapper.updateEntity(request, customer);
        Customer updated = repository.save(customer);
        return mapper.toDTO(updated);
    }

    @Override
    public void deleteCustomer(Long id) {
        if (!repository.existsById(id)) {
            throw new RuntimeException("Customer not found with id: " + id);
        }
        repository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean customerExists(Long id) {
        return repository.existsById(id);
    }
}
