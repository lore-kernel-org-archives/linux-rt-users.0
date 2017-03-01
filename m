From: Federico Reghenzani <federico.reghenzani@polimi.it>
Subject: Re: NO_HZ and ktimersoftd
Date: Wed, 1 Mar 2017 10:23:00 +0100
Message-ID: <CACKey4yx1NzpiZqm4y4bUnNvp_MdERL3ykBVEUrNjq0ubZ4qjw@mail.gmail.com>
References: <CACKey4zmx_=k6r8BY3B7K9ZuR6x5=11U25-st4oK8WAgo1WgQQ@mail.gmail.com>
 <20170105163210.GJ1335@jcartwri.amer.corp.natinst.com> <20170223180124.ykbhfmkbmf2xa7tk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Federico Reghenzani <federico.reghenzani@polimi.it>,
        Julia Cartwright <julia@ni.com>,
        <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:53102
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750968AbdCAK7w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2017 05:59:52 -0500
Received: by mail-wr0-f171.google.com with SMTP id u48so25711200wrc.0
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Mar 2017 01:23:22 -0800 (PST)
In-Reply-To: <20170223180124.ykbhfmkbmf2xa7tk@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2017-02-23 19:01 GMT+01:00 Sebastian Andrzej Siewior <bigeasy@linutronix.de>:
> On 2017-01-05 10:32:10 [-0600], Julia Cartwright wrote:
>> > This works fine, however when I run my RT application, the thread
>> > kimersoftd is always in "running" state, thus the scheduling interrupt
>> > triggers (because there exists more than 1 task available to run).
>> > Consequently, the advantages of NO_HZ_FULL are vanished.
>>
>> This sounds like the same problem that Haris (cc'd) has looked into and
>> has put together a proposed solution.  See the thread here:
>>
>>    http://www.spinics.net/lists/linux-rt-users/msg16113.html
>
> can you please check latest v4.9.11-rt9 if the issue is still there or
> gone?
>
> Sebastian

It seems fixed, thank you


Cheers,
Federico
