Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F813A3FC
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802622; cv=none; b=I7fP+Trlydg2rJXSNU2W1D6UAfxGPZxwaOzYzNaXTbM6lUbyX0iV3aCFZKD9LOWx1YtLSHBRB/vnAmvwLmEHFmdOOEH3xerpeMpH0LyyoGdXUuYj8XRn37Id8wkx+RVOpgH8xMk/bwTx+zBUMA57uRi00sqDKR9shgxxcuNTgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802622; c=relaxed/simple;
	bh=ca7qxTX4u6UzTeFhYW4NkFxCP0XwOUteCJo7P6ydaEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnQQtbx2Nfl3oHwjpEAG/ZdsMesz8jQunKoLBjIaL+lDA4c7lmjBR3+FRbFattYH0x7W6VUfepCJxmqBJ9JXjB47nMx8s3303v75y/+jYcVb+tjfjWmO5rrZOOLCsMZ1qihhJENFn3OXFabkYIc15FXhWsR2vTcKramVtJCaTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P0/R063B; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P0/R063B"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529646df247so2963503e87.3
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716802617; x=1717407417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/ixPzkRCck5ZUKxx74gVuIQcS7/KCEVfrXzpOu54PQ=;
        b=P0/R063Bgh8BsH8SNa6+rs36Zb1kMEof/Yc0G5AAUt0yFyewwUf1VgJw8I/kvNV6VO
         xIztpzoTlXe6tsmRXONhnsrEfAG6crTv3WYkVGxTrxGHd8Kq+/EQDoGKcm+DGIQGaiBO
         yJ3WK5j8rjrrsOGXMGStHIdXYegB7+iibzBd6pTIROqY2zBAnmsXgfinBYBlD8fYfCzQ
         QBdk0wXhaADo5BFEsDq5si78RRXrmeUyQpKTjbeOCayXaOnSKVgPeSUfQwe73v85r5NF
         wyOSVdcI651j3kUt5eeEK3enBDDMaUvjUIArWzmgAyeCgvTSCCFB5V0MLVe1ZjjW3HRe
         aowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802617; x=1717407417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ixPzkRCck5ZUKxx74gVuIQcS7/KCEVfrXzpOu54PQ=;
        b=tbKLQvkZjoRp86sFHRBFEGw8X/FL2NIcDAMz9Vn6QzS3Taavchb3zjFQICx4OIaF0t
         5dod78bL2OjHAP7JUQnIX26Ctb9YKLk4cTnqVx+ulyzvwC9yBQCvEzLEkWhNDM0oShX6
         Y/L3AX2PRj8weQOUr5f0+boCM88xbewXvTEsa4amXxZJy473SKj2CpFJ4p/1zwS23coQ
         n+e95d5+i1/ytZTwKYWvowtCr/f6i/2ED5bP5gy2hQyVzRM12F82tZtr3bVzl9qtctvX
         EX+Ytsb1Hn76viW1q9pbTVTgDNdvTkjVpwXCZqHRrxEEPN0ALs7fyArm3nRMwtfZHH8+
         Ai3A==
X-Forwarded-Encrypted: i=1; AJvYcCWfbFuiW7dnWnivILvpyJuuSh+kPVOCx98/ddgkgTGPcNkRipAxS5pdLVaj8N5+/PEJ9mOQCVKd6c+CcCXydYXh6bDyl2o2QQK7+ngfmDk=
X-Gm-Message-State: AOJu0YwN+Zk/IZqY97Bdipbtdjp2LwZfDHXDFhWxYTQpZPRkvVdSLo9u
	nAZgUAoLzSUVrPzEwR2a1HUaNalV1UesJlmxb0u9lltNPpbN++OQjB8Zbh6oaKA=
X-Google-Smtp-Source: AGHT+IHEAjDHV04sv046OkrhZ6dT5pavox8wzKlyT3vi+iHB28XVQkbRU0voEZTDpoqyXyek79OCfA==
X-Received: by 2002:ac2:4e10:0:b0:51b:e0f0:e4f8 with SMTP id 2adb3069b0e04-52964bb0ea4mr7110372e87.31.1716802616696;
        Mon, 27 May 2024 02:36:56 -0700 (PDT)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad8e2sm136039195e9.33.2024.05.27.02.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 02:36:56 -0700 (PDT)
