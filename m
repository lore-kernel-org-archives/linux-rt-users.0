From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: Re: [ANNOUNCE] 3.10.10-rt7
Date: Fri, 30 Aug 2013 12:32:48 +0200
Message-ID: <5125727.2P4PZHk0nB@bs8>
References: <20130829184228.GD15360@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52133 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab3H3Kc6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 06:32:58 -0400
In-Reply-To: <20130829184228.GD15360@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Dear RT folks!
> 
> I'm pleased to announce the v3.10.10-rt7 patch set.
> 
> Changes since v3.10.10-rt6
> - hwlat compiles on 32bit (again). Reported by Fernando Lopez-Lezcano.
> - bcache is disabled due to usage of anon semaphores. Anyone interrested
>   in using it?
> - "genirq affinity callback" are fixed. Reported by Joe Korty. There are
>   two nics using this feature.
> - Paul Gortmaker's swait rename patch has been included.
> 
> Known issues:
> 
>       - SLAB support not working
> 
>       - The cpsw network driver shows some issues.
> 
>       - bcache is disabled.
> 
>       - an ancient race (since we got sleeping spinlocks) where the
>         TASK_TRACED state is temporary replaced while waiting on a rw
>         lock and the task can't be traced.
> 
> The delta patch against v3.10.10-rt6 is appended below and can be found
> here:
>   
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.10
> -rt6-rt7.patch.xz
> 
> The RT patch against 3.10.10 can be found here:
> 
>   
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.10-rt7.
> patch.xz
> 
> The split quilt queue is available at:
> 
>   
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patches-3.10.10-rt
> 7.tar.xz
> 
> Sebastian

Just for the records:

older, but recent rt-kernels (3.10.*, rt [1,3]) stopped booting here 
indicating some problems with initialisation of the nouveau drm driver.
(might also be a PCI-E problem)

This was not the case with 3.8.*-rt*.
The problem gone with 3.10.10-rt7 tested today.

A lot of thanks!


Bernhard 

PS:
Would it be much work to activate netconsole with rt-kernels?
(I was ready to send some "real screenshots" of the probelm next days,  but 
the problem gone :-) )
