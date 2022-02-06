Script takes a k8 tls secret yaml file of the below form and replaces the `<CertText>` and `<KeyText>` values with an updated certificate. An assumption is made that this script is extended to generate the new certificate and key values.

```yaml
secret:
    certificate: >-
        <CertText>
    key: >-
        <KeyText>
```

The script should account for files where other fields are within the `secret` object other than `certificate` and `key`. It will also ensure the newly injected values maintain the existing indentation.

## Requirements:
- perl
