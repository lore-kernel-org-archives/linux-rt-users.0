From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new generic_handle_irq_rt_wa()
 api
Date: Tue, 3 Nov 2015 20:51:03 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511032014580.4032@nanos>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com> <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com> <alpine.DEB.2.11.1511022036500.4032@nanos> <563906C5.8030801@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46473 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbbKCTvp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2015 14:51:45 -0500
In-Reply-To: <563906C5.8030801@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 3 Nov 2015, Grygorii Strashko wrote:
> On 11/02/2015 09:38 PM, Thomas Gleixner wrote:
> > 
> > Why aren't you simply marking these demultiplex handlers with IRQ_NO_THREAD?
> > 
> In general, it's possible. But, in this case, worst scenario will look like:

> dra7xx_pcie_msi_irq_handler()
> -> dw_handle_msi_irq()
>    [code simplified]
>    -> for (i = 0; i < MAX_MSI_IRQS; i++) {
> 	...
> 	generic_handle_irq(Y(i));
> 	...
>    }
> where MAX_MSI_IRQS = 32 now, but potentially can be increased up to 256.

And you really oversimplified the code above. The reality is:

    for (i = 0; i < MAX_MSI_CTRLS: i++) {
    	u32 status = read_msi_ctrl(i);

	for_each_bit(status)
		handle_irq();
    }

So sure, the worst case here is MAX_MSI_CTRLS * 32, but if all
possible 256 MSI interrupts are pending at the same time, you have
other problems than that.

In the current configuration (32 interrupts), which cannot change
because it's hardwired in silicon, this is a single status read and
assuming that only a few (most of the time it will be exactly ONE) of
those interrupts are pending at the same time is pretty much a sane
assumption. If it wouldn't be then all users of chained interrupt
handlers which usually demultiplex 32 interrupts would suffer from
that problem already.

Aside of that, you would prevent that any of these PCIe interrupts can
be utilized as a "fast" non threaded interrupt on RT. And that I would
consider a real bad limitation for no value. 

MSI has been invented to overcome the issues of wired interrupts
(demultiplexing and sharing), so I don't know why the involved
hardware designers came to the conclusion that demultiplexing MSI
interrupts in software is a sane approach. But then I really gave up
trying to understand hardware designers long ago.

The only sane way to deal with that is to actually mark those handlers
NOTRHEAD and document the limitations of your hardware, so your
customers won't trip over it. If they insist on having 32 MSI
producers on that PCIe bus and make them fire all at the same time,
then you still can provide them your "solution".

Just face it, it's a bad hardware design decision and adding a half
baken hackery which actually hurts sane use cases is not making it any
better.

Thanks,

	tglx





