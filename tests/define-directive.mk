define COMMANDS
shellvar=hello
test "$$shellvar" != "hello"
endef

define COMMANDS2
shellvar=hello; \
  test "$$shellvar" = "hello"
endef

define TEST3
  whitespace
endef

define TEST4
define TEST5
random
endef
  endef

ifdef TEST5
$(error TEST5 should not be set)
endif

define TEST6
  define TEST7
random
endef
endef

ifdef TEST7
$(error TEST7 should not be set)
endif

define TEST8
is this # a comment?
endef

ifneq ($(TEST8),is this \# a comment?)
$(error TEST8 value not expected: $(TEST8))
endif

# A backslash continuation "hides" the endef
define TEST9
value \
endef
endef

all:
	$(COMMANDS)
	$(COMMANDS2)
	test '$(COMMANDS2)' = 'shellvar=hello; test "$$shellvar" = "hello"'
	test "$(TEST3)" = "  whitespace"
	@echo TEST-PASS