From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Tue, 29 Mar 2016 15:50:49 +0200
Message-ID: <20160329135049.GB13334@linutronix.de>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de>
 <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
 <56D52CBB.2020003@sysnux.pf>
 <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
 <20160301160005.GB23985@piout.net>
 <nbaq7h$tme$1@ger.gmane.org>
 <56D95F56.3080904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Denis Girard <jd.girard@sysnux.pf>,
	linux-rt-users@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55743 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbcC2Nux (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 09:50:53 -0400
Content-Disposition: inline
In-Reply-To: <56D95F56.3080904@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Grygorii Strashko | 2016-03-04 12:11:34 [+0200]:

>On 03/04/2016 04:00 AM, Jean-Denis Girard wrote:
>>clocksource: Switched to clocksource tcb_clksrc
>>------------[ cut here ]------------
>>WARNING: CPU: 0 PID: 1 at kernel/locking/rtmutex.c:2008
>>Hardware name: Atmel AT91SAM9
>>[<c0317524>] (clk_enable_lock) from [<c03188e8>] (clk_disable+0x1c/0x34)
>Yeah. You can't use CLK framework in atomic context on -RT [1], [2].

The AT91 problems are mostly gone in v4.4.4-rt11. There is one last
free_irq() related warning which will be gone in v4.4.6-rt13.

Sebastian
