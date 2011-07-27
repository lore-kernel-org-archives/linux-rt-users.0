From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Wed, 27 Jul 2011 15:27:47 -0700
Message-ID: <4E3090E3.7000100@am.sony.com>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <4E3089BC.1080001@am.sony.com> <alpine.LFD.2.02.1107280004410.2660@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:38849
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1G0W2O (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jul 2011 18:28:14 -0400
In-Reply-To: <alpine.LFD.2.02.1107280004410.2660@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/27/11 15:05, Thomas Gleixner wrote:
> On Wed, 27 Jul 2011, Frank Rowand wrote:
> 
>> On 07/27/11 14:37, Thomas Gleixner wrote:
>>> Dear RT Folks,
>>>
>>> I'm pleased to announce the 3.0-rt4 release.
>>
>> ARM panda board, PREEMPT_RT_FULL
>>
>> -rt3 compiled OK.  -rt4 compile fails:
>>
>>
>> mm/init-mm.c:24: error: unknown field 'lock' specified in initializer
>> mm/init-mm.c:24: error: unknown field 'wait_lock' specified in initializer
>> mm/init-mm.c:24: error: incompatible types in initialization
>> mm/init-mm.c:24: error: unknown field 'save_state' specified in initializer
>> mm/init-mm.c:24: warning: excess elements in struct initializer
>> mm/init-mm.c:24: warning: (near initialization for 'init_mm.context.id_lock.raw_lock')
> 
> Bah, that's what I get for trying to vanish. Fix below.
> 
> --- linux-2.6.orig/arch/arm/include/asm/mmu.h
> +++ linux-2.6/arch/arm/include/asm/mmu.h
> @@ -16,7 +16,7 @@ typedef struct {
>  
>  /* init_mm.context.id_lock should be initialized. */
>  #define INIT_MM_CONTEXT(name)                                                 \
> -	.context.id_lock    = __SPIN_LOCK_UNLOCKED(name.context.id_lock),
> +	.context.id_lock    = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
>  #else
>  #define ASID(mm)	(0)
>  #endif

Thanks!

Compiles and boots.

-Frank

