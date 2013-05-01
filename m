From: Stanislav Meduna <stano@meduna.org>
Subject: Re: How to find long execution times in kernel threads?
Date: Wed, 01 May 2013 10:19:07 +0200
Message-ID: <5180CFFB.5070401@meduna.org>
References: <517FCBA3.1000909@meduna.org> <517FF6B1.9050204@osadl.org> <5180072F.7010102@meduna.org> <5180C62F.6030904@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:50578 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab3EAITS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 May 2013 04:19:18 -0400
In-Reply-To: <5180C62F.6030904@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01.05.2013 09:37, Carsten Emde wrote:

> He who laughs last, laughs loudest. Since the entire system slows down,
> you may only need to adapt cycles and thresholds accordingly.

Yep, I will try it. However as this is connected to a real application
running parallel and generating some load pattern this is not so easy -
for example I'll need to go down with the HZ, otherwise the timer
ticking once per ms can be already too much, which in turn will
probably affect the RR threads etc. There are also constraints
from the outside world that have to be met while running - these
are still far, but with tracing enabled not anymore an order
of magnitude far.

That I am running this on a low-spec embedded systems that already
struggles with saving the data does not make it easier either.

>From what I was already able to capture I did not see anything
that seems plainly wrong, the ksoftirqd just had really a lot
of work with hrtimers, RCU, network etc. But I am not sure whether
I caught _the_ situation.

> Tracing is a very useful tool to identify sources of latencies
> and has helped a lot to make Linux RT as good as it is today.

Yep, the infrastructure is fantastic.

>   cyclictest -m -M -Sp90 -i500 -d0 -fb1000
> 
> probably will break at the first occurrence of the latency in question
> and let you diagnose its origin at the end of the trace output.

I tried this but I was unable to load a trace.dat produced
by breaking the tracing this way into kernelshark on at least
two occasions. Only stopping the trace from trace-cmd itself
worked. Are there some known issues?

I am using trace-cmd from git. The recording and examining
system are not the same, but are reasonably similar library-wise
(both are Debian squeeze-based).

Thanks
-- 
                                  Stano

