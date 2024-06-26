Received: from 189.cn (ptr.189.cn [183.61.185.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288421643A;
	Wed, 26 Jun 2024 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367603; cv=none; b=LcoLfZfSGHkCh0IqXwVPYFhBYmsYjeTJeY50ksMh4KcpoNV6wIAxKWacva0b5QOywmnmUHJeC46nWoMWVAEKUi+9+WIEEkLKfZ7rxgZLMmKMsmDVDxZsdM3ibjB8slUYsLBNqksZjUpYGQczIXckrYRYy4GNuvWyOQFvHV58ERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367603; c=relaxed/simple;
	bh=fhz8xiUUjRzh8Qn6H4+WNYIxdLrQb9lP8qzAAVl7rHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf0OafkhTPyUeUi2ZexvHvpsGriCY0iOv6FseFxP1EI8vxxc7eB2ofhCU9C2AuwacCsDNxDZ/COrVMVi+DUP2VG/mrGONOzAJ3P7mvQcz3uOfE90TyX2RolPckjjYSfqI994j5k16sZvbYoFTIJV/mDCRsdRpJ4h70D6tf2x/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.64.8.31:52270.1396980873
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.156.73.12 (unknown [10.64.8.31])
	by 189.cn (HERMES) with SMTP id 3C0FA10048C;
	Wed, 26 Jun 2024 10:06:34 +0800 (CST)
Received: from  ([39.156.73.12])
	by gateway-153622-dep-9dc64869d-f88ns with ESMTP id 2a537ca05e99441e817d0c22ebee2fac for ahalaney@redhat.com;
	Wed, 26 Jun 2024 10:06:36 CST
X-Transaction-ID: 2a537ca05e99441e817d0c22ebee2fac
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 39.156.73.12
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
Date: Wed, 26 Jun 2024 10:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a question about how to debug this case in ftrace
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, john.ogness@linutronix.de, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

If I understood it correctly, it's similar with rcu 
stall(rcu_cpu_stall_ftrace_dump).

So far I don't need too much detail in vmcore, so only merging dmesg and 
ftrace is more practical to my case. I will give it a try, many thanks.

BR

Song

在 2024/6/25 21:20, Andrew Halaney 写道:
> Hey Song,
> 
> I'll answer that bit as those were my hacks :P
> 
> I _thought_ that doing a ftrace_dump_on_oops + softlockup_panic on the
> command line (or similar at runtime) would dump the logs, but that
> wasn't working for me and I was in a bit of a rush (and already hacking
> the kernel up anyways).
> 
> So I ended up doing a sequence like:
> 
>      tracing_off();
>      ftrace_dump(DUMP_ALL);
> 
> in the softlockup code when it was detected. Ideally I wanted to look at
> the vmcore and look at the ftrace data in there (since debugging printk
> by using printk is a little confusing), but there was a makedumpfile bug
> I hit... so I went with the hacky route to prove to myself what was
> going on. I think since then that's been resolved. Hope that helps!
> 
> Thanks,
> Andrew
> 
> On Tue, Jun 25, 2024 at 09:36:54AM GMT, Song Chen wrote:
>> Hi Derek,
>>
>> I am working on a hungtask case, i saw your trace_printk logs go to the same
>> output with softlockup warning, It's a smart way to easily build a timeline
>> for analysis.
>>
>> As far as i know, trace_printk goes to ftrace ring buffer and softlockup
>> info goes to dmesg. Could you please let me know how you did that, i marked
>> the part i'm interested in below, thanks a lot.
>>
>> BR
>>
>> Song
>>
>>
>> 在 2024/6/18 23:20, Derek Barbosa 写道:
>>> lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
>>> Bcc:
>>> Subject: watchdog BUG: soft lockup - CPU#x stuck for 78s
>>> Reply-To:
>>>
>>> Hi,
>>>
>>> The realtime team at Red Hat has recently backported the latest printk changes
>>> present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon: move locked_port flag to
>>> struct uart_port) to CentOS Stream 9 for performance improvements and
>>> printk-related bugfixes.
>>>
>>> Since merging this said code, we've hit an interesting bug during testing,
>>> specifically, on larger systems, a softlockup may be reported by the watchdog
>>> when there is a heavy amount of printing to tty devices (whether it be through
>>> printk, /dev/kmsg, etc).
>>>
>>> We have a modicum of reasonable suspicion to believe that nbcon_reacquire, or
>>> some other nbcon mechanism *may* be causing such behavior.
>>>
>>> Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
>>> (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this bug
>>> upstream.
>>>
>>> Anyway, here is a more in-depth description, along with some call traces.
>>>
>>> Description:
>>>
>>> On x86 systems with a large amount of logical cores (nproc ~> 60), a softlockup can
>>> be observed with accompanying call trace when a large amount of "printing"
>>> activity is taking place.
>>>
>>> As shown in the call traces appended below, during some kind of numa
>>> balancing/numa_migration after a task_numa_fault --where a set of processess are being migrated/swapped
>>> between two CPUs-- there is a busy thread that is being waited on (in the order
>>> of seconds), causing a livelock. Additional investigation of collected vmcores
>>> by toggling panic on softlockup shows that the waiting thread may be waiting for
>>> a thread looping with nbcon_reacquire.
>>>
>>> I suspect that some logic within nbcon_context_try_acquire may be a good place
>>> to start. My understanding of the code becomes a bit fuzzy here, so apologies
>>> in advance for any erroneous statements. As I see it, there may be something
>>> happening during migration (or under heavy load) in which nbcon_reacquire() is in
>>> a non-migratable or non-preemtible state as it is attempting to regain access to
>>> a lost/taken console. It could very well be a situation in which context
>>> was forcefully taken from the printing thread.
>>>
>>> Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it is the loop within
>>> nbcon_kthread_func() -- since there is nothing that would yield the task in said
>>> loop (cant_migrate()), the migrate code would be essentially waiting forever for
>>> the aforementioned loop to "finish". I believe in PREEMPT_RT, there would be a
>>> preemption point here. Furthermore, in his investigation, there were signs that the
>>> loop was just iterating up until the crash, leaving reason to
>>> believe that task would be the culprit.
>>>
>>> In fact, with the following diff, we noticed this output:
>>>
>>> ```
>>> ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
>>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>>> index bb9689f94d30..d716b72bf2f8 100644
>>> --- a/kernel/printk/nbcon.c
>>> +++ b/kernel/printk/nbcon.c
>>> @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
>>>         *
>>>         * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A
>>
> 
> 
