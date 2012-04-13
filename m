From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Guidelines to make RT patch for driver
Date: Fri, 13 Apr 2012 10:21:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204131019290.2542@ionos>
References: <4F75DDBF.7050204@softerra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Mikhail Lodigin <mishal@softerra.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40072 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2DMIWC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 04:22:02 -0400
In-Reply-To: <4F75DDBF.7050204@softerra.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 30 Mar 2012, Mikhail Lodigin wrote:

> Hello,
> on my AT91SAM9263 based board RT patched kernel works great! Thanks to all
> involved. But when ethernet is in use - latency, measured by cyclictest, reach
> 7000000 and beyond.
> The ethernet driver for this processor is macb.c. (in 3.2 it is in
> drivers/net/ethernet/cadence, in 3.0 it is in drivers/net/).
> I'm ready to find out how to RT-patch it and of course share the resulted
> patch, but I need some starting point for patching drivers besides general
> RT-stuff.  I've noticed that some network drivers patched in one way and
> others a in another. Maybe some discussion existed which I didn't found. So
> any help would be greatly appreciated.

There is no general recipe. The best way to do it is to use the
tracer. cyclictest has a commandline option for stopping the trace
when the latency exceeds a given treshold.

     cyclictest -p80 -n -f -b 1000

will start the function tracer and stop it once the latency exceeds
1000us.

Thanks,

	tglx
