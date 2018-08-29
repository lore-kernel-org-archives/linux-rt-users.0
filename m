From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:974
Date: Wed, 29 Aug 2018 16:28:50 -0500
Message-ID: <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 08/29/2018 09:08 AM, Sebastian Andrzej Siewior wrote:
> On 2018-08-28 18:28:42 [-0500], Grygorii Strashko wrote:

[...]

>> [    0.912275] [<ffff0000082023cc>] alloc_pages_current+0xcc/0xe0
>> [    0.912287] [<ffff00000846bb00>] its_allocate_pending_table+0x60/0xa0
>> [    0.912295] [<ffff00000846e5d8>] its_cpu_init+0x2a0/0x380
>> [    0.912303] [<ffff00000846b484>] gic_cpu_init.part.6+0x15c/0x170
>> [    0.912311] [<ffff00000846b4ac>] gic_starting_cpu+0x14/0x20
> 
> This is fixed by
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Make-its_lock-a-raw_spin_lock_t.patch?h=linux-4.18.y-rt-patches
[1]
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Move-ITS-pend_page-allocation-int.patch?h=linux-4.18.y-rt-patches
[2]
> 
> in the v4.18 tree. The first patch was merged upstream. The second will
> be replaced by the patches Marc Zyngier proposed in
>    https://lkml.kernel.org/r/3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com
> 
> I plan to test + replace those for the next v4.18 release.

Thank you. Are there any plans to back port them for 4.14-rt?
Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.

-- 
regards,
-grygorii
