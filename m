From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.14-rt][report] arm: just another rcu_note_context_switch
Date: Fri, 16 Feb 2018 12:26:36 -0600
Message-ID: <1399f473-b743-8030-bf3e-9835596522e7@ti.com>
References: <6f2e005d-26c1-19ca-283a-5f5e441e2f80@ti.com>
 <20180216113045.4zzay3oluuc2altu@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216113045.4zzay3oluuc2altu@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 02/16/2018 05:30 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-14 16:12:42 [-0600], Grygorii Strashko wrote:
>> Hi All,
> Hi,
> 
>> I can see below warning during boot on few TI boards am437x-idk, am335x-evm, am335x-ice
>> All of them are non-SMP
> 
> I somehow missed the !SMP kernel… What about this:
> 
> Subject: [PATCH] RCU: skip the "schedule() in RCU section" warning on UP, too
> 
> In "RCU: we need to skip that warning but only on sleeping locks" we
> skipped a warning on SMP systems in case we schedule out in a RCU
> section while attempt to obtain a sleeping lock. This is also required
> on UP systems.
> In order to do so, I introduce a tiny version of migrate_disable() +
> _enable() which only update the counters which we then can check against
> on RT && !SMP.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Thanks. I do not see errors any more.
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>



-- 
regards,
-grygorii
