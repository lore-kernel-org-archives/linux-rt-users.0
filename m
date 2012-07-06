From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 23:01:35 +0200
Message-ID: <4FF7522F.8020909@osadl.org>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com> <4FF6CEA6.6080900@osadl.org> <4FF70C59.40801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:44460 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758546Ab2GFVNK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 17:13:10 -0400
In-Reply-To: <4FF70C59.40801@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Dong,

>>> I can quite reliably trigger this cpu stall error now. Just try to start
>>> several KVM guests.
>> Good. BTW, we do repeated long-term tests 14 times per day with a single
>> kvm guest that runs on two cores and conducts a number of CPU
>> benchmarks. (https://www.osadl.org/?id=931) - never had this problem. So
>> it may be related to running more than a single kvm guest.
> I don't have /sys/kernel/debug/tracing/ directory. The kernel doc says
> turn on CONFIG_KPROBE_TRACING. But I could not find this config.
Either tracing is not configured or the debugfs is not mounted or it is 
mounted elsewhere.
Try
   mount -t debugfs nodev /sys/kernel/debug
and, if the tracer still is not there, do
   make menuconfig
       Kernel hacking  --->
       [*] Tracers  --->
         [*]   Kernel Function Tracer
         [*]   enable/disable ftrace tracepoints dynamically
and recompile the kernel.

If you want the debugfs to be mounted at boot time, append
   nodev /sys/kernel/debug debugfs defaults 0 0
to /etc/fstab.

	-Carsten.
