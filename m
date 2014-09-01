From: Philipp Lutz <philipp.lutz@dlr.de>
Subject: Re: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
Date: Mon, 1 Sep 2014 17:41:30 +0200
Message-ID: <540493AA.2020207@dlr.de>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.dlr.de ([129.247.252.32]:41325 "EHLO mailhost.dlr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbaIAPqx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Sep 2014 11:46:53 -0400
In-Reply-To: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jeff,

thanks for your effort of investigating this issue.
I'll have a look if it can help me decreasing SPI latency with my ARM
based boards (Gumstix, BeagleBoneBlack).

Have you looked into setting a RTPRIO for the SPI worker threads
(spi_init_queue() in spi.c)? As far as I see hardly any SPI
hardware-dependent driver sets the "rt" property in the respective
spi_master struct, so that the main SPI driver (spi.c) will not use a RT
priority, which will be MAX_RT_PRIO - 1.

So far setting a medium RTPRIO for the SPI worker threads helped a lot
to reduce latency. Now I'm able to sustain a stable SPI transaction rate
of around 800 Hz.

Cheers
Phil


-------- Original Message --------
Subject: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
From: Jeff Epler <jepler@unpythonic.net>
To: linux-rt-users@vger.kernel.org
Date: 09/01/2014 04:30 PM
> I recently became interested in realtime access to an SPI device on the
> Odroid U3 platform, with a goal of running a repetitive task every 1ms
> that performs two SPI transactions. (for http://linuxcnc.org/
> interfacing to a http://mesanet.com/ "Anything I/O" card)
>
> Unfortunately, I found that there were frequent large latencies, some
> over 10ms, when using /dev/spidev.  This seems to be typical of others'
> experience using it (for instance, one can find threads discussing
> disappointing RT performance of SPI on the beaglebone and pandaboard; at
> least one raspberry pi project chose to implement a pure userspace SPI
> driver instead of using spidev)
>
> At all levels of the SPI stack, I found things that could be improved if
> lowest delays are the goal.  I doubt that in their current form these
> changes are suitable to be incorporated in preempt-rt, but I hope that 
> this might spur some discussion that would ultimately lead to better
> realtime performance of SPI in the preempt-rt kernel.
>
> As you may know, the kernel's spi driver stack consists of
>     spidev    - implementation of the /dev/spidev* device
>     spi       - hardware-independent kernel layer
>     spi-xyzzy - hardware-dependent driver for xyzzy hardware
>                 (s3c64xx in my device)
>
> I fixed causes of latency at each layer
>  * First, I eliminated per-ioctl memory allocations in spidev 
>  * Second, I made __spi_sync *actually* synchronous, rather than
>    being a wrapper over spi_async + wait_for_completion; and changed
>    spidev to use spi_sync
>  * Third, in the hardware-dependent code I moved DMA acquisition to
>    device initialization time rather than transaction time
>
> I did not quite achieve my goal of a 1ms repetitive rate yet, but with
> these changes I have run for 12+ hours at a rate of 3 transactions per
> 2ms with acceptable worst-case performance---under 250us for the biggest
> transaction, and 465us for all three (they have different sizes), with
> typical figures of more like 200us for all three transactions.  This is
> in contrast to the original performance, in which transactions taking
> over 10ms were seen multiple times per hour.  (12 hours is about 64
> million spi transations)
>
> (I changed from talking about 2 transactions to 3, because for an
> unrelated reason the communication in my program is currently divided
> into 3 SPI transactions when two would do)
>
> I know that 3.8 is by no means current, but 3.8.y is the default kernel
> shipped by hardkernel for their U3 devices so it was a rational version
> choice for me.  I did skim spi changes from version 3.8 to the present
> and didn't see anything that looked like it was directed at improving
> SPI latency, though the underlying code has probably changed enough over
> time that I assume my patches wouldn't actually apply at the tip of the
> latest and greatest branches.
>
> PS The fact that the first PREEMPT-RT kernel I built for the odroid
> worked and has basically good latency (until trying to talk to the
> hardware :-/) impressed the heck out of me.
>
> Jeff Epler (4):
>   spi: reenable sync SPI transfers
>   spidev: Avoid runtime memory allocations
>   spidev: actually use synchronous transfers
>   spidev-s3c64xx: allocate dma channel at startup
>
>  drivers/spi/spi-s3c64xx.c | 15 +++++++--------
>  drivers/spi/spi.c         | 22 ++++++++++++++++------
>  drivers/spi/spidev.c      | 43 ++++++++++++++++++++++++++++++-------------
>  3 files changed, 53 insertions(+), 27 deletions(-)
>

