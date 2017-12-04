From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: better performance during stress
Date: Mon, 4 Dec 2017 22:29:16 +0200
Message-ID: <CAJ2oMhJr9tneahx0B=Dx8ZxbRna15zhr3+BUh3OwQ8iBMTx_CA@mail.gmail.com>
References: <CAJ2oMhJX7hVzB0DEjvtuCmP+AAenYhR_yQZWCbGD2pOjOpFzNg@mail.gmail.com>
 <6257f93e-449f-659a-fbe4-8dd7b3941d50@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34122 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdLDU3R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 15:29:17 -0500
Received: by mail-wm0-f41.google.com with SMTP id y82so16136113wmg.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Dec 2017 12:29:17 -0800 (PST)
In-Reply-To: <6257f93e-449f-659a-fbe4-8dd7b3941d50@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 4, 2017 at 9:11 PM, Daniel Bristot de Oliveira
<daniel@bristot.me> wrote:
>
>
> On 12/04/2017 06:06 PM, Ran Shalit wrote:
>> Hello,
>>
>>
>> I would like to ask if anyone familiar with results showing better
>> performance during stress.
>> We expected (and seen) usually degraded performance during stress, so
>> such result is a surprise.
>> I use cyclictest and see that both average and maximum have lower
>> value during stress.
>> The chip is i7.
>
> Stress runs a busy loop in user-space, hence the preempt/irqs are
> always enabled.

I understand the comments that comes later, but not this one above.
Can you please explain?

Thanks


>Moreover, it avoids letting the processor going to idle,
> avoiding "exit from idle" latencies.
>
> Using a stress thread per CPU will probably give you better results than
> just letting the system going idle.
>
> You should use rteval as a workload:
>
> https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/rteval
>
> -- Daniel
>> Thank you.
>> Ran
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
