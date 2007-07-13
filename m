From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 10:25:09 -0700
Message-ID: <1184347509.18465.2.camel@cmn3.stanford.edu>
References: <1184325752.12353.312.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.22.28]:59738 "EHLO
	smtp1.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbXGMRZM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 13:25:12 -0400
In-Reply-To: <1184325752.12353.312.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-07-13 at 13:22 +0200, Thomas Gleixner wrote:
> we are pleased to announce the v2.6.22.1-rt3 kernel
> 
> Attention! 
> 
> Ingo is off for a long weekend and therefor the download location for
> this release is:
> 
>  http://www.tglx.de/projects/preempt-rt/2.6.22.1
>   
> more info about the -rt patchset can be found in the RT wiki:
>   
>    http://rt.wiki.kernel.org
>  
> This release is bugfix release:
> 
> - update of the x8664 -hrt queue (resolve boot problems)
> - gtod vsyscall fix from Gregory Haskins

Same problem as reported yesterday in 2.6.22.1-rt2 in a T61 laptop, boot
hangs, last BUG printed is similar to this (numbers changed since
yesterday, of course, functions listed appear to be the same). No serial
port available to dump everything...

This was copied from the screen yesterday:

BUG: spinlock lockup on CPU#1, swapper/0, c318da88
[<c0405f34>] show_trace_log_lvl+0x1a/0x2f
[<c0406a09>] show_trace+-x12/0x14
[<c0406a71>] dump_stack+0x16/0x18
[<c0617a91>] _raw_spin_lock+0xc1/0xe2
[<c061743f>] __spin_lock_irq+0x14/0x16
[<c061541d>] __sched_tex_start+0xd5/0xaef
[<c061600e>] schedule+0xe0/0xfa
[<c0616c15>] rt_spin_lock_slowlock+0xcf/0x14f
[<c061724b>] __rt_spin_lock+0x3d/0x40
[<c0617256>] rt_spin_lock+0x8/0xa
[<c052f95c>] acpi_idle_enter_c3+0x12d/0x232
[<c059af51>] cpuidle_idle_call+0x56/0x79
[<c04033a5>] cpu_idle+0x9d/0xda
[<c0419e21>] start_secondary+0x34e/0x356
[<00000000>] 0x0

Same .config as before.
-- Fernando
