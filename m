From: Joel Fernandes <joelaf@lab126.com>
Subject: Re: [RFC] high preempt off latency in vfree path
Date: Wed, 23 Mar 2016 12:03:49 -0700
Message-ID: <56F2E895.7080003@lab126.com>
References: <56F1F4A6.2060400@lab126.com>
 <20160323024402.GA27856@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <linux-rt-users@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
To: Andi Kleen <ak@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160323024402.GA27856@tassilo.jf.intel.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On 03/22/16 19:44, Andi Kleen wrote:
>> (1)
>> One is we reduce the number of lazy_max_pages (right now its around 32MB per core worth of pages).
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index aa3891e..2720f4f 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -564,7 +564,7 @@ static unsigned long lazy_max_pages(void)
>>
>>          log = fls(num_online_cpus());
>>
>> -       return log * (32UL * 1024 * 1024 / PAGE_SIZE);
>> +       return log * (8UL * 1024 * 1024 / PAGE_SIZE);
>>   }
>
> This seems like the right fix to me.  Perhaps even make it somewhat smaller.
>
> Even on larger systems it's probably fine because they have a lot more
> cores/threads these days, so it will be still sufficiently large.
>

Thanks Andi. I'll post a patch then.

Regards,
Joel

> -Andi
>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
