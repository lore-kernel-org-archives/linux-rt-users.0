From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: 3.8.4-rt2 panic in migrate_task_rq_fair
Date: Mon, 29 Apr 2013 16:00:11 -0700
Message-ID: <517EFB7B.9030303@linux.intel.com>
References: <515F000D.9090500@linux.intel.com> <20130426132142.GF20927@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5662 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab3D2XAM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 19:00:12 -0400
In-Reply-To: <20130426132142.GF20927@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 04/26/2013 06:21 AM, Sebastian Andrzej Siewior wrote:
> * Darren Hart | 2013-04-05 09:47:09 [-0700]:
> 
>> Running on a UEFI 32bit Atom E6xx system I see the following panic after
>> several minutes running the following cyclictest command.
> 
> Can you reproduce this?


Yes, it was perfectly repeatable.


>> root@sys940x:~# cyclictest -p 50 -d 10m -t -q
>> # /dev/cpu_dma_latency set to 0us
>>
>> BUG: unable to handle kernel paging request at fffffff4
>> IP: [<c106a41c>] migrate_task_rq_fair+0x4c/0x100
>> EIP is at migrate_task_rq_fair+0x4c/0x100
>> EAX: 00000000 EBX: deec43f0 ECX: 00000000 EDX: 00000000
>> ESI: dde8f948 EDI: c1983900 EBP: dee9fe58 ESP: dee9fe40
>> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> 
> This is the disassembly of your code:
> 
> |   0:   83 74 01 00 00          xorl   $0x0,0x0(%rcx,%rax,1)
> |   5:   74 48                   je     4f <crash+0x24>
> |   7:   8d 4e 58                lea    0x58(%rsi),%ecx
> |   a:   e8 94 2e 2c 00          callq  2c2ea3 <crash+0x2c2e78>
> |   f:   89 45 f0                mov    %eax,-0x10(%rbp)
> |  12:   89 55 f4                mov    %edx,-0xc(%rbp)
> |  15:   8b 8b 78 01 00 00       mov    0x178(%rbx),%ecx
> |  1b:   8b 93 74 01 00 00       mov    0x174(%rbx),%edx
> |  21:   29 55 f0                sub    %edx,-0x10(%rbp)
> |  24:   19 4d f4                sbb    %ecx,-0xc(%rbp)
> |  27:   31 c0                   xor    %eax,%eax
> |  29:   31 d2                   xor    %edx,%edx
> |
> |000000000000002b <crash>:
> |  2b:   8b 49 f4                mov    -0xc(%rcx),%ecx
> 
> So ecx is zero, -0xc gives xfffffff4. Okay, bad pointer crash.
> 
> |  2e:   0b 4d f0                or     -0x10(%rbp),%ecx
> |  31:   75 2c                   jne    5f <crash+0x34>
> |  33:   89 83 74 01 00 00       mov    %eax,0x174(%rbx)
> |  39:   89 93 78 01 00 00       mov    %edx,0x178(%rbx)
> 
> A few lines up (offset 0x21) rcx is used for u64 subtraction in
> __synchronize_entity_decay(), the C code:
> |        decays -= se->avg.decay_count;
> |         if (!decays)
> |                 return 0;
> 
> The result is saved in -0x10 & -0xc *rbp. Later it is loaded again from
> stack because atomic64 is not inlined and it needs to do the zero check.
> 
> So *I* think that the assembly here is wrong because line 0x2b should
> use rbp as the pointer as it is done in 0x2e. The two lines are are the
> zero check.
> My gcc creates here: 
> 
> |c105c835:       e8 da 3a 1d 00          call   c1230314 <atomic64_read_cx8>
> |c105c83a:       89 55 f4                mov    %edx,-0xc(%ebp)
> |c105c83d:       8b 93 9c 00 00 00       mov    0x9c(%ebx),%edx
> |c105c843:       89 45 f0                mov    %eax,-0x10(%ebp)
> |c105c846:       8b 8b a0 00 00 00       mov    0xa0(%ebx),%ecx
> |c105c84c:       29 55 f0                sub    %edx,-0x10(%ebp)
> |c105c84f:       19 4d f4                sbb    %ecx,-0xc(%ebp)
> |c105c852:       31 c0                   xor    %eax,%eax
> |c105c854:       31 d2                   xor    %edx,%edx
> crash:
> |c105c856:       8b 4d f4                mov    -0xc(%ebp),%ecx
> 
> as you see, it uses ebp instead of rcx for the 0 check.
> 
> |c105c859:       0b 4d f0                or     -0x10(%ebp),%ecx
> |c105c85c:       75 2a                   jne    c105c888 <migrate_task_rq_fair+0x78>
> 
> The assembly code looks wrong to me. So it is either a gcc bug or the
> attributes for the inline assembly in atomic64_read() /
> alternative_atomic64() are wrong.


Something to look into, I will try to get back to this and compare a
couple of different compiler versions.

Thanks for looking into it!

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
