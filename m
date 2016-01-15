From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Fri, 15 Jan 2016 13:35:33 +0200
Message-ID: <5698D985.2050608@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <20160112171556.GB31009@linutronix.de> <569637ED.1030304@ti.com>
 <5696B025.8020909@ti.com> <569800DD.7090102@ti.com>
 <20160114213048.GB19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sekhar Nori <nsekhar@ti.com>, <linux-rt-users@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60374 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbcAOLgS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:36:18 -0500
In-Reply-To: <20160114213048.GB19062@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Russell,

On 01/14/2016 11:30 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 14, 2016 at 10:11:09PM +0200, Grygorii Strashko wrote:
>> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
>> index deabc36..b9b4f9c 100644
>> --- a/arch/arm/mm/highmem.c
>> +++ b/arch/arm/mm/highmem.c
>> @@ -167,7 +167,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
>>           * Clear @prev's kmap_atomic mappings
>>           */
>>          for (i = 0; i < prev_p->kmap_idx; i++) {
>> -               int idx = i + KM_TYPE_NR * smp_processor_id();
>> +               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
>>   
>>                  set_fixmap_pte(idx, __pte(0));
>>          }
>> @@ -175,7 +175,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
>>           * Restore @next_p's kmap_atomic mappings
>>           */
>>          for (i = 0; i < next_p->kmap_idx; i++) {
>> -               int idx = i + KM_TYPE_NR * smp_processor_id();
>> +               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
>>   
>>                  if (!pte_none(next_p->kmap_pte[i]))
>>                          set_fixmap_pte(idx, next_p->kmap_pte[i]);
> 
> This looks like it introduces the 4th and 5th copies of the same
> calcuation, so can I suggest that we do this to prevent this kind
> of error?
> 
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index d02f8187b1cc..61f0d5941116 100644
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -34,6 +34,11 @@ static inline pte_t get_fixmap_pte(unsigned long vaddr)
>   	return *ptep;
>   }
>   
> +static unsigned int fixmap_idx(int type)
> +{
> +	return FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
> +}
> +


This looks very reasonable - I'll updated and re-send.
Would you agree if I'll add your Signed-off-by: in final patch?

Thanks for review.


[...]


-- 
regards,
-grygorii
