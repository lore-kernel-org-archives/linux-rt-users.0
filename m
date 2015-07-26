From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rtmutex deadlock detected (3.18.19-rt15)
Date: Sun, 26 Jul 2015 20:56:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507262051430.18576@nanos>
References: <55B39797.9020705@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53699 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbbGZS4R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2015 14:56:17 -0400
In-Reply-To: <55B39797.9020705@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 25 Jul 2015, DIXLOR wrote:
> # xfs_fsr;
> ^C
> 
> [ 3380.373641] WARNING: CPU: 6 PID: 3664 at kernel/locking/rtmutex.h:29
> 0xffffffff814d4ea2()
> [ 3380.373641] rtmutex deadlock detected
> [ 3380.373645] Modules linked in: cpufreq_userspace cpufreq_powersave
> cpufreq_conservative nct6775 hwmon_vid xhci_hcd usbcore iTCO_wdt
> crct10dif_pclmul iTCO_vendor_support shpchp crc32c_intel i2c_i801 lpc_ich
> i2c_core usb_common mfd_core button processor dm_mod raid1 ahci libahci fan
> thermal thermal_sys [last unloaded: xhci_pci]
> [ 3380.373646] CPU: 6 PID: 3664 Comm: xfs_fsr Tainted: G D        3.18.19-rt15
> #3
> [ 3380.373647] Hardware name: MSI MS-7823/B85M-G43 (MS-7823), BIOS V3.14B3
> 06/23/2014
> [ 3380.373647]  0000000000000000 0000000000000009 ffffffff814d1350
> ffff8807ef65f538
> [ 3380.373648]  ffffffff810498dd ffff8807cf289d10 ffff8807ef65f5c0
> 0000000000000000
> [ 3380.373648]  0000000000000000 0000000000000002 ffffffff81049955
> ffffffff81680648
> [ 3380.373649] Call Trace:
> [ 3380.373649]  [<ffffffff814d1350>] ? 0xffffffff814d1350

Can you please build your kernel with KALLSYSMS_ALL enabled, so we get
a symbolic resolution of the call trace.

You can also try and enable CONFIG_PROVE_LOCKING. That will give us
even more detailed information about the problem at hand. Note, that
CONFIG_PROVE_LOCKING slows down your kernel, so don't try to run on a
production environment.

Thanks,

	tglx


