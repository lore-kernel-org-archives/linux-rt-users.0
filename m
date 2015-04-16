From: Christian Jann <Christian.Jann@elektrobit.com>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Thu, 16 Apr 2015 09:55:19 +0000 (UTC)
Message-ID: <loom.20150416T115355-757@post.gmane.org>
References: <20140613142506.GL3448@lukather> <20150217083859.GB26177@linutronix.de> <20150316181900.GA4638@lukather> <20150316183033.GH4560@piout.net> <loom.20150413T150403-767@post.gmane.org> <20150416075033.GC26573@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35678 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473AbbDPJzk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 05:55:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1YigW9-0004mP-8B
	for linux-rt-users@vger.kernel.org; Thu, 16 Apr 2015 11:55:39 +0200
Received: from eth1-fw1-nbg6.eb.noris.de ([213.95.148.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Apr 2015 11:55:29 +0200
Received: from Christian.Jann by eth1-fw1-nbg6.eb.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Apr 2015 11:55:29 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian Andrzej Siewior <bigeasy <at> linutronix.de> writes:

> in general what you want is to mark timer interrupt with IRQF_TIMER and
> that should be enough. The at91 has a few problems here. One thing is
> that it switches from periodic mode to oneshot and this seems not to
> work perfectly. The other thing is that the timer interrupt is shared
> with the uart.

Thanks, I replaced the outdated IRQF_DISABLED flag with IRQF_TIMER and now
it works like a charm. :)



