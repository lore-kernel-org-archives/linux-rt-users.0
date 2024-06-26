Received: from 189.cn (ptr.189.cn [183.61.185.103])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78571BDDC;
	Wed, 26 Jun 2024 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367959; cv=none; b=RJzEvxSYbRnMuTUwdAY3wDEWATqIRtan2hFAgf55lr+cyMlxtfIqJ4fk13Qm1ubNkgebWw95AMgM/9/8J+qN8snnCMZky94LckGONcG5F3/l4/ALL8uz/FvbzWtI4Px9bVveuUnWwnlDRaPfuVYIv8PObtow5zPSAzzxjADoeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367959; c=relaxed/simple;
	bh=e4QFTGi5pZwW2lecV6JeURUEODVDInMGNe9DC9o4JVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dw2Cu8ov2YA8FqzIVXmPGJSUZmOpgsE2FJRLrzSYUbDPab2IxciXKkhSDPYeGunYS6cG3sxN5lSyAUGTcn9TEKt0khy6KSxZoNxFATwF03+ROBWf92XO1mvfTzCWGZcBwXF21TpRuwEfL5ZoBbA/ayatjcm2p8z2a65867J1Nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.64.8.41:46870.1853861281
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.156.73.12 (unknown [10.64.8.41])
	by 189.cn (HERMES) with SMTP id D473E10035E;
	Wed, 26 Jun 2024 10:12:26 +0800 (CST)
Received: from  ([39.156.73.12])
	by gateway-153622-dep-9dc64869d-vfmk8 with ESMTP id 68cd80dd48e64dcea4a725051b815393 for ahalaney@redhat.com;
	Wed, 26 Jun 2024 10:12:27 CST
X-Transaction-ID: 68cd80dd48e64dcea4a725051b815393
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 39.156.73.12
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
Date: Wed, 26 Jun 2024 10:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a question about how to debug this case in ftrace
From: Song Chen <chensong_2000@189.cn>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, john.ogness@linutronix.de, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
Content-Language: en-US
In-Reply-To: <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

ohh, by the way, i'm curious why softlockup/hardlockup/hungtask don't 
have ftrace dump as well as rcu stall, or is it possible to add a 
parameter in cmdline to redirect softlockup/hardlockup/hungtask/rcustall 
warning either to ftrace or printk.

Just a thought.

BR

Song

