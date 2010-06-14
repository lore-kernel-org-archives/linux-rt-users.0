From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 16:39:56 +0530
Message-ID: <AANLkTiljypxLRIyK-zWOJWcgVBcAvmy1YNjLReOCwsv7@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Maksym Parkachov <lazy.gopher@gmail.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55989 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0FNLJ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 07:09:57 -0400
Received: by vws14 with SMTP id 14so524136vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 04:09:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 14, 2010 at 4:35 PM, John Kacur <jkacur@redhat.com> wrote:
>
>
> On Mon, 14 Jun 2010, Sujit K M wrote:
>
>> > CONFIG_PREEMPT_RCU=y
>> > # CONFIG_PREEMPT_RCU_TRACE is not set
>>
>> Why is RCU being set to y?
>
> It should be fine to set it to y

Does Angstrom stable distribution need RCU?

>
>>
>> > # CONFIG_PREEMPT_NONE is not set
>> > # CONFIG_PREEMPT_VOLUNTARY is not set
>> > # CONFIG_PREEMPT_DESKTOP is not set
>>
>> Fine.
>>
>> > CONFIG_PREEMPT_RT=y
>>
>> This is correct.
>>
>> > CONFIG_PREEMPT=y
>> > CONFIG_PREEMPT_SOFTIRQS=y
>> > CONFIG_PREEMPT_HARDIRQS=y
>>
>> I think this part is susceptible.
>
> Suceptible to what?
> Those setting are all correct.
> In fact, most are automatically set for you  after
> choosing CONFIG_PREEMPT_RT=y

I thought in any Real Time system there can be only SoftIRQ's or
HardIRQ's. Also CONFIG_PREEMPT is an Non RT design.

>
> His problem is not with the config.
>

Above I think It is certainly an Config problem.
