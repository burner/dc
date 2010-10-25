DC=dmd
CFLAGS=-c -Isrc 
TARGET=dc
BUILD_NUMBER_FILE=CompilerInfo.d

all: $(TARGET)

OBJS=identifer.o stringbuffer.o token.o

$(TARGET): $(OBJS) Makefile main.d
	sh IncreBuildId.sh
	$(DC) $(CFLAGS) compilerinfo.d
	$(DC) $(CFLAGS) main.d
	$(DC) *.o -ofdc

run: $(TARGET)
	./dc

count:
	wc -l `find -name "*.d"`

clean:
	rm -f objs/*.o $(TARGET)
	rm -f *.o $(TARGET)

identifer.o: Makefile src/lex/identifer.d
	$(DC) $(CFLAGS) src/lex/identifer.d 

compilerinfo.o: Makefile compilerinfo.d 
	$(DC) $(CFLAGS) compilerInfo.d 

stringbuffer.o: Makefile src/util/stringbuffer.d
	$(DC) $(CFLAGS) src/util/stringbuffer.d 

token.o: Makefile src/lex/token.d
	$(DC) $(CFLAGS) src/lex/token.d 

