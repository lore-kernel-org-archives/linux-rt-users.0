From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: the current status of RT_PREEMPT for mips
Date: Tue, 10 Feb 2009 17:16:41 -0800
Message-ID: <499226F9.5000307@am.sony.com>
References: <20955.222.92.8.142.1234138032.squirrel@mail.lemote.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: wuzj@lemote.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:63909 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZBKBRW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Feb 2009 20:17:22 -0500
In-Reply-To: <20955.222.92.8.142.1234138032.squirrel@mail.lemote.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

wuzj@lemote.com wrote:
> HI!
> 
> I'm planning to port RE_PREEMPT to loongson2f(a mipsel compatible
> processor), the "FAQ" web page of RTWiKi(rt.wiki.kernel.org) shows that
> "There are systems representing the x86, x86_64, ARM, MIPS, and Power
> architectures using the CONFIG_PREEMPT_RT patch.", does it means that
> RT_PREEMPT support  MIPS architecture? because i can not find any more
> information about it, I tried to use the latest RT_PREEMPT on qemu
> 0.9.1/mipssim, it can not boot, so I come to get your help, could you give
> any current status of RT_PREEMPT for mips? such as:
> 
> 1. does the latest RT_PREEMPT(for linux 2.6.26.8) support MIPS
> architecture? or any older one support it?
> 2. if Yes, which MIPS processors have been successfully running RT_PREEMPT?
> 
> looking forward to your reply, thanks!
> 
> Best Regards,
> falcon

I do not have information for current versions of the kernel, but last year
I was running 2.6.24-rt1 on a Toshiba tx4937 to do some experiments.

I have a few trivial patches for the latency tracer, but if you use a newer
kernel they are not needed because ftrace replaced the latency tracer
in 2.6.24-rt2.

-Frank Rowand
Sony Corporation of America

