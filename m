From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 13:02:08 +0200
Message-ID: <AANLkTinztcUB6WVJKaZlwPuBrq7nZYN_ROdCC6ZNtRJf@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Sujit K M <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57144 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0FNLCK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 07:02:10 -0400
Received: by bwz7 with SMTP id 7so1993448bwz.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 04:02:08 -0700 (PDT)
In-Reply-To: <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sujit,

thanks for suggestions. I'll try to build the kernel with these
options switched off.

But, generally, is there way to trace what happens in kernel,
something in /proc or /sys ?
Do I need to switch tracing in configuration ?

Thanks,
Maksym.

On 14 June 2010 11:44, Sujit K M <sjt.kar@gmail.com> wrote:
>> CONFIG_PREEMPT_RCU=y
>> # CONFIG_PREEMPT_RCU_TRACE is not set
>
> Why is RCU being set to y?
>
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT_DESKTOP is not set
>
> Fine.
>
>> CONFIG_PREEMPT_RT=y
>
> This is correct.
>
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_SOFTIRQS=y
>> CONFIG_PREEMPT_HARDIRQS=y
>
> I think this part is susceptible.
>
> Thanks,
> Sujit
>
