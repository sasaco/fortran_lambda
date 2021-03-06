TARGET=hello
IMAGE=fortran-lambda:latest

all: $(TARGET).zip

$(TARGET).zip: $(TARGET) bootstrap
	zip $(TARGET).zip bootstrap $(TARGET)

$(TARGET): ./app/hello.f90
	docker build -t $(IMAGE) .
	docker run -it --rm -v `pwd`:/tmp -w /tmp --entrypoint=cp $(IMAGE) /$(TARGET) /tmp

# test:
# 	docker run -it --rm $(IMAGE) /$(TARGET)

# clean:
# 	rm -f $(TARGET) *.zip
