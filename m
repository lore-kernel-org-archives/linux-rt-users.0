From: Emmanuel Deloget <emmanuel.deloget@efixo.com>
Subject: Re: How do I get rid of these "BUG: sleeping function called from
 ... kernel/rtmutex.c:707"?
Date: Tue, 24 May 2011 15:05:42 +0200
Message-ID: <4DDBAD26.2040708@efixo.com>
References: <4DD67AFD.2080709@efixo.com>
Reply-To: emmanuel.deloget@efixo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.19]:34230 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab1EXM5E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 May 2011 08:57:04 -0400
In-Reply-To: <4DD67AFD.2080709@efixo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello again,

Although I am unvoluntary disrupting the netiquete, I have to answer my 
own mail.

I've gone through multiple passes of investigation, and I have to temper 
my words a bit. Now, I'm no longer working to find a solution to this 
issue, as there is no obvious solution. Here is my analysis.

On 05/20/2011 04:30 PM, Emmanuel Deloget wrote:
> Hello,
>
> I hope this message will find its way to the linux-rt mailing list. I 
> subscribed but for reasons that are unknown to me I cannot receive 
> anything from this list (I contacted the owner to sort out the 
> problem). As I side note, for this very reason, I'll appreciate if you 
> CC me whenever you answer to this mail, otherwise I might miss it. 
> Thanks in advance.
>
> I am using 2.6.33.7-rt30 (platform in arm/mach-ixp4xx ; distro is 
> OpenWRT with 2.6.33.7 re-imported (it has been removed from OpenWRT)).
>
> When I up a network interface with ifconfig, I systematically get the 
> following error message in dmesg :
>
> [   64.205417] BUG: sleeping function called from invalid context at 
> kernel/rtmutex.c:707
> [   64.205453] pcnt: 0 0 in_atomic(): 0, irqs_disabled(): 128, pid: 
> 1047, name: ifconfig
> [   64.205472] Backtrace:
<snip>

irqs_disabled() is the problem here. The RT kernel rightfully warn me 
that I'm trying to sleep in a context where some interrupts are blocked.

> [   64.205689] [<c02de434>] (rt_spin_lock+0x0/0x64) from [<c0095908>] 
> (kmem_cache_alloc+0x40/0x15c)
> [   64.205711]  r4:c5bd1df0
> [   64.205866] [<c01c811c>] (dev_alloc_skb+0x0/0x44) from [<bf0d9a88>] 
> (do_dev_stop+0x11c/0x2e4 [ixp400_eth])
> [   64.205909] [<bf0d9a60>] (do_dev_stop+0xf4/0x2e4 [ixp400_eth]) from 
> [<bf0d9ba8>] (do_dev_stop+0x23c/0x2e4 [ixp400_eth])
<snip>

And the problem comes from the ixp400 ethernet driver (from intel ; 
GPLv2, as clearly stated in the different code files, although the 
module does not declare MODULE_LICENSE. I'm going to file a bug wrt 
this, if I can find an Intel representative.

The issue really lies in intel's driver architecture, which is not 
PREEMPT-RT friendly. The driver maintains a list of skb, and this list 
is used by an ISR. When maintenance tasks are run, the driver disable 
IRQs to avoid concurrency issues. But then, it allocates memory using 
dev_alloc_skb().

Since I'm not willing to modify intel's driver architecture, and I'm not 
willing to modify the PREMPT-RT patch (as I will not have enough cycles 
to test even the simplest change), my only solution is to let this 
problem as it is. Not only the ixp400_eth driver has not been coded with 
the RT patch in mind, but this BUG message does not prevent the system 
to work correctly.

Still, there is question for which I'd like to get an answer, and this 
question is directly related to the code of __might_sleep() in 
kernel/sched.c (when CONFIG_DEBUG_PREEMPT is defined):

/* 10115 */ void __might_sleep(char *file, int line, int preempt_offset)
/* 10116 */ {
/* 10117 */ #ifdef in_atomic
/* 10118 */     static unsigned long prev_jiffy;    /* ratelimiting */
/* 10119 */
/* 10120 */     if ((preempt_count_equals(preempt_offset) && 
!irqs_disabled()) ||
/* 10121 */         system_state != SYSTEM_RUNNING || oops_in_progress)
/* 10122 */         return;
/* 10123 */     if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
/* 10124 */         return;
/* 10125 */     prev_jiffy = jiffies;
/* 10126 */
/* 10127 */     printk(KERN_ERR
/* 10128 */         "BUG: sleeping function called from invalid context 
at %s:%d\n",
<...snip...>
/* 10139 */     dump_stack();
/* 10140 */ #endif
/* 10141 */ }
/* 10142 */ EXPORT_SYMBOL(__might_sleep);

(keep in mind that this is an OpenWRT version ; some patches (other than 
the prempt-rt patch) might have been applied on this file, and the line 
numbers might vary).

My question is related to line 10120, and more precisely to the 
!irqs_disabled() test. I understand that when IRQs are disabled, it's a 
good idea to never sleep. But then, not all IRQs are equal - some arise 
quite rarely, or might be OK with seeing themselves postponned. In other 
words, only a limited set of interrupts are important enough to justify 
such a behavior.

Wouldn't it be better to check for these interrupts instead of checking 
for *all* interrupts, as irqs_disabled() does ?

Best regards,

-- Emmanuel Deloget

