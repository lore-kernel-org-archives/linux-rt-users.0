From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: Re: [PATCH -rt] rt-slab: fix cpu inconsistency case
Date: Mon, 24 Mar 2008 13:54:10 -0700
Message-ID: <47E814F2.6000208@ct.jp.nec.com>
References: <47E2A63B.4020003@ct.jp.nec.com> <Pine.LNX.4.58.0803201519160.21990@gandalf.stny.rr.com> <47E2C4CC.5050401@ct.jp.nec.com> <Pine.LNX.4.58.0803211635160.3220@gandalf.stny.rr.com> <47E41EDB.7030908@ct.jp.nec.com> <Pine.LNX.4.58.0803241630290.9884@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:33526 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYCXUyN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Mar 2008 16:54:13 -0400
In-Reply-To: <Pine.LNX.4.58.0803241630290.9884@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Fri, 21 Mar 2008, Hiroshi Shimamoto wrote:
>>> Is this a bug in mainline? The !PREEMPT_RT case should be as close to
>>> mainline as possible, with no actual changes in object code. If this is
>>> not the case, then we need to fix that.
>> No, this issue is in -rt only.
>>
> 
> Hi Hiroshi,
> 
> Thanks again for reporting this. I took a deeper look into this today and
> came to the conclusion that we need to get rid of both
> slab_irq_disable_nort and slab_irq_disable_rt, and simply use
> slab_irq_disable ;-)

thanks for taking time.

> 
> This is what you patch indirectly does. I'll write up another patch to fix
> this.

Sounds smarter.

> 
> Thanks,
> 
> -- Steve
> 
> P.S. I'm hoping to get -rt4 out today.

I'll test it on my box when released.

thanks,
Hiroshi Shimamoto
