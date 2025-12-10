# Makefile для ethernet-bridge
#
# Установка:
#   make install - установить скрипт
#   make uninstall - удалить скрипт
#   make clean - очистить временные файлы

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
SCRIPT_NAME = ethernet-bridge
SCRIPT_SRC = src/$(SCRIPT_NAME)

.PHONY: all install uninstall clean help

all: help

install:
	@echo "Установка $(SCRIPT_NAME) в $(BINDIR)"
	@mkdir -p $(BINDIR)
	@cp $(SCRIPT_SRC) $(BINDIR)/$(SCRIPT_NAME)
	@chmod +x $(BINDIR)/$(SCRIPT_NAME)
	@echo "$(SCRIPT_NAME) успешно установлен в $(BINDIR)"

uninstall:
	@echo "Удаление $(SCRIPT_NAME) из $(BINDIR)"
	@rm -f $(BINDIR)/$(SCRIPT_NAME)
	@echo "$(SCRIPT_NAME) удален из $(BINDIR)"

clean:
	@echo "Очистка временных файлов"
	@# В данном проекте нет временных файлов для очистки

help:
	@echo "Ethernet Bridge - Универсальный скрипт настройки сетевого моста"
	@echo ""
	@echo "Доступные цели:"
	@echo "  install     - Установить скрипт в систему ($(BINDIR))"
	@echo "  uninstall   - Удалить скрипт из системы"
	@echo "  clean       - Очистить временные файлы"
	@echo "  help        - Показать это сообщение"
	@echo ""
	@echo "Для изменения пути установки используйте переменные PREFIX и BINDIR:"
	@echo "  make install PREFIX=/opt/local"
	@echo "  make uninstall PREFIX=/opt/local"

# Цель для проверки зависимостей
check-deps:
	@echo "Проверка наличия зависимостей..."
	@command -v brctl > /dev/null || { echo "bridge-utils не найден"; exit 1; }
	@command -v dnsmasq > /dev/null || { echo "dnsmasq не найден"; exit 1; }
	@command -v iptables > /dev/null || { echo "iptables не найден"; exit 1; }
	@command -v ip > /dev/null || { echo "iproute2 не найден"; exit 1; }
	@echo "Все зависимости присутствуют"
