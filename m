From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 17:47:29 -0500
Message-ID: <5775A181.2050404@acm.org>
References: <20160630115101.6337c395@gandalf.local.home>
 <20160630160128.GA4365@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org> <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org> <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org> <20160630182257.GD3932@pd.tnic>
 <577576AA.8040004@mvista.com> <20160630203457.GF3932@pd.tnic>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35379 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcF3WsU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 18:48:20 -0400
Received: by mail-oi0-f49.google.com with SMTP id r2so87213751oih.2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 15:47:33 -0700 (PDT)
In-Reply-To: <20160630203457.GF3932@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/30/2016 03:34 PM, Borislav Petkov wrote:
> On Thu, Jun 30, 2016 at 02:44:42PM -0500, Corey Minyard wrote:
>> I don't think they are.  I think there is something about this
>> particular board.  We aren't having any issues with other systems.
> Right, so the fact that it raises the thresholding interrupt could
> mean that it generates a bunch of correctable ECC errors and it hits a
> threshold which is signalled by that interrupt.
>
> And if that is true, then you should be seeing some errors in mcelog or
> sb_edac reporting some.
>
> You could, just in case, try latest upstream and enable
> CONFIG_EDAC_SBRIDGE and check dmesg for some ECCs.
>
> Or, of course, something else entirely might be funny with that box,
> causing that interrupt to fire.

You are right, I enabled that on the tip of master and I get the
following spewing out for a while:

EDAC MC0: 27843 CE memory read error on CPU_SrcID#0_Ha#0_Chan#1_DIMM#0 
(channel:1 slot:0 page:0x102c offset:0x180 grain:32 syndrome:0x0 -  
OVERFLOW area:DRAM err_code:0001:0091 socket:0 ha:0 channel_mask:2 rank:0)

So there's apparently something broken in the hardware.

>> But as you say, the kernel should be ready for this.
> Right, and we've removed that mce_notify_irq() call in
> intel_threshold_interrupt() with
>
>    f29a7aff4bd6 ("x86/mce: Avoid potential deadlock due to printk() in MCE context")
>
> but that's more of a side-effect of that patch.
>
> And if you want to backport it, you'd need the mce_gen_pool_add() and
> remaining machinery for the genpool.

That sounds like a bit much.

Steven, what would you like to do here?

Thanks,

-corey

> Presumably, booting with "mce=no_cmci" should fix this but then you
> won't have the CMCI thresholding, i.e., the interrupt which gets raised
> when a certain amount of correctable errors has been generated.
>
> Hmm, a funny box that.
>

