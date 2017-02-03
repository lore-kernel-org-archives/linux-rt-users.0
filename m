From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [RFC v2] timers: Don't wake ktimersoftd on every tick
Date: Fri, 3 Feb 2017 12:27:01 -0600
Message-ID: <5f021210-93e3-7f94-676f-95de9a07ee16@ni.com>
References: <20161213214405.28554-1-haris.okanovic@ni.com>
 <20170203165151.qbpjothhaqctuzx5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <julia.cartwright@ni.com>,
        <gratian.crisan@ni.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 02/03/2017 10:51 AM, Sebastian Andrzej Siewior wrote:
> On 2016-12-13 15:44:05 [-0600], Haris Okanovic wrote:
>> Changed the way timers are collected per Julia and Thomas'
>> recommendation: Expired timers are now collected in interrupt context
>> and fired in ktimersoftd to avoid double-walk of `pending_map`.
> …
>> Thanks,
>> Haris
>
> I've been staring at it for a while now and now I applied it locally and
> look how it goes.
> I would need that patch signed as per
> 	https://kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> if you want it applied.

Sent a proper PATCH email with sign-off.

Built and booted with both CONFIG_HZ_PERIODIC=y and CONFIG_NO_HZ_IDLE=y 
configurations (100 HZ). Ran short cyclictest to verify numbers.

>> ---
>>  kernel/time/timer.c | 97 ++++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 67 insertions(+), 30 deletions(-)
>
> Sebastian
>
