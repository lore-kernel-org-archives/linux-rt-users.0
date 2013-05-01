From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: How to find long execution times in kernel threads?
Date: Wed, 01 May 2013 09:37:19 +0200
Message-ID: <5180C62F.6030904@osadl.org>
References: <517FCBA3.1000909@meduna.org> <517FF6B1.9050204@osadl.org> <5180072F.7010102@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33869 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab3EAHlR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 May 2013 03:41:17 -0400
In-Reply-To: <5180072F.7010102@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Stano,

>> Sure, record everything (trace-cmd record -e all) and analyze the
>> traces.
> Well, the problem is that with record -e all I get 20 ms instead
> of 1 ms, so I'd say Mr. Heisenberg laughs at me loudly here ;)
He who laughs last, laughs loudest. Since the entire system slows down, 
you may only need to adapt cycles and thresholds accordingly. Tracing is 
a very useful tool to identify sources of latencies and has helped a lot 
to make Linux RT as good as it is today. As a role of thumb, for 
example, we use five times longer cycles when enabling function tracing. 
If, for example, the output of

   cyclictest -m -M -Sp90 -i100 -d0

most of the time indicates a worst-case latency of about 50 microseconds 
but is interspersed with sporadic latencies of more than 500 microseconds,

   cyclictest -m -M -Sp90 -i500 -d0 -fb1000

probably will break at the first occurrence of the latency in question 
and let you diagnose its origin at the end of the trace output.

	-Carsten.
