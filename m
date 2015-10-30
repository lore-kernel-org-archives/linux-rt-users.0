From: "mr. sindar" <npc.sindar@gmail.com>
Subject: Re: Variscite VAR-SOM-AM33 with patch-3.12.10-rt15
Date: Fri, 30 Oct 2015 11:08:12 +0300
Message-ID: <5633256C.9090109@gmail.com>
References: <5631DAE8.3000200@gmail.com> <56326932.3090206@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Carsten Emde <C.Emde@osadl.org>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32976 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758633AbbJ3IIU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Oct 2015 04:08:20 -0400
Received: by lfbf136 with SMTP id f136so15536567lfb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2015 01:08:18 -0700 (PDT)
In-Reply-To: <56326932.3090206@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



29/10/15 21:45, Carsten Emde:
> Is the codesyscontrol system running at priority above 80 or below? If
> above, then at least the second result makes sense, since on a
> single-core system only the one task that runs at highest priority is
> the real-time task that enjoys the worst-case latency of the system. All
> other tasks do not. If, however, priority 80 of the cyclictest task is
> the highest priority of all tasks, then you may have detected a problem
> that needs to be fixed.
>
I executed codesyscontrol without setting any priority and scheduling 
policy. When i execute chrt -p <pid_of_codesyscontrol>, it shows:
pid 1532's current scheduling policy: SCHED_OTHER
pid 1532's current scheduling priority: 0
But now i think it wasn't true. After your advice i execute cyclitest 
with maximum priority(99), and results became deterministic.
./cyclictest -t1 -p 99 -n -i 10000 -l 10000
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 4.95 4.39 2.80 2/77 1533
T: 0 ( 1533) P:99 I:10000 C:  10000 Min:     13 Act:   20 Avg:   20 Max: 
      62

> Note that cyclictest is intended as a placeholder of a real-time task
> for people who do not have their own user-space real-time project, for
> example kernel developers and board manufacturers. Once you have your
> own real-time application, you better equip it with internal real-time
> checks in a similar way as cyclictest does it, but you should not run
> cyclictest in parallel.
>
> Thanks,
>      -Carsten.
The real goal for me, indeed, is running codesyscontrol, which is runs 
IEC 61131-3 industrial programs.
First i tried codesyscontrol run on Linux without RT-patch. It was 
sporadic multiplying of  cycle time of IEC 61131-3-program. And then i 
decide to try RT-patch. But multiplying of  cycle time in CodeSys is 
still appears, even when it runs with 99 priority. So now i think it's a 
problem in CodeSys runtime system(as i convinced with your advice, that 
RT-patch works well), i wrote this issue to their support(because we are 
buying binary package of CodeSys, i can't do with this any programming 
hacks, but only administrative).

Thank You very much for help!

-- 
Best regards, Sergey.
