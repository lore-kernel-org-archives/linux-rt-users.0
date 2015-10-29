From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Variscite VAR-SOM-AM33 with patch-3.12.10-rt15
Date: Thu, 29 Oct 2015 19:45:06 +0100
Message-ID: <56326932.3090206@osadl.org>
References: <5631DAE8.3000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "mr. sindar" <npc.sindar@gmail.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:45899 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ2Szr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Oct 2015 14:55:47 -0400
In-Reply-To: <5631DAE8.3000200@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sergey,

> [..]
> But when i enable load with codesyscontrol-system(about 80% CPU load), i
> have following results:
> System without RT-patch:
> T: 0 ( 1412) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   13 Max:
>      572
> System with RT-patch:
> T: 0 ( 1549) P:80 I:10000 C:  10000 Min:     11 Act:   14 Avg:   17 Max:
>     2492
> Is it normal that max jitter in system with RT-patch more(almost 5x
> time) than in system without RT-patch, in this case?  [..]
Is the codesyscontrol system running at priority above 80 or below? If 
above, then at least the second result makes sense, since on a 
single-core system only the one task that runs at highest priority is 
the real-time task that enjoys the worst-case latency of the system. All 
other tasks do not. If, however, priority 80 of the cyclictest task is 
the highest priority of all tasks, then you may have detected a problem 
that needs to be fixed.

Note that cyclictest is intended as a placeholder of a real-time task 
for people who do not have their own user-space real-time project, for 
example kernel developers and board manufacturers. Once you have your 
own real-time application, you better equip it with internal real-time 
checks in a similar way as cyclictest does it, but you should not run 
cyclictest in parallel.

Thanks,
	-Carsten.
