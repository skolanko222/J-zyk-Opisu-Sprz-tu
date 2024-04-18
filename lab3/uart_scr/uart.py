# Enable pyserial extensions
import pyftdi.serialext

# Open a serial port on the second FTDI device interface (IF/2) @ 3Mbaud
brate = 230400
url = 'ftdi://ftdi:232:AQ00RVND/1'
port = pyftdi.serialext.serial_for_url(url, baudrate=brate, bytesize=8, stopbits=1, parity='N', xonxoff=False, rtscts=False)

# Send bytes
print("Transmition at", brate)
b = bytes([0x33, 0x35, 0x86, 0x32, 0x4c, 0x31, 0x36, 0x35, 0x37, 0x80, 0xc6])
print("-", b)
port.write(b)

# Receive bytes
nb = 6
print("Receiving at", brate)
print(nb, "bytes")
data = port.read(nb)
print('-', data)
#
port.close()


