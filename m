From: Stanislav Meduna <stano@meduna.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Mon, 21 Apr 2014 11:00:12 +0200
Message-ID: <5354DE1C.1000705@meduna.org>
References: <53503BD8.8000506@meduna.org> <9645151.cbKImklAq0@hydra> <53516B19.6040702@meduna.org> <12490005.Mvd4Usk8IT@virgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35514 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaDUJAU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Apr 2014 05:00:20 -0400
In-Reply-To: <12490005.Mvd4Usk8IT@virgo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.04.2014 23:24, Tim Sander wrote:

>>> Are you sure that this is not the cpu idle latency?
>>
>> Don't think so. However it is close to what I'd expect as an average
>> idle time (capped up by periodic ticks @ 250 Hz = 4 ms).
> Have you tried patching out the wfi in the idle loop? At least the i.mx35 does 
> some strange l2cache dance due to an hw bug. Patching out this whole stuff 
> helped a lot with latencys on an unloaded system.

This is indeed some interference in the tracing infrastructure.
Disabling it and looking at the cyclictest output instead gives
much more consistently looking numbers.

Yes the wfi stuff generates a good amount of latency - running
with nohlt is very visible in the cyclictest, but this is in the
~100-300 us range, not the numbers I was seeing.

Thanks
-- 
                                        Stano

