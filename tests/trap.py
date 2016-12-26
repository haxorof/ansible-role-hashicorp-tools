#!/usr/bin/env python
import signal
import sys
def signal_handler(signal, frame):
        print('Exiting!')
        sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)
print('Waiting...')
signal.pause()