Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844C322C6C
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416132; cv=none; b=T+T4zWTrJmE3gqiTy+AptBNDYtjDKVcbtt765Q7iP33SmSMqzMVK46FLNocDzR2MUTHb1VAbwzdOzuFXjAp9mgMakWrHYG/Qy3bk6hr1Bcg2Et7YD+6/VX8Q7GYWBoASUkKn13znytXqX2tixdGUBsQaJd6BuXq5w+Zh0EczY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416132; c=relaxed/simple;
	bh=nhIecU59x38KNeQT2MswMC7bKEvDevUDXNj72m4Fp9U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZzF+JPU9RMVBF3MUuf/MVcM3pg5szvUbtExq+t+AYxFgvIw1Yk1/gQFvuTJXn15Mpw4PJXr9m4a/+IXyACRkvEq0Lz3ESf6E6cuN28GJPEQyAUfYyZEluwE5m3Hp3xIqansyP7r10+Nad+RCg9Ni0ujlW1WuGhzUChq8g+gkDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=e8d0JeM3; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="e8d0JeM3"
Received: from [IPV6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95] (unknown [IPv6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id C6F3E2003D3;
	Tue,  9 Sep 2025 13:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757416127;
	bh=nhIecU59x38KNeQT2MswMC7bKEvDevUDXNj72m4Fp9U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=e8d0JeM3IFJpWfYyh+BgzAAonxU+J7kjwfxhl3VtuCnWCyr59kDq3Jgtn4NdS5mCM
	 Fk4ec4ssiK61cQscJcWgjvy9GvuwMESDYYzI/wtXsyWpIzVeyL6PY3eiahUiebA8GC
	 sF4yifSX5gAUona7segD8T+EjbOoDiKS+qeCTVcfeSjmNn86KzL2KxmuidXWiZ8Hj0
	 vEMbr99NB22nuFn/ql5+HSCG5PrlWAjxpIlRXT2mOQ3SPOA1wc9QSXDC7AbRHM77i9
	 n3lXv95+ElEUfoZPduIJ6oPiwblOU/dCx7/1gQGFzv+8fSwEVhAXOFyMqoWx7HG0Uh
	 GkICNy1wlhHGw==
Message-ID: <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
Date: Tue, 9 Sep 2025 13:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: linux-rt-users@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
Content-Language: en-US
In-Reply-To: <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 20:40, Marc Gonzalez wrote:

> On 08/09/2025 18:02, Daniel Wagner wrote:
> 
>> On Mon, Sep 08, 2025 at 05:42:58PM +0200, Marc Gonzalez wrote:
>>
>>> I've run out of ideas to identify other sources of variance.
>>> (I ran everything in single user mode with nothing else running.)
>>> Perhaps with perf I could identify the source of stalls or bubbles?
>>>
>>> Hoping someone can point me in the right direction.
>>
>> There are few guides out there, explaining the common pitfalls. I
>> suppose you have already found them. Just in case you missed Frederic's
>> excellent blog on CPU isolation:
>>
>> https://www.suse.com/c/cpu-isolation-introduction-part-1/
> 
> Thanks for this great link!
> 
> Is nohz_full=X a superset of isolcpus=X or are they orthogonal?

I am now more confused than ever.

Following Frederic's guide:
https://www.suse.com/c/cpu-isolation-practical-example-part-5/

If I didn't mess up, CPU3 is now supposed to be fully isolated
on my 4-core system:

$ sudo dmesg | grep "Kernel command line"
[    0.038445] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.8.0-79-generic root=UUID=2aff6d63-a8c6-4ebb-af69-9d2df2852cb0 ro log_buf_len=16M nohz_full=3 isolcpus=3 quiet splash vt.handoff=7

I ran echo "0-2" > $IRQ/smp_affinity_list for every IRQ.

IRQ=0   AFTER SMP_AFF=0-3 EFF_AFF=0
IRQ=1   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=2   AFTER SMP_AFF=0-3 EFF_AFF=
IRQ=3   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=4   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=5   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=6   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=7   AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=8   AFTER SMP_AFF=0-2 EFF_AFF=0
IRQ=9   AFTER SMP_AFF=0-2 EFF_AFF=1
IRQ=10  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=11  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=12  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=13  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=14  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=15  AFTER SMP_AFF=0-2 EFF_AFF=0-2
IRQ=16  AFTER SMP_AFF=0-2 EFF_AFF=1
IRQ=18  AFTER SMP_AFF=0-2 EFF_AFF=1
IRQ=23  AFTER SMP_AFF=0-2 EFF_AFF=2
IRQ=24  AFTER SMP_AFF=0-2 EFF_AFF=2
IRQ=25  AFTER SMP_AFF=0-2 EFF_AFF=3
IRQ=26  AFTER SMP_AFF=0-2 EFF_AFF=0
IRQ=27  AFTER SMP_AFF=0-2 EFF_AFF=0
IRQ=28  AFTER SMP_AFF=0-2 EFF_AFF=2
IRQ=29  AFTER SMP_AFF=0-2 EFF_AFF=2
IRQ=30  AFTER SMP_AFF=0-2 EFF_AFF=3
IRQ=31  AFTER SMP_AFF=0-2 EFF_AFF=0
IRQ=32  AFTER SMP_AFF=0-2 EFF_AFF=1

I note that IRQs 25 & 30 are still effectively pinned to CPU3,
despite the smp_aff setting.

$ cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:         27          0          0          0   IO-APIC   2-edge      timer
  8:          0          0          0          0   IO-APIC   8-edge      rtc0
  9:          0          4          0          0   IO-APIC   9-fasteoi   acpi
 16:          0         25          0          0   IO-APIC  16-fasteoi   ehci_hcd:usb1
 18:          0          5          0          0   IO-APIC  18-fasteoi   i801_smbus
 23:          0          0         29          0   IO-APIC  23-fasteoi   ehci_hcd:usb2
 24:          0          0          0          0  PCI-MSI-0000:00:1c.0   0-edge      PCIe PME, pciehp
 25:          0          0          0          0  PCI-MSI-0000:00:1c.3   0-edge      PCIe PME
 26:      23328          0          0      37250  PCI-MSI-0000:00:1f.2   0-edge      ahci[0000:00:1f.2]
 27:      86091          0          0          0  PCI-MSI-0000:00:14.0   0-edge      xhci_hcd
 28:          0          0      51308          0  PCI-MSIX-0000:02:00.0  0-edge      enp2s0
 29:          0          0         22          0  PCI-MSI-0000:00:16.0   0-edge      mei_me
 30:          0          0          0        604  PCI-MSI-0000:00:1b.0   0-edge      snd_hda_intel:card0
 31:     198664          0          0          0  PCI-MSI-0000:00:02.0   0-edge      i915
 32:          0        631          0          0  PCI-MSI-0000:00:03.0   0-edge      snd_hda_intel:card1


My benchmark is a trivial piece of code:
- no system calls, no library calls
- just simple bit twiddling
- tiny code, tiny data structures, everything fits in L1
$ size a.out
   text	   data	    bss	    dec	    hex	filename
   8549	    632	   1072	  10253	   280d	a.out

Undisturbed, it runs in 2500 nanoseconds
(with all cores set to tick at 3 GHz).

I run it 2^16 times, so the expected run-time is
2500*2^16 = 163840000 ns = 163.84 ms

Yet, I've observed AVERAGE run-times of
2600, 2700, and even 2800 (!!) nanoseconds.

I captured a full trace of this occurrence with
echo *:* > $TRACING/set_event
cat $TRACING/per_cpu/cpu$CPU/trace > trace.$CPU

# tracer: nop
#
# entries-in-buffer/entries-written: 9743/9743   #P:4
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [003] dN.1.  4606.627286: cpu_idle: state=4294967295 cpu_id=3
          <idle>-0       [003] dN.1.  4606.627288: rcu_utilization: Start context switch
          <idle>-0       [003] dN.1.  4606.627288: rcu_utilization: End context switch
          <idle>-0       [003] d..2.  4606.627290: sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=taskset next_pid=8129 next_prio=0
          <idle>-0       [003] d..2.  4606.627291: tlb_flush: pages:-1 reason:flush on task switch (0)
           a.out-8129    [003] ...1.  4606.627304: mm_page_free: page=000000001fef04a8 pfn=0x16a586 order=1
           ...
           a.out-8129    [003] d....  4606.628019: user_enter: 
           a.out-8129    [003] d....  4606.811832: user_exit: 


Program starts at 4606.627304
Program setup lasts until 4606.628019 (~1500 recorded events)
=> roughly 700 microseconds spent before main()
which I'm not taking into account in my measurements.

Then program ends at 4606.811832
=> 183.813 ms instead of the expected 163.84 ms

Almost exactly 20 ms in excess.
Could this be a hint?
But there is absolutely NOTHING traced between 4606.628019 & 4606.811832.

I guess either my time source is incorrect.
(Next slide in Frederic's guide)
OR there is something wonky going on inside CPU3.

Looks like IRQs are not the issue here?
No need to investigate why I can't pin IRQs 25 & 30
elsewhere than CPU3?

Regards

