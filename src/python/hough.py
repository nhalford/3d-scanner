#!/usr/bin/python

import cv2
import numpy as np

path = './test_scan/test.jpg'
threshold = 150

img = cv2.imread(path)
# NumPy array for threshold image
result = np.zeros(np.shape(img))

y, x = np.shape(img[:,:,1])
print x
print y

thresh = cv2.inRange(img,np.array([0,0,threshold]),np.array([255,255,255]))
cv2.imwrite("threshold.png", thresh)
print thresh.nonzero()

eroded = cv2.erode(thresh, np.ones((5,5)))
cv2.imwrite("eroded.png", thresh)

result = cv2.cvtColor(thresh,cv2.COLOR_GRAY2RGB)

# Source: http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_imgproc/py_houghlines/py_houghlines.html
lines = cv2.HoughLines(np.array(eroded, dtype=np.uint8),0.1,np.pi/60,50)
coords = lines[0] # (rho, theta)
th_max = np.amax(coords.T[1])
th_min = min(filter(lambda x: x != 0, (coords.T[1]).tolist()))
min_found = False
max_found = False

axes = np.zeros((2,2))

for rho,theta in coords:
    if (theta == th_min and not min_found) or (theta == th_max and not max_found):
        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a*rho
        y0 = b*rho
        x1 = int(x0 + x*(-b))
        y1 = int(y0 + x*(a))
        x2 = int(x0 - y*(-b))
        y2 = int(y0 - y*(a))

        slope = np.tan(1 / theta)
        intercept = rho / np.sin(theta)

        if theta == th_min:
            min_found = True
            axes[0] = np.array([slope, intercept])
        else:
            max_found = True
            axes[1] = np.array([slope, intercept])

        cv2.line(result,(x1,y1),(x2,y2),(0,0,255),2)

# Slope and intercepts
m1, b1 = axes[0]
m2, b2 = axes[1]

def unit(slope):
    theta = np.arctan(1/slope)
    return (np.cos(theta), np.sin(theta))

x_intersection = (b2 - b1) / (m1 - m2)
y_intersection = m1 * x_intersection + b1

w = np.sqrt(x_intersection**2 + (y_intersection - y/2)**2)

cv2.imwrite('hough.png',result)
