From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Fri, 1 Jul 2016 09:20:50 +0200
Message-ID: <20160701072050.GA4593@pd.tnic>
References: <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org>
 <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org>
 <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org>
 <20160630182257.GD3932@pd.tnic>
 <577576AA.8040004@mvista.com>
 <20160630203457.GF3932@pd.tnic>
 <5775A181.2050404@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Corey Minyard <cminyard@mvista.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Corey Minyard <minyard@acm.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57183 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbcGAHUy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Jul 2016 03:20:54 -0400
Content-Disposition: inline
In-Reply-To: <5775A181.2050404@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jun 30, 2016 at 05:47:29PM -0500, Corey Minyard wrote:
> You are right, I enabled that on the tip of master and I get the
> following spewing out for a while:
>
> EDAC MC0: 27843 CE memory read error on CPU_SrcID#0_Ha#0_Chan#1_DIMM#0
> (channel:1 slot:0 page:0x102c offset:0x180 grain:32 syndrome:0x0 -  OVERFLOW
> area:DRAM err_code:0001:0091 socket:0 ha:0 channel_mask:2 rank:0)
>
> So there's apparently something broken in the hardware.

Yeah, DIMM0 on your socket 0 is generating a bunch of correctable errors
and might go bad soon, the stress being on "might". You could replace
it.

> That sounds like a bit much.

Actually, you probably would need only a couple:

1. 648ed94038c0 ("x86/mce: Provide a lockless memory pool to save error records")

2. 061120aed708 ("x86/mce: Don't use percpu workqueues")
 - that one is unrelated but should be nice for RT as it gets rid of percpu
   workqueues and I know RT hates them :)

3. fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
 - this one connects the genpool to MCE

4. f29a7aff4bd6 ("x86/mce: Avoid potential deadlock due to printk() in MCE context")
 - and this is the last one which I meant earlier.

So that's 4 patches, more or less.

Now, you're in the perfect position to test those because you *actually*
have a real-life system which generates those errors so it is the
perfect candidate for testing the backports. And you should test them
with the failing DIMM still in place, of course.

HTH.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
