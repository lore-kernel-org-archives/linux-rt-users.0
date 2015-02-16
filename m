From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Removed unnecessary use of local variable in v3.12.
Date: Mon, 16 Feb 2015 16:58:22 +0100
Message-ID: <20150216155822.GE21649@linutronix.de>
References: <1400150334-24814-1-git-send-email-meenakshi.aggarwal@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Meenakshi Aggarwal <meenakshi.aggarwal@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38602 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbbBPP6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 10:58:24 -0500
Content-Disposition: inline
In-Reply-To: <1400150334-24814-1-git-send-email-meenakshi.aggarwal@freescale.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Meenakshi Aggarwal | 2014-05-15 16:08:54 [+0530]:

>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -2296,13 +2296,16 @@ void __kprobes add_preempt_count(int val)
> 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
> 				PREEMPT_MASK - 10);
> #endif
>-	if (preempt_count() == val) {
>-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
>+
>+	if (preempt_count() == val)
> #ifdef CONFIG_DEBUG_PREEMPT
>-		current->preempt_disable_ip = ip;
>+		trace_preempt_off(CALLER_ADDR0,
>+			current->preempt_disable_ip =
>+			get_parent_ip(CALLER_ADDR1));

So if I apply this, I can imagine tglx will run to his armoury looking
for a fine axe and then throwing it at me. So sorry, but I can't apply
this.
I suggest you look into gcc and figure out why this hackery of yours
saves 18 instructions. It does not make sense to me because all you do
is to inline replace ip with "get_parent_ip(CALLER_ADDR1)". It might be
that the compiler unrolls the stack each time ip is accessed but this is
clearly a compiler short comming.

Sebastian
