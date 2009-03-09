From: Cliff Brake <cliff.brake@gmail.com>
Subject: rt application question with rs232 communication
Date: Mon, 9 Mar 2009 17:34:49 -0400
Message-ID: <f96d234e0903091434xafaedcamc68023ebce5c7799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:49720 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZCIVew (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2009 17:34:52 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1846817rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2009 14:34:49 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have an application where I do the following:

- PXA270 CPU
- communicating over serial ports on 40ms intervals
- communication scheme is very simple in that the linux system sends a
packet every 40ms and expects a response back within the 40ms window
- currently using 2.6.27 with CONFIG_PREEMPT

If I set the application comm thread to real time priority, the
sending works very well.  There is very little jitter in the 40ms send
timing.  However, it seems that the system has trouble receiving the
response in a timely fashion.  I often observe that it takes at least
10ms for the application to receive the response data after the data
has appeared on the rs232 bus.  Is the RT patch something that would
help speed up the serial receive response time, or is there something
else going on that I am missing?  The system is fairly busy with
graphical processing, but the sending is always right on schedule.

It seems that interrupts may be involved with this problem as when
sending, the send data is smaller than the FIFO size, and is probably
put into the fifo during the write, where with the read, an interrupt
needs to fire, etc.  Does all the kernel code that handles the serial
data automatically run at the calling application's RT priority, or is
there additional work required to make everything that touches the
data RT?

I'm also trying to figure out how well RT will work for CAN
communications.  Once again we have the same problem -- a RT user
space application needs to send and receive data with strict timing.
Which, I can make a RT thread in user space run well (toggle a gpio
with very little jitter), how does this translate to all the kernel
components involved in the socketcan stack (networking, etc) that need
to touch the data?

Thanks,
Cliff

-- 
=======================
Cliff Brake
http://bec-systems.com
