From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH 1/1] tracing/latency_hist Fix memory leak
Date: Fri, 14 Feb 2014 21:28:39 +0100
Message-ID: <52FE7C77.7020408@osadl.org>
References: <20140214172617.382025623@osadl.org> <20140214172751.776971499@osadl.org> <52FE75A9.6050305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51460 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbaBNU3G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 15:29:06 -0500
In-Reply-To: <52FE75A9.6050305@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/14/2014 08:59 PM, Sebastian Andrzej Siewior wrote:
> On 02/14/2014 06:26 PM, Carsten Emde wrote:
>> The index_ptr memory that is allocated when printout is started
>> currently is only returned when the printout is stopped
>> prematurely. It is not returned when the printout regularly
>> finishes. Fix this memory leak.
>>
>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>>
>> Index: linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
>> ===================================================================
>> --- linux-3.12.10-rt15-somedebug.orig/kernel/trace/latency_hist.c
>> +++ linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
>> @@ -313,6 +313,7 @@ static void *l_next(struct seq_file *m,
>>
>>   	if (++*pos >= MAX_ENTRY_NUM) {
>>   		atomic_inc(&my_hist->hist_mode);
>> +		kfree(p);
>>   		return NULL;
>>   	}
>>   	*index_ptr = *pos;
>
> Sure on that? If I look at seq_read() I see that there is that ->stop()
> is always called after ->start() / ->next() before returning to caller.
> Based on this I would say that this patach will introduce a double free
> of p.
Some of the farm systems enable different levels of run time debug 
features including kmemleak in two of them. These two machines regularly 
crashed with kmemleak alloc overflow, because the system detected so 
many memleaks that there was no more memory available to store all of 
them. Since the objects were so small, the leak was not measurable in 
terms of memory exhaustion. I then investigated the kmemleak objects, 
and they clearly pointed to the index_ptr memory. This was the only 
place I found, and kmemleak no longer complaint or crashed after 
inserting this kfree(). I then patched the other farm systems some time 
ago where it never never did any harm. I needed to find a solution to 
the kmemleak machines, since otherwise I wouldn't have a usable tool to 
search for other memleaks. But I know that I should have done better. So 
please drop this patch and wait, until I find some time to more 
carefully analyze the entire situation.

	-Carsten.
