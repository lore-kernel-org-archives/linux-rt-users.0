From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] fix sysrq+l when nmi_watchdog disabled
Date: Tue, 27 May 2008 19:36:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805271935320.13815@gandalf.stny.rr.com>
References: <483C8EEC.2030306@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:58714 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbYE0XgL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2008 19:36:11 -0400
In-Reply-To: <483C8EEC.2030306@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 27 May 2008, Hiroshi Shimamoto wrote:

> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
>
> In nmi_show_all_regs(), set nmi_show_regs for all cpus but NMI never come
> to itself when nmi_watchdog is disabled. It means the kernel hangs up when
> sysrq+l is issued.
>
> Call irq_show_regs_callback() itself before calling smp_send_nmi_allbutself().

Thanks,

I had a patch to do this fix but it got lost. I'll add yours.

-- Steve

>
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> ---
