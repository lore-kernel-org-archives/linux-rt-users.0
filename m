From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [ANNOUNCE] v4.14.29-rt25
Date: Thu, 3 May 2018 13:26:57 -0500
Message-ID: <0096e540-7966-f6bf-522c-c6c18c13da95@ti.com>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
 <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
 <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
 <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
 <20180423191023.qtinidsq4vj3lmha@linutronix.de>
 <8933b3b9-7f70-0f3f-a8b8-19d4369b35d4@ti.com>
 <20180503152417.sztoptu5fcbw2b5h@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503152417.sztoptu5fcbw2b5h@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 05/03/2018 10:24 AM, Sebastian Andrzej Siewior wrote:
> On 2018-05-01 10:04:13 [-0500], Grygorii Strashko wrote:
>> Hi Sebastian,
> Hi Grygorii,
> 
>> Sry, it took some time as i found some instability -
>> test "stress-ng --class os --all 0 -t 5m " not always finished :(
>> So, I've tried to rollback to v4.14.29-rt25 and use as TI RT kernel as
>> pure rt-devel. Still not sure if this is some sort of regression or not.
> 
> is this new? So v4.14.29-rt25 works and v4.14.29-rt25 with this does
> not? This patch just silences the warning so it should not break
> anything…

Yes. It seems not related.

-- 
regards,
-grygorii
