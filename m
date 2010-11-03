From: Nicholas Kinar <n.kinar@usask.ca>
Subject: Implementing real-time embedded system to sample from five SPI ADCs
Date: Wed, 03 Nov 2010 17:06:24 -0600
Message-ID: <4CD1EAF0.6030709@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.usask.ca ([128.233.192.40]:38059 "EHLO smtp.usask.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab0KDAGe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Nov 2010 20:06:34 -0400
Received: from conversion-daemon.usask.ca by usask.ca
 (Sun Java(tm) System Messaging Server 7.3-11.01 64bit (built Sep  1 2009))
 id <0LBC0000005GP200@usask.ca> for linux-rt-users@vger.kernel.org; Wed,
 03 Nov 2010 17:06:33 -0600 (CST)
Received: from [70.64.74.128]
 (S010600254bbb9ab0.ss.shawcable.net [70.64.74.128])
 by usask.ca (Sun Java(tm) System Messaging Server 7.3-11.01 64bit (built Sep 1
 2009)) with ESMTPSA id <0LBC0018G06WKE20@usask.ca> for
 linux-rt-users@vger.kernel.org; Wed, 03 Nov 2010 17:06:33 -0600 (CST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I would like to implement a real-time embedded Linux system on an 
AT91SAM ARM processor.  Attached to the SPI bus of this processor are 5 
Analog-to-Digital converters (ADCs) that can be read using the Linux SPI 
bus subsystem.

The ADCs are sampled by having the  AT91SAM ARM processor toggle a GPIO 
at a rate of at least 1 KHz.  The GPIO is attached to a pin on the ADC.  
A high voltage level on this pin instructs all of the ADCs to take a 
sample.  The sample is then read over the SPI bus by the embedded system 
master.  This implies that data will be read from each SPI slave device 
every (1 / 1000 Hz) = 1.0e-3 seconds.

I am wondering if the following could be done with real-time Linux:

(1) I would have to write a Linux kernel module to toggle the GPIO pin.  
The rate of toggling would be controlled by a high-resolution timer, and 
would occur with a period of at least 1 kHz.
(2) After the GPIO is brought to a high voltage level, the master must 
wait for at least 3.7 microseconds before reading from the SPI bus.
(3) Each ADC would be read in sequential order.

The ADC being used is the AD7691 from Analog Devices 
(http://www.analog.com/static/imported-files/data_sheets/AD7691.pdf).

The data from the ADCs could be used in a real-time control system 
loop.  Can this be done with real-time Linux, or is the latency too 
high?  What is the maximum rate at which I could read data from these 
ADCs?  Could it be 10 kHz or even 100 kHz?

Nicholas


