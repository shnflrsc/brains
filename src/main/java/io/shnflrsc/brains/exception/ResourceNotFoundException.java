package io.shnflrsc.brains.exception;

public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String resourceType, Object identifier) {
        super(String.format("%s not found with identifier: '%s'", resourceType, identifier));
    }
}
