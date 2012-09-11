From: Mike Galbraith <efault@gmx.de>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 15:05:02 +0200
Message-ID: <1347368702.20252.33.camel@marge.simpson.net>
References: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:58190 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752370Ab2IKNFG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 09:05:06 -0400
In-Reply-To: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-09-11 at 13:38 +0200, Wolfgang Wallner wrote:
> Hello all,
> 
> I have a few questions about the logging entry "sched: RT throttling
> activated" which I observe, and hope this is the correct place to
> ask :)
> I will start by describing how i come to see this logging entry:
> 
> I use an industrial PC with an 2.6.33 RT PREEMP kernel to run a real
> time application (based on the openPOWERLINK stack [1]), which
> consists of a kernel part and a user space part.
> My application uses the openPOWERLINK stack to exchange data with
> other real time nodes in the network (a good overview how this is done
> is given on wikipedia [2]).
> 
> When I let my application run overnight, I always see that it stops
> working after some hours, and the output of dmesg shows the following:
> 
> [ 622.722690] EdrvInitOne waiting for link up...
> [ 624.439269] EdrvInitOne finished with 0
> [ 624.439334] EdrvInit local MAC = 00 60 65 06 B2 25 
> [ 624.454662] EplApiProcessImageAlloc: Alloc(640, 1100, 2, 2)
> [ 624.454672] EplApiProcessImageAlloc: Alloc(eeea2000, 640, eef36800,
> 1100)
> [ 624.477242] ifconfig epl 192.168.100.240 returned 0
> [ 635.058012] epl: no IPv6 routers present
> [60382.945209] sched: RT throttling activated
> [60382.945209] EplTimerHighResk: Continuous timer (handle 0x10000001)
> had to skip 836 interval(s)!

Likely realtime task went gaga.  Kernel or userspace doesn't matter.

> My questions are now:
> 
> * What does this logging entry mean?
>    Could you please point me to some information about RT throttling
> so that I can understand what's it about?

With stock settings, it means realtime task[s] consumed > 95% of the
throttle interval (1s), so the throttle activated, allowing SCHED_NORMAL
tasks to have a sip of CPU, to let you try to save the box from nutty RT
CPU hogs.  See kernel/sched_rt.c.
> 
> * How to debug this issue?
> At the moment I don't know what is cause and what is effect.
> I'm not sure if I have a misconfiguration somewhere on my linux system
> and this influences my application or vice versa.
> 
> Any tips on how to find out what's going on are greatly appreciated :)

Hm, I would revoke godlike powers until the recipients can be trusted to
use them wisely.  100% CPU utilization being considered highly unwise.

-Mike

