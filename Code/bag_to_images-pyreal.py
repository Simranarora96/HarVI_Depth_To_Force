import os
import argparse
import sys
import numpy as np
import cv2
import pyrealsense2 as rs
import matplotlib.pyplot as plt
import csv



def main():
	pipe = rs.pipeline()
	cfg = rs.config()
	cfg.enable_device_from_file(r"/Users/sunnysingh/Desktop/HarVi/curr_work/Bag/april19_silicone_200pokes_force.bag")
	profile = pipe.start(cfg)


    # Skip 5 first frames to give the Auto-Exposure time to adjust
	for x in range(5):
		pipe.wait_for_frames()
    # Store next frameset for later processing:

	frameset = pipe.wait_for_frames()
	i = 0 # For 200 pokes i goes til 450000 frames
	d_values = []

	while i<45000:
		try:
			print(i)
			frameset = pipe.wait_for_frames()

			depth_frame = frameset.get_depth_frame()

		    
			colorizer = rs.colorizer()
			colorized_depth = np.asanyarray(colorizer.colorize(depth_frame).get_data())[45:200,135:290,:]#[45:200,135:320,:]#[45:180,155:320,:]#[45:180,120:320,:]#[45:250,90:320,:]#[45:350,70:280,:]#[75:150,160:255,:]#[57:150,190:255,:]#[57:150,150:275,:]#[90:150,160:270,:]#[75:140,175:260,:]#[60:180,155:273,:]#[80:130,155:273,:]#[70:120,165:261,:]#[70:140,150:280,:]#[90:200,170:250,:]#[105:200,170:250,:]#[90:140,135:250,:]#[80:150,150:300,:]#[90:140,170:220,:]#[90:140,120:290,:]#[50:200,80:290,:]#[60:167,140:320,:]#[60:160,100:280,:]#[60:167,140:320,:]
			### Uncomment to see Region of Interest ########
			# plt.imshow(colorized_depth[45:200,135:290,:])
			# plt.show()#
			# break

			
			depth_scale = profile.get_device().first_depth_sensor().get_depth_scale()
			print(rs.camera_info())
			break
			#print(depth_scale)
			colorized_depth_2 = colorized_depth * depth_scale
			dist,_,_,_ = cv2.mean(colorized_depth_2)
			
			d_values.append(dist)
			# break
			
			cv2.imwrite(os.path.join('/Users/sunnysingh/Desktop/HarVi/curr_work/Images/April19/Silicone_200poke_force/', "frame%06i.png" %i ), colorized_depth)
			
			i+=1

		except KeyboardInterrupt:
			break
			
	# Save Only if no of frames > 4000
	if i>=4000:
		plt.plot(d_values)
		plt.show()
		a = np.asarray(d_values)
		np.savetxt("/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April19/april19_depth_200poke_silicone_force.csv", a, delimiter=",")
	return

if __name__ == '__main__':
    main()
