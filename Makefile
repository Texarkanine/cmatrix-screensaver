# Makefile for holiday-cmatrix installation

# Variables
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SCRIPT = holiday-cmatrix
INSTALL_SCRIPT = $(BINDIR)/$(SCRIPT)

# Default target
.PHONY: help
help:
	@echo "Holiday CMatrix Installation"
	@echo "==========================="
	@echo ""
	@echo "Available targets:"
	@echo "  install    - Install holiday-cmatrix to $(BINDIR)"
	@echo "  uninstall  - Remove holiday-cmatrix from $(BINDIR)"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Installation requires root/sudo privileges."
	@echo "Usage: sudo make install"

# Install the script
.PHONY: install
install: $(SCRIPT)
	@echo "Installing $(SCRIPT) to $(BINDIR)..."
	@if [ ! -d "$(BINDIR)" ]; then \
		echo "Creating directory $(BINDIR)..."; \
		mkdir -p "$(BINDIR)"; \
	fi
	cp "$(SCRIPT)" "$(INSTALL_SCRIPT)"
	chmod 755 "$(INSTALL_SCRIPT)"
	@echo "✓ Installation complete!"
	@echo "You can now run: $(SCRIPT)"

# Uninstall the script
.PHONY: uninstall
uninstall:
	@if [ -f "$(INSTALL_SCRIPT)" ]; then \
		echo "Removing $(INSTALL_SCRIPT)..."; \
		rm -f "$(INSTALL_SCRIPT)"; \
		echo "✓ Uninstallation complete!"; \
	else \
		echo "$(SCRIPT) is not installed in $(BINDIR)"; \
	fi

# Check if script exists and is executable
.PHONY: check
check:
	@if [ -f "$(SCRIPT)" ]; then \
		echo "✓ $(SCRIPT) found"; \
		if [ -x "$(SCRIPT)" ]; then \
			echo "✓ $(SCRIPT) is executable"; \
		else \
			echo "⚠ $(SCRIPT) is not executable (run: chmod +x $(SCRIPT))"; \
		fi; \
	else \
		echo "✗ $(SCRIPT) not found!"; \
		exit 1; \
	fi
	@if command -v cmatrix >/dev/null 2>&1; then \
		echo "✓ cmatrix is installed"; \
	else \
		echo "⚠ cmatrix is not installed - holiday-cmatrix requires cmatrix to function"; \
	fi

# Test installation
.PHONY: test
test:
	@if [ -f "$(INSTALL_SCRIPT)" ]; then \
		echo "Testing installed script..."; \
		"$(INSTALL_SCRIPT)" --help >/dev/null && echo "✓ Installation test passed!" || echo "✗ Installation test failed!"; \
	else \
		echo "✗ $(SCRIPT) is not installed. Run 'sudo make install' first."; \
		exit 1; \
	fi

# Development targets
.PHONY: dev-install
dev-install: $(SCRIPT)
	@echo "Installing $(SCRIPT) to current user bin (~/bin)..."
	@mkdir -p "$$HOME/bin"
	cp "$(SCRIPT)" "$$HOME/bin/$(SCRIPT)"
	chmod 755 "$$HOME/bin/$(SCRIPT)"
	@echo "✓ Development installation complete!"
	@echo "Make sure ~/bin is in your PATH"
	@echo "You can now run: $(SCRIPT)"

# Show installation status
.PHONY: status
status:
	@echo "Installation Status:"
	@echo "==================="
	@if [ -f "$(INSTALL_SCRIPT)" ]; then \
		echo "✓ $(SCRIPT) is installed at $(INSTALL_SCRIPT)"; \
		ls -la "$(INSTALL_SCRIPT)"; \
	else \
		echo "✗ $(SCRIPT) is not installed in $(BINDIR)"; \
	fi
	@if [ -f "$$HOME/bin/$(SCRIPT)" ]; then \
		echo "✓ $(SCRIPT) is also installed in ~/bin/$(SCRIPT)"; \
	fi
