From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: scheduling while atomic
Date: Tue, 17 Feb 2015 11:18:01 +0100
Message-ID: <20150217101800.GH26177@linutronix.de>
References: <CAP6rfc-1i2LkwVJory31cj8XzaYfXrBcpmKLPE2GP709LEw=Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Mushtaq Khan <mushtaqk921@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43050 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933320AbbBQKSC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 05:18:02 -0500
Content-Disposition: inline
In-Reply-To: <CAP6rfc-1i2LkwVJory31cj8XzaYfXrBcpmKLPE2GP709LEw=Jg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mushtaq Khan | 2014-09-17 14:42:30 [+0530]:

>Hi,
> I see error message "BUG: scheduling while atomic"intermittently. As
>per other post on similar  issue, this happens when schedule is called
>from either interrupt
> context or some other atomic operation (Might be after acquiring
>spinlock). But from the call trace am not getting any clue, please
>help me guide  on this issue.
>Using Linux 3.4rt.

That P in your drivers suggests that you have non GPL code in your
kernel.
You could increase the debugging level and check who disabled preemption
and then working around it.

> BUG: scheduling while atomic: dslmgmt/538/0x00000201
>  pwrmngtd(P) init_addr(  (null) -   (null)), core_addr(c032e000 - c032f54c)
>  bcmvlan(P) init_addr(  (null) -   (null)), core_addr(c030a000 - c031a598)
>  p8021ag(P) init_addr(  (null) -   (null)), core_addr(c02e0000 - c02e1120)
>  bcmarl(P) init_addr(  (null) -   (null)), core_addr(c02d7000 - c02d7e74)
>  nciTMSkmod(P) init_addr(  (null) -   (null)), core_addr(c0280000 - c029ffc8)
>  bcm_enet init_addr(  (null) -   (null)), core_addr(c01e4000 - c02078f4)
>  adsldd(P) init_addr(  (null) -   (null)), core_addr(c011b000 - c0150c78)
>  bcmxtmcfg(P) init_addr(  (null) -   (null)), core_addr(c009a000 - c00a5e28)
>  pktflow(P) init_addr(  (null) -   (null)), core_addr(c0067000 - c0074800)
>  bcm_bpm(P) init_addr(  (null) -   (null)), core_addr(c0045000 - c0046470)
>  bcm_ingqos(P) init_addr(  (null) -   (null)), core_addr(c003a000 - c003b070)
>  chipinfo(P) init_addr(  (null) -   (null)), core_addr(c0031000 - c0031198)

Sebastian
