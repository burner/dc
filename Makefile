DC=dmd
CFLAGS=-c -odobjs
TARGET=dc
BUILD_NUMBER_FILE=CompilerInfo.d

all: $(TARGET)

OBJS=CompilerInfo.o main.o

CompilerInfo:
	sh IncreBuildId.sh

$(TARGET): CompilerInfo $(OBJS) Makefile
	$(DC) `find objs -name \*.o` -ofdc

count:
	wc -l `find -name "*.h" -or -name "*.cpp" -o -path ./tinyxml -prune -o -path ./glm -prune`

clean:
	rm -f objs/*.o $(TARGET)

CompilerInfo.o: Makefile CompilerInfo.d 
	$(DC) $(CFLAGS) CompilerInfo.d 

main.o: Makefile main.d
	$(DC) $(CFLAGS) main.d 
