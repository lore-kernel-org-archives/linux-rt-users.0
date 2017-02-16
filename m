From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Latency difference between posix & non-posix timer
Date: Thu, 16 Feb 2017 09:54:19 +0200
Message-ID: <CAJ2oMhLB+7Aifu-+4_ErGg4gYF4Abn8dz-XDAESqwQmAADknmQ@mail.gmail.com>
References: <CAJ2oMhLAwf7AEjOGLTx9Lhd0DVH1Psd-rmOoQkiKVTAiVaDXMQ@mail.gmail.com>
 <20170215171225.unyjy4ivykrfpnj6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36151 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdBPHyV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2017 02:54:21 -0500
Received: by mail-wm0-f51.google.com with SMTP id c85so59667656wmi.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Feb 2017 23:54:20 -0800 (PST)
In-Reply-To: <20170215171225.unyjy4ivykrfpnj6@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 15, 2017 at 7:12 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-02-05 19:11:01 [+0200], Ran Shalit wrote:
>> Hello,
> Hi,
>
>> We made some testing on out cpu, installed with 4.1.15-rt17 kernel,
>> and we observed significant difference in latency between posic to
>> non-posix cyclictest benchmark.
>>
>> with non posix we reach max ~50usec
>> while with posix we reach max ~170usec
>>
>> On checking the exaples in cyclic test wiki, it seems that the
>> difference should not be that big :
>> https://rt.wiki.kernel.org/index.php/Cyclictest
>>
>> What is the reason for such difference in behaviour ?
>> Does it mean we better use non-posix timer in application ?
> As written in the other thread (regarding posix-timer):
> I tested today v4.9-RT and didn't notice such high spikes between
> clock_nanosleep and the posix timer. You have the consider that the
> wakeup happens from ktimersoftirq so you have one additional context
> switch here.
> I general the clock_nansleep interface should be preferred if possible
> to avoid that ctx switch.
>

I understand, Thank you a lot.
Ran

> Sebastian
