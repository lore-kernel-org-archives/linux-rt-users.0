From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after console_init
Date: Thu, 20 May 2010 14:23:07 +0400
Message-ID: <201005201423.09075@zigzag.lvk.cs.msu.su>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com> <AANLkTil18TnOR9D-dSFsSFA74Q4UFnldrGLhG1H4jwhf@mail.gmail.com> <alpine.LFD.2.00.1005201142360.3368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sujit K M <sjt.kar@gmail.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:42529 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKXM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 May 2010 06:23:12 -0400
In-Reply-To: <alpine.LFD.2.00.1005201142360.3368@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > >>> Well, obviously it's unsafe if you remove safety checks. And if
> > >>> you care to look at the changelog of kernel/printk.c you'll find
> > >>> out why.
> > >>
> > >> Hmm... did a quick look and could not find anything related there.
> > >> Could you please give a pointer?
>
> Gah, yes. The changelog of the commit is not really helpful. Let me
> explain:
>
> The console drivers might take locks, which are converted to "sleeping
> locks" in preempt-rt. As a result we cannot call into those drivers
> from atomic contexts. And that's what the checks in the printk code
> prevent.

I've already understood that when looking at that code some weeks ago.

Still questions:

1) why does that prevent klogd from working?

2) why does print not pass to non-CON_ATOMIC even if called from non-atomic 
context?

3) I believe that 8250 serial driver is aware of preempt-rt.
Could you please comment on my "2.6.33.2-rt13: RFC: fix serial console" 
post to linux-rt-users list 
(http://eeek.borgchat.net/lists/linux-rt-users/msg05569.html)

Nikita
