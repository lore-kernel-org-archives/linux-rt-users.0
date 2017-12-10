From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Ethernet chunks behavior
Date: Sun, 10 Dec 2017 22:33:18 +0200
Message-ID: <CAJ2oMhKWP5qfTc3oOCU=ux0dPwZ410X9XaheN9sOAWH2q8oSdg@mail.gmail.com>
References: <CAJ2oMhLR0U3kPB1fYxdTvVoy4FuNDBW2xj7CswiWkATZhROFww@mail.gmail.com>
 <Pine.NEB.4.64.1712100757170.29049@freeby.mesanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Peter C. Wallace" <pcw@mesanet.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35906 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdLJUdT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Dec 2017 15:33:19 -0500
Received: by mail-wm0-f41.google.com with SMTP id b76so10827753wmg.1
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Dec 2017 12:33:19 -0800 (PST)
In-Reply-To: <Pine.NEB.4.64.1712100757170.29049@freeby.mesanet.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Dec 10, 2017 at 5:58 PM, Peter C. Wallace <pcw@mesanet.com> wrote:
> On Sun, 10 Dec 2017, Ran Shalit wrote:
>
>> Date: Sun, 10 Dec 2017 17:40:27 +0200
>> From: Ran Shalit <ranshalit@gmail.com>
>> To: linux-rt-users <linux-rt-users@vger.kernel.org>
>> Subject: Ethernet chunks behavior
>>
>>
>> Hello,
>>
>> We use rt patch with UBUNTU,and have a "high priority" thread with 1
>> millisecond periodic rate.
>> That rt thread, also send UDP Ethernet packets.
>> This project was ported from VXWORKS project, but we notice the
>> following difference:
>> Although the rt thread gets its 1 millisecond periodic in high
>> accuracy, the udp is being send in chunks, as if several messages are
>> aggregated before being delivered.
>>
>> Is there any reason for such behavior ?
>>
>> Regards,
>> Ran
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> Is it possible your Ethernet driver has coalesce options enabled?
>
> Check with ethtool -c devname
>

Hi,

I will check this tomorrow and update,
I also see that there are other methods for reducing lateny,

In the following guide chapter 12:
https://access.redhat.com/sites/default/files/attachments/201501-perf-brief-low-latency-tuning-rhel7-v1.1.pdf
such as irqbalance,
and there is also some tunning such as
sysctl -w net.ipv4.tcp_low_latency=1

Regards,
Ran

>
> Peter Wallace
> Mesa Electronics
>
