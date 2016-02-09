From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Boot IRQ issue on Intel C602J (Advantech ASMB-822)
Date: Tue, 9 Feb 2016 11:34:01 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602091133080.25254@nanos>
References: <20160208124004.5a20494f@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Alexander Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38749 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbcBIKfO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2016 05:35:14 -0500
In-Reply-To: <20160208124004.5a20494f@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 8 Feb 2016, Alexander Gerasiov wrote:
> On 3.10.74 one of adapter generate only several (~10) interrupts and
> then halts. As I discovered, it works ok, but no interrupts was
> delivered. The same time (but after device stops receiving irqs) boot
> irqs occur and irq 16 got disabled by the kernel.
> 
> I tried 3.18.25 with the same result.
> 
> Right now I'm running 4.4.1-rt4 and finally it works, but there are
> still boot irqs and kernel disables IRQ 16 because of them.

Can you please provide the output of:

# lspci -s 00:1f.0 -xxx

Thanks,

	tglx