Message-ID: <2b920bab-23a2-4a8d-95c2-b69472d38373@suse.com>
Date: Mon, 27 May 2024 11:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ring-buffer: Fix a race between readers and resize
 checks
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20240517134008.24529-1-petr.pavlu@suse.com>
 <20240517134008.24529-3-petr.pavlu@suse.com>
 <20240520095037.33a7fde6@gandalf.local.home>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240520095037.33a7fde6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 15:50, Steven Rostedt wrote:
> On Fri, 17 May 2024 15:40:08 +0200
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> The reader code in rb_get_reader_page() swaps a new reader page into the
>> ring buffer by doing cmpxchg on old->list.prev->next to point it to the
>> new page. Following that, if the operation is successful,
>> old->list.next->prev gets updated too. This means the underlying
>> doubly-linked list is temporarily inconsistent, page->prev->next or
>> page->next->prev might not be equal back to page for some page in the
>> ring buffer.
>>
>> The resize operation in ring_buffer_resize() can be invoked in parallel.
>> It calls rb_check_pages() which can detect the described inconsistency
>> and stop further tracing:
>>
>> [  190.271762] ------------[ cut here ]------------
>> [  190.271771] WARNING: CPU: 1 PID: 6186 at kernel/trace/ring_buffer.c:1467 rb_check_pages.isra.0+0x6a/0xa0
>> [  190.271789] Modules linked in: [...]
>> [  190.271991] Unloaded tainted modules: intel_uncore_frequency(E):1 skx_edac(E):1
>> [  190.272002] CPU: 1 PID: 6186 Comm: cmd.sh Kdump: loaded Tainted: G            E      6.9.0-rc6-default #5 158d3e1e6d0b091c34c3b96bfd99a1c58306d79f
>> [  190.272011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
>> [  190.272015] RIP: 0010:rb_check_pages.isra.0+0x6a/0xa0
>> [  190.272023] Code: [...]
>> [  190.272028] RSP: 0018:ffff9c37463abb70 EFLAGS: 00010206
>> [  190.272034] RAX: ffff8eba04b6cb80 RBX: 0000000000000007 RCX: ffff8eba01f13d80
>> [  190.272038] RDX: ffff8eba01f130c0 RSI: ffff8eba04b6cd00 RDI: ffff8eba0004c700
>> [  190.272042] RBP: ffff8eba0004c700 R08: 0000000000010002 R09: 0000000000000000
>> [  190.272045] R10: 00000000ffff7f52 R11: ffff8eba7f600000 R12: ffff8eba0004c720
>> [  190.272049] R13: ffff8eba00223a00 R14: 0000000000000008 R15: ffff8eba067a8000
>> [  190.272053] FS:  00007f1bd64752c0(0000) GS:ffff8eba7f680000(0000) knlGS:0000000000000000
>> [  190.272057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  190.272061] CR2: 00007f1bd6662590 CR3: 000000010291e001 CR4: 0000000000370ef0
>> [  190.272070] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  190.272073] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  190.272077] Call Trace:
>> [  190.272098]  <TASK>
>> [  190.272189]  ring_buffer_resize+0x2ab/0x460
>> [  190.272199]  __tracing_resize_ring_buffer.part.0+0x23/0xa0
>> [  190.272206]  tracing_resize_ring_buffer+0x65/0x90
>> [  190.272216]  tracing_entries_write+0x74/0xc0
>> [  190.272225]  vfs_write+0xf5/0x420
>> [  190.272248]  ksys_write+0x67/0xe0
>> [  190.272256]  do_syscall_64+0x82/0x170
>> [  190.272363]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  190.272373] RIP: 0033:0x7f1bd657d263
>> [  190.272381] Code: [...]
>> [  190.272385] RSP: 002b:00007ffe72b643f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> [  190.272391] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1bd657d263
>> [  190.272395] RDX: 0000000000000002 RSI: 0000555a6eb538e0 RDI: 0000000000000001
>> [  190.272398] RBP: 0000555a6eb538e0 R08: 000000000000000a R09: 0000000000000000
>> [  190.272401] R10: 0000555a6eb55190 R11: 0000000000000246 R12: 00007f1bd6662500
>> [  190.272404] R13: 0000000000000002 R14: 00007f1bd6667c00 R15: 0000000000000002
>> [  190.272412]  </TASK>
>> [  190.272414] ---[ end trace 0000000000000000 ]---
>>
>> Note that ring_buffer_resize() calls rb_check_pages() only if the parent
>> trace_buffer has recording disabled. Recent commit d78ab792705c
>> ("tracing: Stop current tracer when resizing buffer") causes that it is
>> now always the case which makes it more likely to experience this issue.
>>
>> The window to hit this race is nonetheless very small. To help
>> reproducing it, one can add a delay loop in rb_get_reader_page():
>>
>>  ret = rb_head_page_replace(reader, cpu_buffer->reader_page);
>>  if (!ret)
>>  	goto spin;
>>  for (unsigned i = 0; i < 1U << 26; i++)  /* inserted delay loop */
>>  	__asm__ __volatile__ ("" : : : "memory");
>>  rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
>>
>> .. and then run the following commands on the target system:
>>
>>  echo 1 > /sys/kernel/tracing/events/sched/sched_switch/enable
>>  while true; do
>>  	echo 16 > /sys/kernel/tracing/buffer_size_kb; sleep 0.1
>>  	echo 8 > /sys/kernel/tracing/buffer_size_kb; sleep 0.1
>>  done &
>>  while true; do
>>  	for i in /sys/kernel/tracing/per_cpu/*; do
>>  		timeout 0.1 cat $i/trace_pipe; sleep 0.2
>>  	done
>>  done
>>
>> To fix the problem, make sure ring_buffer_resize() doesn't invoke
>> rb_check_pages() concurrently with a reader operating on the same
>> ring_buffer_per_cpu by taking its cpu_buffer->reader_lock.
> 
> Definitely a bug. Thanks for catching it. But...
> 
>>
>> Fixes: 659f451ff213 ("ring-buffer: Add integrity check at end of iter read")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  kernel/trace/ring_buffer.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index 0ae569eae55a..967655591719 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -1449,6 +1449,11 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>>   *
>>   * As a safety measure we check to make sure the data pages have not
>>   * been corrupted.
>> + *
>> + * Callers of this function need to guarantee that the list of pages doesn't get
>> + * modified during the check. In particular, if it's possible that the function
>> + * is invoked with concurrent readers which can swap in a new reader page then
>> + * the caller should take cpu_buffer->reader_lock.
>>   */
>>  static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>>  {
>> @@ -2200,8 +2205,13 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
>>  		 */
>>  		synchronize_rcu();
>>  		for_each_buffer_cpu(buffer, cpu) {
>> +			unsigned long flags;
>> +
>>  			cpu_buffer = buffer->buffers[cpu];
>> +			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>  			rb_check_pages(cpu_buffer);
>> +			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock,
>> +						   flags);
> 
> Putting my RT hat on, I really don't like the above fix. The
> rb_check_pages() iterates all subbuffers which makes the time interrupts
> are disabled non-deterministic.

I see, this applies also to the same rb_check_pages() validation invoked
from ring_buffer_read_finish().

> 
> Instead, I would rather have something where we disable readers while we do
> the check, and re-enable them.
> 
> 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> 			cpu_buffer->read_disabled++;
> 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> 
> // Also, don't put flags on a new line. We are allow to go 100 characters now.

Noted.

> 
> 
>   			rb_check_pages(cpu_buffer);
> 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> 			cpu_buffer->read_disabled--;
> 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> 
> Or something like that. Yes, that also requires creating a new
> "read_disabled" field in the ring_buffer_per_cpu code.

I think this would work but I'm personally not immediately sold on this
approach. If I understand the idea correctly, readers should then check
whether cpu_buffer->read_disabled is set and bail out with some error if
that is the case. The rb_check_pages() function is only a self-check
code and as such, I feel it doesn't justify disrupting readers with
a new error condition and adding more complex locking.

I've been considering how to approach this RT issue differently. One
obvious approach would be to drop the rb_check_pages() validation but
that is probably not desirable.

Another option could be to make the check less thorough and walk only
a part of the list which is bounded by some constant, typically one
would want to check the part where some change was just made. In case of
a smaller list, it should be still possible to traverse it completely.

This is an idea that I'm currently looking at.

> 
> That said, I'm going to accept these patches as is (moving flags onto the
> same line). But would like the above code for the next merge window as it
> would then not affect RT.
> 
> I'll accept these patches because it does fix the bug now.

Thanks,
Petr
