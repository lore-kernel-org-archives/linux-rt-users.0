From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Unreliable Wireless network with 3.0.9-rt26
Date: Tue, 31 Jan 2012 20:36:15 -0500
Message-ID: <1328060175.5882.53.camel@gandalf.stny.rr.com>
References: <4F26D728.2090008@cmotion.eu>
	 <201201311708.30266.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Christian Kapeller <christian.kapeller@cmotion.eu>,
	linux-rt-users@vger.kernel.org
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:58822 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab2BABgQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jan 2012 20:36:16 -0500
In-Reply-To: <201201311708.30266.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-01-31 at 17:08 +0100, Tim Sander wrote:
> Hi
> > I'm having trouble running wifi in combination with a rt enabled kernel
> > 3.0.9-rt26 on an imx51 arm platform. The distro is openwrt-trunk.
> > 
> > The device has 2 usb wifi interfaces (AR9271 chipset; driver: based on
> > compat-wireless-testing 2011-12-01). I am running an iperf load on both
> > interfaces, one interface is in AP mode, the other in STA mode.
> > 
> > When I configure the kernel without RT preemption, the device runs
> > stable for >10 hours.
> > 
> > With RT preemption enabled, after a couple of minutes some interface
> > will stop transmitting data. Sometimes ifconfig wlan[0,1] down will
> > hang, sometimes ifconfig wlan[0,1] down will work, but then ping will
> 
> Just my 5 cents: I am working on the imx 35 platform and i am also having 
> problems with the network setup. I have sent a bugsplat to this list which 
> occurs in the network setup with 3.2-rt. I suspect that these two errors are 
> related. Steven Rosted wanted to look after it, but it seems he hasn't until 
> now.
> 

Yeah, I've been hunting down other nasty bugs in the mean time. I could
start looking at this. I suspect it may be due to another try_lock()
thingy.

-- Steve


