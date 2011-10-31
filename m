From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: Re: rt for newbie
Date: Mon, 31 Oct 2011 09:26:13 +0100
Message-ID: <4EAE5BA5.6080307@googlemail.com>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com> <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com> <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com> <4EA9D980.5080903@osadl.org> <CADZpk3s-4kGZL01C+aYgqKnv09-YFS+Lo76Te2E_mT6A_gK_qg@mail.gmail.com> <4EAAE22F.1000703@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sashka@mail.ru, linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42888 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab1JaI0Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Oct 2011 04:26:16 -0400
Received: by eye27 with SMTP id 27so5080855eye.19
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2011 01:26:15 -0700 (PDT)
In-Reply-To: <4EAAE22F.1000703@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

these are really good hints for working with the patches and getting the 
best out of it or to estimate, how good the performance will be.

Besides the fact, that it is good to know such things right now, I ask 
myself, where on the web to find such infos - and maybe even more? This 
is the first time, that I read about such things...

So, where to find more about this?

Best regards,
Dennis


Am 28.10.2011 19:11, schrieb Carsten Emde:
> Sashka,
>
>> Did I understand you correctly, I need to disable Dynamic Ticks and
>> Check for stack overflow?
> Yes.
>
>> If yes, then here are my results
> Thank you.
>
>> # cyclictest -m -Sp99 -i100 -d0
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 0.01 0.09 0.05 2/122 2187
>>
>> T: 0 ( 2180) P:99 I:100 C:1969005 Min:      1 Act:    2 Avg:    1 
>> Max:      10
>> T: 1 ( 2181) P:99 I:100 C:1968946 Min:      1 Act:    2 Avg:    2 
>> Max:      69
>> T: 2 ( 2182) P:99 I:100 C:1968888 Min:      1 Act:    2 Avg:    2 
>> Max:      12
>> T: 3 ( 2183) P:99 I:100 C:1968829 Min:      1 Act:    2 Avg:    2 
>> Max:      52
>> T: 4 ( 2184) P:99 I:100 C:1968770 Min:      1 Act:    2 Avg:    1 
>> Max:      10
>> T: 5 ( 2185) P:99 I:100 C:1968712 Min:      1 Act:    5 Avg:    2 
>> Max:       9
>> T: 6 ( 2186) P:99 I:100 C:1968654 Min:      1 Act:    2 Avg:    2 
>> Max:      55
>> T: 7 ( 2187) P:99 I:100 C:1968594 Min:      1 Act:    2 Avg:    1 
>> Max:      17
>>
>> CPU I've got is Xeon X5472  @ 3.00GHz
> These data look very promising.
>
> In a next step, you may want run a billion cycles (-l1000000000) which 
> takes a bit more than a day and apply a load scenario that reflects 
> the load to be expected under production conditions. This will provide 
> already a good estimate of the worst-case latency of the system.
>
> The worst-case latency can be reduced further, if you disable throttling:
> # cd /sys/devices/system/cpu
> # for i in cpu*/cpufreq/scaling_governor
> > do
> > echo performance >$i
> > done
>
>     -Carsten.
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

