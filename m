From: Darcy Watkins <dwatkins@tranzeo.com>
Subject: Re: rtmutex grabbed twice by same context in network code
Date: Tue, 15 Nov 2011 09:01:08 -0800
Message-ID: <1321376468.27762.47.camel@tr-pentomino>
References: <1321310484.10018.74.camel@tr-pentomino>
	 <alpine.LFD.2.02.1111150010200.4902@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from testserv.tranzeo.com ([64.114.87.10]:28019 "EHLO
	mail2.tranzeo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORBJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:09 -0500
In-Reply-To: <alpine.LFD.2.02.1111150010200.4902@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-11-14 at 15:12 -0800, Thomas Gleixner wrote:
> On Mon, 14 Nov 2011, Darcy Watkins wrote:
> 
> > Hi,
> >
> > Anyone have insight into the kernel crash below?
> 
> Can you please enable CONFIG_PROVE_LOCKING ? That should tell us all
> the details.

Hi Thomas,

I tried that but couldn't fit the resulting system into the memory on
the device.  oops!   But I think I determined the cause.

The function header comments for netif_receive_skb() mentions it should
only be used under softirqd context.  I guess earlier kernel versions I
used didn't really care.  But the newest ones do.

To invoke it under the thread context, I used the technique described
in...

http://kerneltrap.org/mailarchive/linux-netdev/2010/5/19/6277601

...and it seems to avoid the crash.  Essentially the trick is to suspend
bottom half, then invoke netif_receive_skb(), then allow it.

When I looked at dev.c in netif_rx_ni() I notice functions like
migate_disable/enable(), are those related to SMP support?


Thanks,

Darcy
> 
> Thanks,
> 
>         tglx
> 
> 


