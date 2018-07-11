Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:46837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388631AbeGKRMr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Jul 2018 13:12:47 -0400
Message-ID: <1531328845.12761.54.camel@gmx.de>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
From: Mike Galbraith <efault@gmx.de>
Date: Wed, 11 Jul 2018 19:07:25 +0200
In-Reply-To: <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
         <20180522131004.3012953c@gandalf.local.home>
         <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
         <20180522132429.6f1dcf92@gandalf.local.home>
         <20180522173333.aawadhkcekzvrswp@linutronix.de>
         <20180711092555.268adf7f@gandalf.local.home>
         <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

On Wed, 2018-07-11 at 15:31 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-11 09:25:55 [-0400], Steven Rostedt wrote:
> > Did you decide to create a local_lock_bh(lock) function? I don't see it.
> > 
> > And should this be backported to 4.14-rt too? You state you saw this in
> > 4.16-rt, but did you start doing something different then, or did the
> > kernel change?
> 
> I wanted to re-evaluate the whole situation here but didn't get to it
> yet.

Ignore the rfc I sent then.  New toy works well enough meanwhile.

(cavium boxen are a LOT less dinky/cute than I'm used to thinking of
arm gizmos being.. 224 core box boogies right along)

	-Mike
