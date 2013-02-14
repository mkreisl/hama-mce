HAMAMCE_OBJS = hama_mce.o
HAMAMCE_EXE = hama_mce

ifeq ($(strip $(DEBUG)),Y)
  CXXFLAGS += -g -DDEBUG
else
  ifndef CXXFLAGS
    CXXFLAGS += -O2
  endif
  LDFLAGS += -s
endif

CXXFLAGS += -Wall -Werror -pipe -ansi

# ---------------------------------------------------------------------
#  libUSB
# ---------------------------------------------------------------------
#CXXFLAGS += -I/usr/local/include/libusb-1.0
LIBS = -lusb-1.0 -lrt


all : $(HAMAMCE_EXE)

update:
	install -m755 $(HAMAMCE_EXE) /usr/sbin

install:
	install -m755 $(HAMAMCE_EXE) /usr/sbin
	install -m644 hama_mce.rules /etc/udev/rules.d
	install -m644 99_hama_mce /etc/pm/sleep.d
	install -m644 hama_mce.xml $(HOME)/.xbmc/userdata/keymaps

$(HAMAMCE_EXE) : $(HAMAMCE_OBJS)
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

.PHONY : clean
clean :
	-rm $(HAMAMCE_EXE) $(HAMAMCE_OBJS)
