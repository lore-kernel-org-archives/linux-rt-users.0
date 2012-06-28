From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: RT patch and XEN
Date: Wed, 27 Jun 2012 23:16:42 -0400
Message-ID: <4FEBCC9A.8070505@gmail.com>
References: <4FEB729E.2080508@gmail.com> <A4673A1C-DBAE-4FF1-B9DF-428C47A37D0C@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40633 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab2F1DQs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 23:16:48 -0400
Received: by vcbf11 with SMTP id f11so1219210vcb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2012 20:16:47 -0700 (PDT)
In-Reply-To: <A4673A1C-DBAE-4FF1-B9DF-428C47A37D0C@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 6/27/12 7:04 PM, Sven-Thorsten Dietrich wrote:
>
> On Jun 27, 2012, at 1:52 PM, Dong Liu wrote:
>
>> Hi,
>>
>> I tried to run PREEMPT_RT patch under XEN, but running into some problem.
>>
>> My kernel is 3.4.3 with -r11 patch. XEN is 4.1.2. The kernel is running file as dom0. But as a Paravirtual (PV) domU, the system crashes normal when there is network traffic. kernel message indicates is kernel/rtmutex_common.h:75, which is,
>>
>>        BUG_ON(w->lock != lock);
>>
>> Is this a known problem?
>
> I would consider this hopeless.
>
> Xen will not get you RT performance nor full preemption, so there is no point in running RT on Xen.
>
> Use KVM
>
> Sven
>

I also thought of that, because the RT performance or full preemption 
also depends on Xen's code, scheduler and spin lock etc. But I just want 
to have a system for benchmark comparison.

Running the RT kernel as HVM guest is fine.

Thanks!

Dong
