# Copyright 2016 Noah Halford and Catherine Moresco.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#!/usr/bin/python

import cv2
import numpy as np

path = './test_scan/cupvid.mov'
threshold = 40

vidcap = cv2.VideoCapture(path)

success, img = vidcap.read()

imgno = 50
# path = "./test_scan/burst/cup - " + str(imgno) + ".jpg"
# img = cv2.imread(path)

f = open('out2.xyz','w+')
while success:
    print path 

#img = cv2.imread(path)
# NumPy array for threshold image
    result = np.zeros(np.shape(img))
    
    y, x = np.shape(img[:,:,1])
    
    thresh = cv2.inRange(img,np.array([0,0,threshold]),np.array([255,255,255]))
    for i in range(int(y/4), int(9*y/16)):
        for j in range(x):
            thresh[i,j] = 0
    cv2.imwrite("threshold.png", thresh)

    thresh2 = cv2.inRange(img,np.array([0,0,int(1.2*threshold)]),np.array([255,255,255]))
    cv2.imwrite("threshold2.png", thresh2)
    
    nonzero = np.nonzero(thresh2)
    
    # White pixels, each entry is an array [x y]
    nonzero_coords = np.zeros((np.shape(nonzero[0])[0], 2))
    nonzero_coords[:,0] = nonzero[1]
    nonzero_coords[:,1] = nonzero[0]
    
    edges = cv2.Canny(thresh2,50,150,apertureSize = 3)
    result = cv2.cvtColor(edges,cv2.COLOR_GRAY2RGB)
    
    # Source: http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_imgproc/py_houghlines/py_houghlines.html
    lines = cv2.HoughLines(np.array(edges, dtype=np.uint8),.1,np.pi/60,10)
    # if np.any(lines):
    #         for rho,theta in lines[0]:
    #                 a = np.cos(theta)
    #                 b = np.sin(theta)
    #                 x0 = a*rho
    #                 y0 = b*rho
    #                 x1 = int(x0 + 1000*(-b))
    #                 y1 = int(y0 + 1000*(a))
    #                 x2 = int(x0 - 1000*(-b))
    #                 y2 = int(y0 - 1000*(a))

    #                 cv2.line(result,(x1,y1),(x2,y2),(0,0,255),2)
    #                 # cv2.line(result,(x1,y1),(x2,y2),(0,0,255),2)
            
    #                 cv2.imwrite('hough.png',result)
    if np.any(lines):
        print "lines found"
        coords = lines[0] # (rho, theta)
        th_max = np.amax(coords.T[1])
        filtered_list = filter(lambda x: x != 0 and th_max - x > 0.75*th_max , (coords.T[1]).tolist())
        if len(filtered_list) > 0:
            print "len > 0"
            th_min = min(filtered_list)
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
            
                    slope = -a / b
                    intercept = rho / b
            
                    if theta == th_min:
                        min_found = True
                        axes[0] = np.array([slope, intercept])
                    else:
                        max_found = True
                        axes[1] = np.array([slope, intercept])
            
                    cv2.line(result,(x1,y1),(x2,y2),(0,0,255),2)
                    # cv2.line(result,(x1,y1),(x2,y2),(0,0,255),2)
            
            cv2.imwrite('hough.png',result)
            
            # Slope and intercepts
            m1, b1 = axes[0]
            m2, b2 = axes[1]
            
            def unit(slope):
                theta = np.arctan(slope)
                return np.array([np.cos(theta), np.sin(theta)])
            
            x_intersection = (b2 - b1) / (m1 - m2)
            y_intersection = m1 * x_intersection + b1
            
            w = np.sqrt(x_intersection**2 + (y_intersection - y/2)**2)
            
            # All nonzero points, indexed by y value
            pointList = {}
            for i, j in nonzero_coords:
                if j > y/4 and j < 9*y/16:
                    if j in pointList.keys():
                        pointList[j].append(i)
                    else:
                        pointList[j] = [i]
            
            # The points that we will use in our output, indexed by y
            # value
            points = np.zeros((len(pointList.keys()), 2))
            i = 0
            for y in pointList:
                x = np.median(np.array(pointList[y]))
                points[i] = np.array([x,y])
                i += 1
            
            u = unit(m1)
            v = unit(m2)
            
            u_matrix = np.column_stack((u,v))
            
            dot_prods = np.dot(points, u_matrix)
            
            w_col = w*np.ones(i)
            
            # Each entry will be a point in our point cloud
            point_matrix = np.column_stack((dot_prods, w_col))
            
            for row in point_matrix:
                f.write('{} {} {}\n'.format(row[0], row[1], row[2]))
    
    success, img = vidcap.read()
    # print "img "  + str(imgno) + " processed"
    imgno += 1
    # img = cv2.imread(path)
    # path = "./test_scan/burst/cup - " + str(imgno) + ".jpg"
f.close()
