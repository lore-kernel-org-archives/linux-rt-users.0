From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Thu, 16 Apr 2015 09:50:33 +0200
Message-ID: <20150416075033.GC26573@linutronix.de>
References: <20140613142506.GL3448@lukather>
 <20150217083859.GB26177@linutronix.de>
 <20150316181900.GA4638@lukather>
 <20150316183033.GH4560@piout.net>
 <loom.20150413T150403-767@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Christian Jann <Christian.Jann@elektrobit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42866 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbDPHug (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 03:50:36 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150413T150403-767@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christian Jann | 2015-04-13 13:37:30 [+0000]:

>Are there any updates concerning the patches or does anybody have some more
>information on how the problem was resolved on the Atmel controller?
>
>I'm encountering the same problem on a Tegra K1 processor with a
>3.10.61-rt65 kernel and I'm unsure what's the best way to fix it.

in general what you want is to mark timer interrupt with IRQF_TIMER and
that should be enough. The at91 has a few problems here. One thing is
that it switches from periodic mode to oneshot and this seems not to
work perfectly. The other thing is that the timer interrupt is shared
with the uart.

>Best regards
>Christian Jann

Sebastian
