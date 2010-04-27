From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH:resend] rt: Remove CONFIG_STACK_TRACER from DEBUG_COUNT,
 and fix reminder block
Date: Tue, 27 Apr 2010 22:39:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004272205380.2951@localhost.localdomain>
References: <1272396342-12504-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33369 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755029Ab0D0UkM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Apr 2010 16:40:12 -0400
In-Reply-To: <1272396342-12504-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 27 Apr 2010, John Kacur wrote:

> This fix does two things.

This changelog does suck in more than two ways.
 
> 1. It reverts commit 3e39399ef4a742d994570488994be93ef17d4ef5.
> - The above commit added back a warning about CONFIG_STACK_TRACER
> NOT because the warning was necessary but to fix-up a problem where you could
> get an empty REMINDER block in the demg.

The CONFIG_STACK_TRACER printk has been there before and got dropped
for whatever reason, but the DEBUG_COUNT accounting of
CONFIG_STACK_TRACER still remained.

So the conclusion that the printk needs to be added back is _NOT_
completely unreasonable.

> However, CONFIG_STACK_TRACER really should not be in the reminder block.
> Even when configured-in it is not enabled, and thus has neglible impact.

That argument is bogus as it applies to most of the tracing related
config options. 
 
> 2. It removes CONFIG_STACK_TRACER from DEBUG_COUNT which is the proper fix
> for the empty REMINDER block problem.

It's the proper fix if the warning is not justified, which is not
clear at all. At least not from your changelog.

I do not mind the patch per se, but 

1) the changelog should simply say:

   rt: Remove CONFIG_STACK_TRACER from REMINDER block

   Reason: It does not matter because ....

2) the patch should cover _all_ tracing options which have no
   considerable latency impact when just compiled in and not default
   enabled.

Thanks,

	tglx