在 2024/6/26 10:06, Song Chen 写道:
> Hi Andrew,
> 
> If I understood it correctly, it's similar with rcu 
> stall(rcu_cpu_stall_ftrace_dump).
> 
> So far I don't need too much detail in vmcore, so only merging dmesg and 
> ftrace is more practical to my case. I will give it a try, many thanks.
> 
> BR
> 
> Song
> 
> 在 2024/6/25 21:20, Andrew Halaney 写道:
>> Hey Song,
>>
>> I'll answer that bit as those were my hacks :P
>>
>> I _thought_ that doing a ftrace_dump_on_oops + softlockup_panic on the
>> command line (or similar at runtime) would dump the logs, but that
>> wasn't working for me and I was in a bit of a rush (and already hacking
>> the kernel up anyways).
>>
>> So I ended up doing a sequence like:
>>
>>      tracing_off();
>>      ftrace_dump(DUMP_ALL);
>>
>> in the softlockup code when it was detected. Ideally I wanted to look at
>> the vmcore and look at the ftrace data in there (since debugging printk
>> by using printk is a little confusing), but there was a makedumpfile bug
>> I hit... so I went with the hacky route to prove to myself what was
>> going on. I think since then that's been resolved. Hope that helps!
>>
>> Thanks,
>> Andrew
>>
>> On Tue, Jun 25, 2024 at 09:36:54AM GMT, Song Chen wrote:
>>> Hi Derek,
>>>
>>> I am working on a hungtask case, i saw your trace_printk logs go to 
>>> the same
>>> output with softlockup warning, It's a smart way to easily build a 
>>> timeline
>>> for analysis.
>>>
>>> As far as i know, trace_printk goes to ftrace ring buffer and softlockup
>>> info goes to dmesg. Could you please let me know how you did that, i 
>>> marked
>>> the part i'm interested in below, thanks a lot.
>>>
>>> BR
>>>
>>> Song
>>>
>>>
>>> 在 2024/6/18 23:20, Derek Barbosa 写道:
>>>> lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
>>>> Bcc:
>>>> Subject: watchdog BUG: soft lockup - CPU#x stuck for 78s
>>>> Reply-To:
>>>>
>>>> Hi,
>>>>
>>>> The realtime team at Red Hat has recently backported the latest 
>>>> printk changes
>>>> present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon: move 
>>>> locked_port flag to
>>>> struct uart_port) to CentOS Stream 9 for performance improvements and
>>>> printk-related bugfixes.
>>>>
>>>> Since merging this said code, we've hit an interesting bug during 
>>>> testing,
>>>> specifically, on larger systems, a softlockup may be reported by the 
>>>> watchdog
>>>> when there is a heavy amount of printing to tty devices (whether it 
>>>> be through
>>>> printk, /dev/kmsg, etc).
>>>>
>>>> We have a modicum of reasonable suspicion to believe that 
>>>> nbcon_reacquire, or
>>>> some other nbcon mechanism *may* be causing such behavior.
>>>>
>>>> Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
>>>> (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this 
>>>> bug
>>>> upstream.
>>>>
>>>> Anyway, here is a more in-depth description, along with some call 
>>>> traces.
>>>>
>>>> Description:
>>>>
>>>> On x86 systems with a large amount of logical cores (nproc ~> 60), a 
>>>> softlockup can
>>>> be observed with accompanying call trace when a large amount of 
>>>> "printing"
>>>> activity is taking place.
>>>>
>>>> As shown in the call traces appended below, during some kind of numa
>>>> balancing/numa_migration after a task_numa_fault --where a set of 
>>>> processess are being migrated/swapped
>>>> between two CPUs-- there is a busy thread that is being waited on 
>>>> (in the order
>>>> of seconds), causing a livelock. Additional investigation of 
>>>> collected vmcores
>>>> by toggling panic on softlockup shows that the waiting thread may be 
>>>> waiting for
>>>> a thread looping with nbcon_reacquire.
>>>>
>>>> I suspect that some logic within nbcon_context_try_acquire may be a 
>>>> good place
>>>> to start. My understanding of the code becomes a bit fuzzy here, so 
>>>> apologies
>>>> in advance for any erroneous statements. As I see it, there may be 
>>>> something
>>>> happening during migration (or under heavy load) in which 
>>>> nbcon_reacquire() is in
>>>> a non-migratable or non-preemtible state as it is attempting to 
>>>> regain access to
>>>> a lost/taken console. It could very well be a situation in which 
>>>> context
>>>> was forcefully taken from the printing thread.
>>>>
>>>> Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it 
>>>> is the loop within
>>>> nbcon_kthread_func() -- since there is nothing that would yield the 
>>>> task in said
>>>> loop (cant_migrate()), the migrate code would be essentially waiting 
>>>> forever for
>>>> the aforementioned loop to "finish". I believe in PREEMPT_RT, there 
>>>> would be a
>>>> preemption point here. Furthermore, in his investigation, there were 
>>>> signs that the
>>>> loop was just iterating up until the crash, leaving reason to
>>>> believe that task would be the culprit.
>>>>
>>>> In fact, with the following diff, we noticed this output:
>>>>
>>>> ```
>>>> ahalaney@x1gen2nano ~/git/linux-rt-devel 
>>>> (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
>>>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>>>> index bb9689f94d30..d716b72bf2f8 100644
>>>> --- a/kernel/printk/nbcon.c
>>>> +++ b/kernel/printk/nbcon.c
>>>> @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
>>>>         *
>>>>         * This pairs with rcuwait_has_sleeper:A and 
>>>> nbcon_kthread_wake:A
>>>
>>
>>
> 
> 
