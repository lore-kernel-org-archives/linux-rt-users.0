From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Re: Long max latencies on Wandbaord / Freescale i.MX6
Date: Tue, 29 Sep 2015 08:30:56 +0200
Message-ID: <560A3020.5090909@gmx.net>
References: <5606677A.1020705@gmx.net>
 <alpine.DEB.2.11.1509271346160.4500@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51648 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbbI2Ga7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Sep 2015 02:30:59 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0Lbi2Z-1aMRyc0TsZ-00lCz0 for
 <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2015 08:30:57 +0200
In-Reply-To: <alpine.DEB.2.11.1509271346160.4500@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

just for imformation what causes the long latencies...

cause of the latency problem of up to 10ms was 'CONFIG_PROVE_LOCKING' 
enabled in the kernel config. After disabling it, the max latency is now 
below 400us. (many thx to tglx who found the problem).

The following arm boards have 'CONFIG_PROVE_LOCKING=y' in the defconfig 
and therefore the same problem:

ezx_defconfig
imote2_defconfig
imx_v6_v7_defconfig
moxart_defconfig
mxs_defconfig
omap2plus_defconfig

Regards
Matthias


Am 27.09.2015 um 13:49 schrieb Thomas Gleixner:
> On Sat, 26 Sep 2015, Matthias Meier wrote:
>
>> Hi,
>>
>> using cyclictest I measure long max latencies of >10ms on a Wandboard dual
>> (Freescale i.MX6 dual Cortex-A9 SoC).
>>
>> The latency problem happens with diffent scenarios:
>> - without or with rt-patch  (4.1.7-rt8 w. CONFIG_PREEMPT_RT_FULL)
>> - different Kernels (3.17, 4.1, 4.2 w. CONFIG_PREEMPT__LL)
>> - different CPU governors including 'performance'
>> - independant of CPU load
>> - even with no other userspace processes but init, the login sh and cyclictest
>> (I use a minimal builroot rfs).
>> - independant of cyclictest prio
>>
>> Using the same buildroot rfs on a A20 SoC (bananapro) with 4.1.7-rt8 shows
>> acceptable rt-latencies of ~ 200us.
>>
>> Ftracing 'irqsoff' on the rt-patched 4.1 kernel shows always long latency
>> after 'raw_spin_lock_irq' (see log below).
>>
>> Do you think it is a driver which stalls or hrtimer not working correctly on
>> this SoC or someting else?
>> If it is a driver, how could I find out which it is?
>
> Try to capture the issue with full function tracing.
>
> cyclictest --smp -p80 -m -f -b 5000
>
> That stops the tracer when the latency is > 5ms. You might have to
> increase the trace buffer size. Please upload the trace to some place
> or send it to me privately (it's over the size limit of the list).
>
> Thanks,
>
> 	tglx
>
>
