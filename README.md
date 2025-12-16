# Ethernet Bridge

Универсальный скрипт настройки сетевого моста для Linux систем, обеспечивающий двусторонний доступ к портам между устройствами. Создает мост между Wi-Fi и Ethernet с DHCP для подключенных устройств.

## Основные возможности

- Создание сетевого моста между Wi-Fi и Ethernet интерфейсами
- Поддержка DHCP для автоматического назначения IP-адресов подключенным устройствам
- Двусторонний доступ к портам между устройствами
- Поддержка различных Linux-дистрибутивов (Void Linux, Debian, Ubuntu, CentOS, Arch Linux и др.)
- Гибкая настройка через команды и конфигурационный файл
- Автоматическое определение используемой init-системы для автозапуска
- Возможность настройки статических IP-адресов для конкретных устройств
- Поддержка управления пропускной способностью сети
- Интеграция с популярными системами инициализации (systemd, OpenRC, s6, runit, SysV)

## Установка

### С помощью Make:

```bash
make install
```

### Вручную:

```bash
sudo cp src/ethernet-bridge /usr/local/bin/
sudo chmod +x /usr/local/bin/ethernet-bridge
```

## Обновление

Чтобы обновить скрипт до последней версии, вы можете выполнить следующие действия:

1. Обновите репозиторий:
   ```bash
   git pull origin main
   ```

2. Переустановите скрипт:
   ```bash
   make install
   ```

## Использование

### Основные команды

УПРАВЛЕНИЕ МОСТОМ:
- start - запуск моста
- stop - остановка моста
- restart - перезапуск моста
- status - проверка статуса моста

ИНФОРМАЦИЯ И СТАТУС:
- devices - отображение информации об устройствах
- rules - показ активных правил
- logs - просмотр логов

УПРАВЛЕНИЕ ПОРТАМИ:
- port open <порт> - открытие порта
- port close <порт> - закрытие порта
- port list-open - список открытых портов

КОНФИГУРАЦИЯ ПОДКЛЮЧЕНИЙ:
- static-ip <MAC> <IP> - назначение статического IP для MAC-адреса
- set-dns <IP> - установка DNS сервера

СЕТЕВЫЕ НАСТРОЙКИ:
- limit-bandwidth <rate> - ограничение пропускной способности
- remove-bandwidth-limit - удаление ограничений пропускной способности

СИСТЕМНЫЕ НАСТРОЙКИ:
- autostart enable - включение автозапуска
- autostart disable - отключение автозапуска
- info <команда> - получение информации о системе

### Примеры использования

- Запустить мост: `sudo ethernet-bridge start`
- Проверить статус: `sudo ethernet-bridge status`
- Перезапустить мост: `sudo ethernet-bridge restart`
- Показать подключенные устройства: `sudo ethernet-bridge devices`
- Показать активные правила: `sudo ethernet-bridge rules`
- Просмотреть логи: `sudo ethernet-bridge logs`
- Открыть порт: `sudo ethernet-bridge port open 8000`
- Закрыть порт: `sudo ethernet-bridge port close 8000`
- Показать открытые порты: `sudo ethernet-bridge port list-open`
- Назначить статический IP: `sudo ethernet-bridge static-ip aa:bb:cc:dd:ee:ff 192.168.100.100`
- Установить DNS: `sudo ethernet-bridge set-dns 8.8.8.8`
- Ограничить пропускную способность: `sudo ethernet-bridge limit-bandwidth 10mbps`
- Удалить ограничение пропускной способности: `sudo ethernet-bridge remove-bandwidth-limit`
- Включить автозапуск: `sudo ethernet-bridge autostart enable`
- Отключить автозапуск: `sudo ethernet-bridge autostart disable`
- Получить информацию о системе: `sudo ethernet-bridge info network`

### Автозапуск

Скрипт автоматически определяет используемую init-систему (systemd, OpenRC, s6, runit, SysV) и создает соответствующую службу автозапуска:

```bash
# Включить автозапуск
sudo ethernet-bridge autostart enable

# Отключить автозапуск
sudo ethernet-bridge autostart disable
```

После включения автозапуска мост будет автоматически запускаться при загрузке системы.

## Конфигурация

Скрипт поддерживает конфигурационный файл `/etc/ethernet-bridge.conf`, где можно задать:

- Сетевые интерфейсы
- Настройки DNS
- Статические IP-адреса
- Ограничения пропускной способности
- Открытые порты

Пример конфигурационного файла:

```
# Интерфейсы
WIFI_INTERFACE=wlan0
ETHERNET_INTERFACE=eth0

# Настройки моста
BRIDGE_NAME=br0
BRIDGE_IP=192.168.100.1/24

# DNS сервера
DNS_SERVERS="8.8.8.8, 8.8.4.4"

# Пропускная способность
BANDWIDTH_LIMIT=100mbps

# Статические IP-адреса (MAC=IP)
STATIC_IPS=(
    "aa:bb:cc:dd:ee:ff=192.168.100.100"
    "11:22:33:44:55:66=192.168.100.101"
)
```

## Зависимости

Для работы скрипта требуются:

- bridge-utils
- dnsmasq
- iptables
- iproute2 (для команды tc, если используется ограничение пропускной способности)
- dhcpcd или dhcpclient (для получения IP-адреса для Wi-Fi интерфейса)

## Поддерживаемые дистрибутивы

Скрипт тестировался и работает на следующих дистрибутивах Linux:

- Void Linux
- Debian
- Ubuntu
- CentOS/RHEL
- Fedora
- Arch Linux
- Alpine Linux
- OpenSUSE
- Mint

## Устранение неполадок

Если возникают проблемы с работой моста:

1. Проверьте статус: `sudo ethernet-bridge status`
2. Посмотрите логи: `sudo ethernet-bridge logs`
3. Проверьте сетевые интерфейсы: `ip addr show`
4. Убедитесь, что интерфейсы правильно указаны в конфигурации
5. Проверьте, запущены ли необходимые службы (dnsmasq, iptables)

## Автор

Porkof Nelson

## Обновления

Последнее обновление: добавлена функция автопоиска интерфейсов.

## Лицензия

GPL-3.0
