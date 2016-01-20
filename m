From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rt2 PATCH] ARM: highmem: take into account FIX_KMAP_BEGIN in
 switch_kmaps()
Date: Wed, 20 Jan 2016 22:35:21 +0200
Message-ID: <569FEF89.1020806@ti.com>
References: <1452867647-1410-1-git-send-email-grygorii.strashko@ti.com>
 <20160120202139.GC2741@linutronix.de>
 <20160120202317.GV19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sekhar Nori <nsekhar@ti.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120202317.GV19062@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/20/2016 10:23 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 20, 2016 at 09:21:39PM +0100, Sebastian Andrzej Siewior wrote:
>> * Grygorii Strashko | 2016-01-15 16:20:47 [+0200]:
>>
>>> --- a/arch/arm/mm/highmem.c
>>> +++ b/arch/arm/mm/highmem.c
>>> @@ -175,7 +180,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
>>> 	 * Restore @next_p's kmap_atomic mappings
>>> 	 */
>>> 	for (i = 0; i < next_p->kmap_idx; i++) {
>>> -		int idx = i + KM_TYPE_NR * smp_processor_id();
>>> +		int idx = fixmap_idx(i);
>>>
>>> 		if (!pte_none(next_p->kmap_pte[i]))
>>> 			set_fixmap_pte(idx, next_p->kmap_pte[i]);
>>
>> Grygorii, if you remove this chunk then it should apply upstream. Could
>> you forward it upstream then please? So the -RT piece would shrink a
>> little:)
>
> Or I could commit my own patch which forms a proportion of this change.
>

np from my side.

-- 
regards,
-grygorii
