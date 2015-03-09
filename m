From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Mon, 09 Mar 2015 17:49:06 +0100
Message-ID: <54FDCF02.4010207@linutronix.de>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>	<1424395866-81589-2-git-send-email-tmac@hp.com>	<20150223133719.2b7c604e@gandalf.local.home>	<54EBC2DB.3050904@hp.com>	<20150223195743.546b2ef0@grimm.local.home>	<20150226135630.GD12992@linutronix.de>	<20150226090610.7eb0ac61@gandalf.local.home>	<20150306121921.GA10155@linutronix.de> <20150309123650.51865008@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36721 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbCIQtJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 12:49:09 -0400
In-Reply-To: <20150309123650.51865008@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/09/2015 05:36 PM, Steven Rostedt wrote:
> BTW, I'm going to start with 3.18-rt1 and see what's been added to the
> other -rt updates. If there's something I need that was added to
> 3.18-rt1 can you let me know. That is, if it wasn't marked with a
> stable-rt tag. My scripts will find those.

I tried to create new patch files for new things and mark them stable
where possible.
I didn't mark the "simple-work" (a workqueue based on swait to avoid a
new kernel thread for each of those things where we need to schedule a
workqueue or something like that from atomic context, like MCE) with cc
stable.

The patch where I reverted this timer thingy is
  Revert-timers-do-not-raise-softirq-unconditionally.patch

and it was due to hrtimer beeing broken on 3.18 and has no stable tag.

I'm not sure about the multi-queue block stuff (*-mq-* in the queue).
You might want take a look. I updated a few patches because I managed
to create deadlocks. I'm not sure if it was possible deadlock in v3.14
and I simply didn't trigger if the code changed and it become possible.
I remember that the multi queue block code entered v3.12 but was unused
and started with v3.14 it gained a user.

> 
> -- Steve

Sebastian
