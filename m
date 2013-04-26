From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 11:16:56 +0200
Message-ID: <20130426091656.GD20927@linutronix.de>
References: <1365937652.4717.25.camel@marge.simpson.net>
 <1366685096.9609.145.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47827 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3DZJQ6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 05:16:58 -0400
Content-Disposition: inline
In-Reply-To: <1366685096.9609.145.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2013-04-22 22:44:56 [-0400]:

>When I built with CONFIG_DEBUG_FORCE_WEAK_PER_CPU it had issues with the
>swap lock. Can you try this patch? What you showed looks different, but
>did that happen with the updates you made?

Steven, could you please resend it with a sign-off-by and maybe a little
description? It seems to fix the same problen in v3.8.

>-- Steve

Sebastian
