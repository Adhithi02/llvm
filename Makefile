# ─────────────────────────────────────────────────────────────────
# Makefile  –  Loop Unroll Advisor LLVM pass
# Usage:
#   make          # build the .so plugin
#   make tests    # compile all test programs to .ll
#   make run      # run the pass over every test .ll file
#   make all      # build + tests + run
# ─────────────────────────────────────────────────────────────────

LLVM_VERSION ?= 18
LLVM_CONFIG  := llvm-config-$(LLVM_VERSION)
CLANG        := clang-$(LLVM_VERSION)
OPT          := opt-$(LLVM_VERSION)

CXX          := g++
PLUGIN       := LoopUnrollAdvisor.so

CXX_FLAGS    := $(shell $(LLVM_CONFIG) --cxxflags) -fPIC -fno-rtti -shared
LLVM_INCS    := $(shell $(LLVM_CONFIG) --includedir)

# test_fixed needs -fno-vectorize -fno-unroll-loops so SE can see the loop
FIXED_FLAGS  := -O1 -fno-vectorize -fno-unroll-loops -g -S -emit-llvm
STD_FLAGS    := -O1 -g -S -emit-llvm

# ── Default target ────────────────────────────────────────────────
.PHONY: all build tests run verify clean

all: build tests run

build: $(PLUGIN)

$(PLUGIN): LoopUnrollAdvisor.cpp
	$(CXX) $(CXX_FLAGS) -I$(LLVM_INCS) -o $@ $<
	@echo "[ok] Built $(PLUGIN)"

tests/test_fixed.ll: tests/test_fixed.c
	$(CLANG) $(FIXED_FLAGS) -o $@ $<
	@echo "[ok] IR: $@"

tests/%.ll: tests/%.c
	$(CLANG) $(STD_FLAGS) -o $@ $<
	@echo "[ok] IR: $@"

TEST_LLS := tests/test_fixed.ll tests/test_variable.ll \
            tests/test_nested.ll tests/test_complex.ll

tests: $(TEST_LLS)

run: build tests
	@echo ""
	@echo "================================================================"
	@echo "  Loop Unroll Advisor — results"
	@echo "================================================================"
	@for f in $(TEST_LLS); do \
	  echo ""; \
	  echo ">>> $$f"; \
	  $(OPT) -load-pass-plugin ./$(PLUGIN) \
	         -passes="loop-unroll-advisor" \
	         -disable-output $$f 2>&1; \
	done

verify: build tests
	@chmod +x tests/verify_output.sh
	@OPT="$(OPT)" PLUGIN="./$(PLUGIN)" tests/verify_output.sh

clean:
	rm -f $(PLUGIN) $(TEST_LLS) tests/test_fixed_ssa.ll