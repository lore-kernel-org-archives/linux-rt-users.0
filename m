From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] rt-slab: fix cpu inconsistency case
Date: Mon, 24 Mar 2008 16:35:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0803241630290.9884@gandalf.stny.rr.com>
References: <47E2A63B.4020003@ct.jp.nec.com> <Pine.LNX.4.58.0803201519160.21990@gandalf.stny.rr.com>
 <47E2C4CC.5050401@ct.jp.nec.com> <Pine.LNX.4.58.0803211635160.3220@gandalf.stny.rr.com>
 <47E41EDB.7030908@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:40639 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYCXUf0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Mar 2008 16:35:26 -0400
In-Reply-To: <47E41EDB.7030908@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 21 Mar 2008, Hiroshi Shimamoto wrote:
>
> >
> > Is this a bug in mainline? The !PREEMPT_RT case should be as close to
> > mainline as possible, with no actual changes in object code. If this is
> > not the case, then we need to fix that.
>
> No, this issue is in -rt only.
>

Hi Hiroshi,

Thanks again for reporting this. I took a deeper look into this today and
came to the conclusion that we need to get rid of both
slab_irq_disable_nort and slab_irq_disable_rt, and simply use
slab_irq_disable ;-)

This is what you patch indirectly does. I'll write up another patch to fix
this.

Thanks,

-- Steve

P.S. I'm hoping to get -rt4 out today.
