From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: Priority of serial driver
Date: Sat, 22 Sep 2007 16:15:23 -0300
Message-ID: <20070922191522.GA4887@ghostprotocols.net>
References: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:28456 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbXIVTPd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 22 Sep 2007 15:15:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so906742wxd
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Sep 2007 12:15:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Sat, Sep 22, 2007 at 02:22:00PM -0400, Cliff Brake escreveu:
> I have a system where I am doing the following on a PXA270 ARM system:
> 
> An applications is sending and receiving a packet on a serial port
> every 40ms.  With 2.6.20, I simply enabled kernel preemption and set
> the priority of my application to real-time, and it worked great, no
> matter what the system load.

You didn't made it clear what exactly is the kernel version you are
using. You mention 2.6.20, but is this with or without the PREEMPT_RT
patch?
 
> With 2.6.23-rc6, I have enabled CONFIG_HIGH_RES_TIMERS &
> CONFIG_PREEMPT.  Scheduling in the real-time application is rock solid
> and looking at timing with a scope, and instrumenting the loop in the
> application indicates the 40ms is very solid.  However, it seems the
> receive data is getting stuck in the serial driver for relatively long
> periods of time (>= 40ms), which is a problem in this system.
> 
> Is there anything that would have changed between 2.6.20 and
> 2.6.23-rc6 that would explain this?  What priority do pieces of the
> serial driver run at?  Is there any way to make the serial driver run
> at high priority so that data is processed in a timely manner?

Look at the IRQ-<N> kernel thread that services the serial port hardware
interrupt, use chrt to bump its priority and see if it helps.

To see which is the interrupt:

[root@tonchinha ~]# dmesg | grep ttyS0
Kernel command line: root=/dev/hda1 console=ttyS0,115200 console=tty0
ignore_loglevel
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

Now check what is the default rt priority for its hard interrupt kernel
thread handler, "IRQ-4":

[root@tonchinha ~]# ps -C IRQ-4 -To pid,rtprio,cmd
PID   RTPRIO CMD
1721  50     [IRQ-4]
[root@tonchinha ~]# 

Use the `chrt' utility to bump the priority to, say, 75:

[root@tonchinha ~]# chrt -p 75 1721

Check again:

[root@tonchinha ~]# ps -C IRQ-4 -To pid,rtprio,cmd
PID   RTPRIO CMD
1721  75     [IRQ-4]

- Arnaldo
