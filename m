From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: Priority of serial driver
Date: Tue, 25 Sep 2007 11:24:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709251119480.11844@frodo.shire>
References: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
 <20070922191522.GA4887@ghostprotocols.net>
 <f96d234e0709240750h6d96f80ev87da3bfde185b6ff@mail.gmail.com>
 <f96d234e0709240845t2c00a728u84f2fd4b58690aaf@mail.gmail.com>
 <f96d234e0709241051m3178ae07v89b394a28ae8ca3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	linux-rt-users@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3572 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXIYJYY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2007 05:24:24 -0400
Received: by ug-out-1314.google.com with SMTP id z38so903358ugc
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Sep 2007 02:24:23 -0700 (PDT)
In-Reply-To: <f96d234e0709241051m3178ae07v89b394a28ae8ca3c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Mon, 24 Sep 2007, Cliff Brake wrote:

> On 9/24/07, Cliff Brake <cliff.brake@gmail.com> wrote:
>> On 9/24/07, Cliff Brake <cliff.brake@gmail.com> wrote:
>>> On 9/22/07, Arnaldo Carvalho de Melo <acme@ghostprotocols.net> wrote:
>>>> Look at the IRQ-<N> kernel thread that services the serial port hardware
>>>> interrupt, use chrt to bump its priority and see if it helps.
>>>
>>> I don't see any IRQ-<N> processes on my system -- does this require
>>> the RT patch?  Perhaps this is different on ARM/x86?
>>
>> I've applied the RT patch which gives me the IRQ-N processes -- trying now ...
>
> RT patch (2.6.23-rc4-rt1) fixed the problem without any additional
> priority adjustments, so that is obviously the solution.  I guess I
> should know by now that RT with Linux is still hit and miss without
> the RT patch.

Yes, that is the point of the -RT patch. Without the patch there are 
unbounded code paths running with preemption off. Your maximum jitter thus 
highly depends on the complete workload of your system. With the -RT patch 
applied there are (almost) no unbounded code paths running with preemption 
off. The maximum jitter of a given task will thus only depend on the 
workload of the tasks running at the same or higher priority. That is much more 
controlable.

Esben

>
> Thanks,
> Cliff
>
> -- 
> =======================
> Cliff Brake
> http://bec-systems.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
