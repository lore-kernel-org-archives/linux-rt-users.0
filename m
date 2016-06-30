From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 19:26:11 +0200
Message-ID: <20160630172611.GC3932@pd.tnic>
References: <1467293089-27656-1-git-send-email-minyard@acm.org>
 <20160630094301.22d32ec1@gandalf.local.home>
 <5775316F.2020102@acm.org>
 <20160630115101.6337c395@gandalf.local.home>
 <20160630160128.GA4365@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org>
 <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Corey Minyard <cminyard@mvista.com>
To: Corey Minyard <minyard@acm.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43710 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbcF3RhE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 13:37:04 -0400
Content-Disposition: inline
In-Reply-To: <57755449.7070302@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jun 30, 2016 at 12:18:01PM -0500, Corey Minyard wrote:
> This is on 3.10-rt with PREEMPT_RT enabled.  It appears that from 3.18-rt
> and later it has code like the change I have proposed, so it does not crash.
> 
> I could add a something to see if the interrupt is coming in early to
> 4.6-rt,
> is that what you are looking for?

Actually, I'd like to know first whether the unpatched upstream kernel -
not -rt - is crashing.

And then 4.6-rt.

Because from looking at your splat, you're getting a thresholding
interrupt the moment you enable the local APIC and from staring at the
MCE code upstream, I think we should be prepared for that scenario.

AFAICT, both -rt and upstream should handle that case just fine and I'm
guessing upstream was fixed at some point and -rt grew another fix which
is probably not needed and it should take the upstream one instead...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
