From: Eric St-Laurent <ericstl34@sympatico.ca>
Subject: Re: v2.6.21.4-rt11
Date: Tue, 12 Jun 2007 02:03:01 -0400
Message-ID: <1181628181.7641.15.camel@perkele>
References: <20070609210507.GA29194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tomts36.bellnexxia.net ([209.226.175.93]:60587 "EHLO
	tomts36-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbXFLGuU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jun 2007 02:50:20 -0400
In-Reply-To: <20070609210507.GA29194@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-09-06 at 23:05 +0200, Ingo Molnar wrote:
> i'm pleased to announce the v2.6.21.4-rt11 kernel, which can be 
> downloaded from the usual place:
>  

I'm running 2.6.21.4-rt12-cfs-v17 (x86_64), so far no problems. I like
this kernel a lot, it's feels quite smooth.

One little thing, no HPET timer is detected. By looking at the patch,
even the force detect code is there, it should work.

The hpet timer is not available as a clocksource and only one hpet
related message is present in dmesg:

PM: Adding info for No Bus:hpet

This is on a Asus P5LD2-VM motherboard (ICH7)

Relevant config bits:

CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y

Should I enable one of the two other options? Any ideas?


Best regards,

- Eric
