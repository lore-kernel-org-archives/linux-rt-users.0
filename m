From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Thu, 14 Jan 2016 22:11:09 +0200
Message-ID: <569800DD.7090102@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <20160112171556.GB31009@linutronix.de> <569637ED.1030304@ti.com>
 <5696B025.8020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5696B025.8020909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

On 01/13/2016 10:14 PM, Grygorii Strashko wrote:
> On 01/13/2016 01:41 PM, Grygorii Strashko wrote:
>> On 01/12/2016 07:15 PM, Sebastian Andrzej Siewior wrote:
>>> * Grygorii Strashko | 2015-12-28 20:00:09 [+0200]:
>>>
>>>
>>>> 3) Seems there are some problem with HIGHMEM :(. System crashes if I'm trying
>>>>      to run hackbench (see log 1). I can run hackbench only if HIGHMEM is disabled.
>>>>      I've also tried to disable CONFIG_CPU_SW_DOMAIN_PAN, CONFIG_ARM_PATCH_PHYS_VIRT,
>>>>      and CONFIG_CPUSETS, before disabling HIGHMEM.
>>>>      Sorry, I'll not able to investigate it further because of Christmas holidays here.
>>>
>>> I see. It seems not to trigger anything on x86.
>>
>> Yah. I saw other reports - it seems this issue is not triggered on ARM SMP also
>> (as per report from Tim Sander). Will try to dig deeper.
>>
> 
> I did more tests, but still don't know what is wrong.
> 1) vanilla 4.4 - no issue
> 2) 4.4-rt: CONFIG_PREEMPT_RT_BASE=n and CONFIG_PREEMPT_RT_FULL=n -- no issue
> 3) 4.4-rt: CONFIG_DEBUG_HIGHMEM=y -- issue is present log1
> 4) 4.4-rt: this is interesting ;)
> I can run hackbench few times without issues If I run hackbench with RT priority (log2)
> But I got crash immediately once I run it using non-RT priorities.


Seems I've found root cause of the issue - FIX_KMAP_BEGIN offset need to be taken into
account in switch_kmaps() and below diff fixes this issue for me.
What I'm not fully understand is why I'm the only one who hit this issue :(
New functionality was added by commit:
commit a5f4c561b3b19a9bc43a81da6382b0098ebbc1fb
    ARM: 8415/1: early fixmap support for earlycon

and it is enabled by default.

Luckiness :(

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index deabc36..b9b4f9c 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -167,7 +167,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
         * Clear @prev's kmap_atomic mappings
         */
        for (i = 0; i < prev_p->kmap_idx; i++) {
-               int idx = i + KM_TYPE_NR * smp_processor_id();
+               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
 
                set_fixmap_pte(idx, __pte(0));
        }
@@ -175,7 +175,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
         * Restore @next_p's kmap_atomic mappings
         */
        for (i = 0; i < next_p->kmap_idx; i++) {
-               int idx = i + KM_TYPE_NR * smp_processor_id();
+               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
 
                if (!pte_none(next_p->kmap_pte[i]))
                        set_fixmap_pte(idx, next_p->kmap_pte[i]);

-- 
regards,
-grygorii
