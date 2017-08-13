PREFIX=/usr
BINDIR=$(PREFIX)/bin

VC_LIBDIR ?= /opt/vc/lib
VC_INCDIR ?= /opt/vc/include

INCLUDES+=-I$(VC_INCDIR) -I$(VC_INCDIR)/interface/vmcs_host/linux -I$(VC_INCDIR)/interface/vcos/pthreads 
LIBFLAGS=-L$(VC_LIBDIR) -lvchostif -lbcm_host -lpng 


OBJS=raspi2png.o
BIN=raspi2png

# CFLAGS+=-Wall -g -O3 $(shell libpng-config --cflags)
# LDFLAGS+=-L$(VC_LIBDIR) -lbcm_host $(shell libpng-config --ldflags) -lm

all: $(BIN)

install: $(BIN)
	install -d -m 755 $(DESTDIR)$(BINDIR)
	install -m 755 $(BIN) $(DESTDIR)$(BINDIR)/raspi2png

%.o: %.c
	@rm -f $@ 
	$(CC) $(CFLAGS) $(INCLUDES) -g -c $< -o $@ 
	#$(CC) $(CFLAGS) $(INCLUDES) -g -c $< -o $@ -Wno-deprecated-declarations

$(BIN): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LIBFLAGS) 
	#$(CC) -o $@ -Wl,--whole-archive $(OBJS) $(LIBFLAGS) -Wl,--no-whole-archive -rdynamic

clean:
	@rm -f $(OBJS)
	@rm -f $(BIN)
