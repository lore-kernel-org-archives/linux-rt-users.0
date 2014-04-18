From: Stanislav Meduna <stano@meduna.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Fri, 18 Apr 2014 20:12:41 +0200
Message-ID: <53516B19.6040702@meduna.org>
References: <53503BD8.8000506@meduna.org> <9645151.cbKImklAq0@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tim Sander <tim@krieglstein.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:36036 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbaDRSMt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Apr 2014 14:12:49 -0400
In-Reply-To: <9645151.cbKImklAq0@hydra>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18.04.2014 18:09, Tim Sander wrote:

> Are you sure that this is not the cpu idle latency?

Don't think so. However it is close to what I'd expect as an average
idle time (capped up by periodic ticks @ 250 Hz = 4 ms).

But thanks for the idea, I investigated and booting with kernel
parameter nohlt results in usual latencies reported (372 us max,
not great but acceptable for our usage).

The tracer is in fact right - the interrupts _are_ meant to be off:

arch/arm/mm/proc-arm926.S:

/*
 * cpu_arm926_do_idle()
 *
 * Called with IRQs disabled
 */

Would it be possible to 'lie' to the tracing infrastructure and
treat the cpu_do_idle() as interrupts enabled without
actually enabling them?

Thanks
-- 
                                    Stano

