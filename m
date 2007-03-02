From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [irda-users] 2.6.18-rt6 IrDA strangeness
Date: Fri, 2 Mar 2007 17:49:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021741160.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703021500020.1799@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org, irda-users@lists.sourceforge.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:54092 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992608AbXCBQtw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2007 11:49:52 -0500
In-Reply-To: <Pine.LNX.4.63.0703021500020.1799@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Added Thomas to CC: as it is a PXA270 CPU and it looks like the kernel has 
some other peculiarities that the no-rt one doesn't have. In principle, 
the kernel runs fine, many various hardware drivers, realtime threads. 
But, I just noticed, klogd doesn't get woken up from printk(). I.e., 
syslog(2) doesn't work right. If you wake it up somehow, say, with a kill 
-CONT, you get buffers out of the kernel.

Thomas, is it something known and (hopefully) fixed in newer kernels, or 
something unknown?

Below is the original Ir problem with this kernel.

Thanks
Guennadi

On Fri, 2 Mar 2007, Guennadi Liakhovetski wrote:

> Ok, the kernel is a bit old, but maybe someone has an idea... Running ppp
> over irnet, one side with the above kernel, another is a verified
> reference system. The following strange fenomena are observed:
>
> 1. irdadump on the 2.6.18-rt6 side shows only incoming packets
> 2. sometimes, especially after a connection break down, the connection is
> re-established, but the reference side has empty /proc/net/irda/discovery,
> the reason being a couple of missing packets during re-negotiation:
>
> 15:06:43.854376 xid:cmd c62da07d > ffffffff S=6 s=0 (14)
> 15:06:43.944244 xid:cmd c62da07d > ffffffff S=6 s=1 (14)
> 15:06:44.034244 xid:cmd c62da07d > ffffffff S=6 s=2 (14)
> 15:06:44.124245 xid:cmd c62da07d > ffffffff S=6 s=3 (14)
> 15:06:44.214281 xid:cmd c62da07d > ffffffff S=6 s=4 (14)
> 15:06:44.304289 xid:cmd c62da07d > ffffffff S=6 s=5 (14)
> 15:06:44.394282 xid:cmd c62da07d > ffffffff S=6 s=* TESTNODE hint=4400 [ Computer LAN Access ] (25)
>
> 15:06:46.864376 xid:cmd c62da07d > ffffffff S=6 s=0 (14)
> 15:06:46.954286 xid:cmd c62da07d > ffffffff S=6 s=1 (14)
> 15:06:47.044280 xid:cmd c62da07d > ffffffff S=6 s=2 (14)
> 15:06:47.134293 xid:cmd c62da07d > ffffffff S=6 s=3 (14)
> 15:06:47.224281 xid:cmd c62da07d > ffffffff S=6 s=4 (14)
> 15:06:47.314250 xid:cmd c62da07d > ffffffff S=6 s=5 (14)
> 15:06:47.404249 xid:cmd c62da07d > ffffffff S=6 s=* TESTNODE hint=4400 [ Computer LAN Access ] (25)
>
> 15:06:49.391225 snrm:cmd ca=fe pf=1 c62da07d < 0ad5eb46 new-ca=58 (33)
> 15:06:49.391389 ua:rsp ca=58 pf=1 c62da07d > 0ad5eb46 (32)
> 15:06:49.448100 rr:cmd < ca=58 pf=1 nr=0 (2)
> 15:06:49.448172 rr:rsp > ca=58 pf=1 nr=0 (2)
> 15:06:49.450636 i:cmd  < ca=58 pf=1 nr=0 ns=0 LM slsap=16 dlsap=00 CONN_CMD (6)
> 15:06:49.450817 i:rsp  > ca=58 pf=1 nr=1 ns=0 LM slsap=00 dlsap=16 CONN_RSP (6)
>
> I.e., we see 2 discovery packets from TESTNODE, and then the 2.6.18-rt6
> host sends directly an SNRM packet without presenting itself first with
> its nick... Looks like some timers are confused through highres timers?...

---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
