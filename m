From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.19-rt11 boot failure
Date: Sun, 10 Dec 2006 00:54:22 +0000
Message-ID: <457B5ABE.4080709@rncbc.org>
References: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org> <1165700275.24604.350.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa1.netcabo.pt ([212.113.174.16]:3998 "EHLO
	exch01smtp03.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757734AbWLJAuM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Dec 2006 19:50:12 -0500
To: tglx@linutronix.de
In-Reply-To: <1165700275.24604.350.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Sat, 2006-12-09 at 21:28 +0000, Rui Nuno Capela wrote:
>> Hi all,
>>
>> Sorry for the interrupt, but all my 2.6.19-rt11 builds very fail early on
>> boot. It doesn't matter if its UP or SMP. This is a sample of what I could
>> capture on one case via serial console:
> 
> Can you please disable CONFIG_HPET_TIMER ?
> 

Yes, sorry :) now it boots and runs apparently fine.

I always had HPET_TIMER enabled until now. Ok, last time I tried was on
2.6.19-rt6.  Somehow I've failed to know or simply missed whether HPET
it's supposed to be off on PREEMPT_RT kernels. Maybe some simple
heads-up would be welcome :)

Notice that lately I have both HIGH_RES_TIMERS and NO_HZ enabled. Is
there any sense on having those options mutually exclusive with HPET_TIMER ?

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
