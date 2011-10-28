From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: rt for newbie
Date: Fri, 28 Oct 2011 19:11:11 +0200
Message-ID: <4EAAE22F.1000703@osadl.org>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com> <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com> <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com> <4EA9D980.5080903@osadl.org> <CADZpk3s-4kGZL01C+aYgqKnv09-YFS+Lo76Te2E_mT6A_gK_qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: sashka@mail.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:50116 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1J1R0a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 13:26:30 -0400
In-Reply-To: <CADZpk3s-4kGZL01C+aYgqKnv09-YFS+Lo76Te2E_mT6A_gK_qg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sashka,

> Did I understand you correctly, I need to disable Dynamic Ticks and
> Check for stack overflow?
Yes.

> If yes, then here are my results
Thank you.

> # cyclictest -m -Sp99 -i100 -d0
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.01 0.09 0.05 2/122 2187
>
> T: 0 ( 2180) P:99 I:100 C:1969005 Min:      1 Act:    2 Avg:    1 Max:      10
> T: 1 ( 2181) P:99 I:100 C:1968946 Min:      1 Act:    2 Avg:    2 Max:      69
> T: 2 ( 2182) P:99 I:100 C:1968888 Min:      1 Act:    2 Avg:    2 Max:      12
> T: 3 ( 2183) P:99 I:100 C:1968829 Min:      1 Act:    2 Avg:    2 Max:      52
> T: 4 ( 2184) P:99 I:100 C:1968770 Min:      1 Act:    2 Avg:    1 Max:      10
> T: 5 ( 2185) P:99 I:100 C:1968712 Min:      1 Act:    5 Avg:    2 Max:       9
> T: 6 ( 2186) P:99 I:100 C:1968654 Min:      1 Act:    2 Avg:    2 Max:      55
> T: 7 ( 2187) P:99 I:100 C:1968594 Min:      1 Act:    2 Avg:    1 Max:      17
>
> CPU I've got is Xeon X5472  @ 3.00GHz
These data look very promising.

In a next step, you may want run a billion cycles (-l1000000000) which 
takes a bit more than a day and apply a load scenario that reflects the 
load to be expected under production conditions. This will provide 
already a good estimate of the worst-case latency of the system.

The worst-case latency can be reduced further, if you disable throttling:
# cd /sys/devices/system/cpu
# for i in cpu*/cpufreq/scaling_governor
 > do
 > echo performance >$i
 > done

	-Carsten.
