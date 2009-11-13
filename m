From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: scheduling latency & CONFIG_HZ
Date: Fri, 13 Nov 2009 21:37:55 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911132133250.24119@localhost.localdomain>
References: <hdf0mo$6gj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48259 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757435AbZKMUhy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Nov 2009 15:37:54 -0500
In-Reply-To: <hdf0mo$6gj$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 11 Nov 2009, Tim Blechmann wrote:

> i am curious, do the values of CONFIG_HZ and CONFIG_NO_HZ somehow affect the
> scheduling latency (as reported by cyclictest) of a real-time/vanilla kernel,
> especially when CONFIG_HIGH_RES_TIMERS is enabled?

CONFIG_HZ should be pretty irrelevant, but CONFIG_NO_HZ=y especially
when the CPU does support deeper C-States and the ACPI cpuidle support
is active may influence it simply because the wake up from deeper
c-states can take significantly longer than waking up from C1 (the
default halt state). Note that the wakeup latency from C-States
depends on the CPU model, chipset, available timer hardware ...

Thanks,

	tglx
