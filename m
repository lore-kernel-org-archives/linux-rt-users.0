From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:974
Date: Fri, 31 Aug 2018 14:19:53 -0500
Message-ID: <c744c81c-752e-499e-ffe1-32df30a7831b@ti.com>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
 <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 08/30/2018 04:14 AM, Sebastian Andrzej Siewior wrote:
> On 2018-08-29 16:28:50 [-0500], Grygorii Strashko wrote:
>>
>> Thank you. Are there any plans to back port them for 4.14-rt?
>> Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.
> 
> Grygorii, could you please replace the second patch with
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/irqchip-gic-v3-its-Move-pending-table-allocation-to-.patch?h=linux-4.18.y-rt-patches
> 
> (incremental patch
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/patch/?id=4a0819bb25d12d39c0390636122eefba232596c1
> )
> 
> and check if it works? It should work but I can't test it myself because
> my box with GICv3 died recently…

I've tried this and do not see warnings. I'm sending 4.14-rt patches i have as
I could miss smth while cherry-picking.

-- 
regards,
-grygorii
