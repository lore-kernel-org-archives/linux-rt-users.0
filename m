From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH:resend] rt: Remove CONFIG_STACK_TRACER from DEBUG_COUNT,
	and fix reminder block
Date: Wed, 28 Apr 2010 21:22:02 +0200
Message-ID: <z2o520f0cf11004281222h4c1cecb6mf41ab89d66ddfcbf@mail.gmail.com>
References: <1272396342-12504-1-git-send-email-jkacur@redhat.com>
	 <alpine.LFD.2.00.1004272205380.2951@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40007 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0D1TWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Apr 2010 15:22:06 -0400
In-Reply-To: <alpine.LFD.2.00.1004272205380.2951@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 27, 2010 at 10:39 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> On Tue, 27 Apr 2010, John Kacur wrote:
>
>> This fix does two things.
>
> This changelog does suck in more than two ways.
>
>> 1. It reverts commit 3e39399ef4a742d994570488994be93ef17d4ef5.
>> - The above commit added back a warning about CONFIG_STACK_TRACER
>> NOT because the warning was necessary but to fix-up a problem where =
you could
>> get an empty REMINDER block in the demg.
>
> The CONFIG_STACK_TRACER printk has been there before and got dropped
> for whatever reason, but the DEBUG_COUNT accounting of
> CONFIG_STACK_TRACER still remained.
>
> So the conclusion that the printk needs to be added back is _NOT_
> completely unreasonable.
>
>> However, CONFIG_STACK_TRACER really should not be in the reminder bl=
ock.
>> Even when configured-in it is not enabled, and thus has neglible imp=
act.
>
> That argument is bogus as it applies to most of the tracing related
> config options.

Not quite. Some of the tracing options are believed to have an impact
even when not enabled.
In particular irqsoff and preemptoff still call a function. Not sure
how minimal the impact is, but
it isn't zero.

>
>> 2. It removes CONFIG_STACK_TRACER from DEBUG_COUNT which is the prop=
er fix
>> for the empty REMINDER block problem.
>
> It's the proper fix if the warning is not justified, which is not
> clear at all. At least not from your changelog.
>
> I do not mind the patch per se, but
>
> 1) the changelog should simply say:
>
> =A0 rt: Remove CONFIG_STACK_TRACER from REMINDER block
>
> =A0 Reason: It does not matter because ....
>
> 2) the patch should cover _all_ tracing options which have no
> =A0 considerable latency impact when just compiled in and not default
> =A0 enabled.
>

Okay, you make some good points, although I'm having a hard time
finding other CONFIGS to safely cut.
Respinning the patch. Thanks for your reply.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
