From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Mon, 1 Feb 2016 14:04:48 +0100
Message-ID: <56AF57F0.80300@linutronix.de>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de> <56A2196E.1020101@ti.com>
 <56A22693.4020304@linutronix.de> <20160122204018.GA3883@linutronix.de>
 <56A657DD.8080602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A657DD.8080602@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/25/2016 06:14 PM, Grygorii Strashko wrote:

>> diff --git a/arch/arm/kernel/entry-common.S
>> b/arch/arm/kernel/entry-common.S
>> index 30a7228eaceb..c3bd6cbfce4b 100644
>> --- a/arch/arm/kernel/entry-common.S
>> +++ b/arch/arm/kernel/entry-common.S
>> @@ -36,7 +36,9 @@
>>    UNWIND(.cantunwind    )
>>       disable_irq_notrace            @ disable interrupts
>>       ldr    r1, [tsk, #TI_FLAGS]        @ re-check for syscall tracing
>> -    tst    r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
>> +    tst    r1, #((_TIF_SYSCALL_WORK | _TIF_WORK_MASK) & ~_TIF_SECCOMP)
>> +    bne    fast_work_pending
>         ^^^^^^^^^^^^^^^^
> 
>> +    tst    r1, #_TIF_SECCOMP
>>       bne    fast_work_pending
>         ^^^^^^^^^^^^^^^^^
> 
> Should it be "fast_work_pending" in both cases?

Yes, I think so and it is, isn't it?
The original is

     tst    r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
     bne    fast_work_pending

and with the LAZY bits in it, the ASM opcode no longer works because
the constant is too large (or has to many bits set). So I removed the
_TIF_SECCOMP bit out of the mask and made two compare & jumps here.

Sebastian
