From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 12:54:14 -0500
Message-ID: <57755CC6.60506@acm.org>
References: <1467293089-27656-1-git-send-email-minyard@acm.org>
 <20160630094301.22d32ec1@gandalf.local.home> <5775316F.2020102@acm.org>
 <20160630115101.6337c395@gandalf.local.home> <20160630160128.GA4365@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org> <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org> <20160630172611.GC3932@pd.tnic>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Corey Minyard <cminyard@mvista.com>
To: Borislav Petkov <bp@alien8.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35735 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbcF3RyR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 13:54:17 -0400
Received: by mail-oi0-f50.google.com with SMTP id r2so76289295oih.2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 10:54:17 -0700 (PDT)
In-Reply-To: <20160630172611.GC3932@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/30/2016 12:26 PM, Borislav Petkov wrote:
> On Thu, Jun 30, 2016 at 12:18:01PM -0500, Corey Minyard wrote:
>> This is on 3.10-rt with PREEMPT_RT enabled.  It appears that from 3.18-rt
>> and later it has code like the change I have proposed, so it does not crash.
>>
>> I could add a something to see if the interrupt is coming in early to
>> 4.6-rt,
>> is that what you are looking for?
> Actually, I'd like to know first whether the unpatched upstream kernel -
> not -rt - is crashing.

It won't crash.  If you disable PREEMPT_RT on the 3.10-rt kernel it won't
crash (which I have tested).  With PREEMPT_RT, the kernel creates a
separate thread that is woken on mce notifications.  The trouble is
that the interrupts are initialized before the thread is created.

> And then 4.6-rt.
>
> Because from looking at your splat, you're getting a thresholding
> interrupt the moment you enable the local APIC and from staring at the
> MCE code upstream, I think we should be prepared for that scenario.
>
> AFAICT, both -rt and upstream should handle that case just fine and I'm
> guessing upstream was fixed at some point and -rt grew another fix which
> is probably not needed and it should take the upstream one instead...

This is not a bug in mainline.  This is only an RT bug, and only
with PREEMPT_RT enabled.

I can try these things if you really want, but it doesn't seem like
a useful activity to me.

It looks like in 3.18-rt someone noticed this issue and fixed it,
but the fix wasn't backported to earlier kernels.  I'm really just
trying to get that fix backported.

-corey
