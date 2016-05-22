#!/usr/bin/python

import numpy as np
import cv2
import serial

cap = cv2.VideoCapture(0)
i = 0
steps = 512
ser = serial.Serial("/dev/cu.usbmodem33", 9600)

while i < steps:

    ret, frame = cap.read()

    img = cv2.cvtColor(frame, 0)

    cv2.imshow("frame", img)

    cv2.imwrite("frame{:03}.png".format(i), img)
    ser.write("1\n")
    i += 1

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
