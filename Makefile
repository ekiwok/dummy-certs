clean:
	rm -f *.key

private-key:
	openssl genrsa -des3 -out rootCA.key 2048

ca:
	openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt

domain-private-key:
	openssl genrsa -out $$DOMAIN.key 2048

domain-csr:
	openssl req -new -sha256 -key $$DOMAIN.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=dev.kowalczyk.codes" -out $$DOMAIN.csr

verify-csr:
	openssl req -in $$DOMAIN.csr -noout -text

domain-cert:
	openssl x509 -req -in $$DOMAIN.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $$DOMAIN.crt -days 500 -sha256
