From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
	SCHED_TRACER depends on HZ]
Date: Tue, 6 Nov 2012 20:04:45 +0000
Message-ID: <20121106200445.GA32398@n2100.arm.linux.org.uk>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <20121106024052.GA27643@S2100-06.ap.freescale.net> <20121106101229.GN28327@n2100.arm.linux.org.uk> <20121106134944.GE27643@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37739 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2KFUGL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 15:06:11 -0500
Content-Disposition: inline
In-Reply-To: <20121106134944.GE27643@S2100-06.ap.freescale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 09:49:50PM +0800, Shawn Guo wrote:
> On Tue, Nov 06, 2012 at 10:12:29AM +0000, Russell King - ARM Linux wrote:
> > > [    0.000000] sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 20
> > > 47ms
> > 
> > So where are you setting this up?  My guess is it's after time_init()
> > has done its stuff.
> 
> It gets set up in machine_desc->timer->init() which is called right
> in time_init() just before sched_clock_postinit().

Well.  I just tried an experiment with OMAP4:

[    0.000000] sched_clock: 16 bits at 32kHz, resolution 30517ns, wraps every 1999ms                                                                            

So, this is similar to yours, and there I get:

[    1.945281] ALSA device list:
[    1.948394]   #0: SDP4430
[    1.951324] Waiting 2sec before mounting root device...
[    2.926910] kjournald starting.  Commit interval 5 seconds
[    2.927001] EXT3-fs (mmcblk1p2): warning: maximal mount count reached, running e2fsck is recommended
[    3.041503] EXT3-fs (mmcblk1p2): using internal journal
[    3.051422] EXT3-fs (mmcblk1p2): recovery complete
[    3.056427] EXT3-fs (mmcblk1p2): mounted filesystem with writeback data mode
[    3.063842] VFS: Mounted root (ext3 filesystem) on device 179:26.
[    3.070404] Freeing init memory: 192K

So it appears to be working as designed.
