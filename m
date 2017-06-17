From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Sat, 17 Jun 2017 10:14:37 +0200
Message-ID: <1497687277.6908.31.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:58568 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbdFQIOu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Jun 2017 04:14:50 -0400
In-Reply-To: <20170616105610.rbc6itylcrsla56l@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-06-16 at 12:56 +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.11.5-rt1 patch set. 
> The release has been delayed due to the hotplug rework that was started
> before the final v4.11 release. However the new code has not been
> stabilized yet and it was decided to bring back the old patches before
> delaying the v4.11-RT release any longer. We will try to complete the
> hotplug rework (for RT) in the v4.11 cycle.
> 
> Changes since v4.9.39-rt21:
> 
>   - rebase to v4.11.5

Hi Sebastian,

I noticed a couple things wrt migrate_disable() changes...

During that rebase, migrate_disable() was changed to no longer map to
preempt_disable() for nonrt, but some patches still assume it does.  It
now depends upon PREEMPT_COUNT, the RT workaround in futex.c induces
grumbling in nonrt builds with PREEMPT_COUNT enabled.

	-Mike
