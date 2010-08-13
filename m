From: John Culvertson <jculvertson@gmail.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 17:20:20 -0400
Message-ID: <AANLkTimpc8ToaPxMCK4yH2Q2cNQsWs+xOO_grQ1c2Yt0@mail.gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
	<AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
	<AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>
	<AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com>
	<AANLkTimU0pf-9xRzJ8p4-OY=itmfjS3GJX4CKBZ9XorG@mail.gmail.com>
	<4C65A844.1010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64575 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0HMVUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 17:20:21 -0400
Received: by pvg2 with SMTP id 2so948450pvg.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 14:20:21 -0700 (PDT)
In-Reply-To: <4C65A844.1010702@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I changed from PREEMPT_RT to PREEMPT_DESKTOP, and now it will not
boot.  I get the following error, then it hangs:

[    9.025745] BUG: sleeping function called from invalid context at
mm/slab.c:3266
[    9.044859] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 16,
name: events/0
[    9.064192] Pid: 16, comm: events/0 Not tainted 2.6.33.7-rt29 #3
[    9.076674] Call Trace:
[    9.085224]  [<c108ed63>] ? kmem_cache_alloc+0x1b/0x99
[    9.096780]  [<c11a8aef>] ? __alloc_skb+0x2e/0x10a
[    9.108079]  [<c1209db2>] ? alloc_skb+0x9/0xb
[    9.118763]  [<c120a5fd>] ? inet6_rt_notify+0x2f/0xb3
[    9.130285]  [<c120d630>] ? fib6_add+0x21e/0x38e
[    9.141487]  [<c120ac83>] ? __ip6_ins_rt+0x23/0x35
[    9.152743]  [<c120536d>] ? addrconf_add_mroute+0x6c/0x72
[    9.164855]  [<c12061f8>] ? addrconf_add_dev+0x3d/0x49
[    9.176495]  [<c12070ed>] ? addrconf_notify+0x4f6/0x6d7
[    9.188213]  [<c114ddff>] ? extract_entropy+0x45/0xfe
[    9.199753]  [<c11c18a2>] ? need_resched+0x11/0x1a
[    9.210686]  [<c11c1d97>] ? rt_do_flush+0x26/0x105
[    9.221572]  [<c103b3dc>] ? notifier_call_chain+0x2a/0x52
[    9.233426]  [<c103b418>] ? raw_notifier_call_chain+0x9/0xc
[    9.244968]  [<c11af6ff>] ? netdev_state_change+0x18/0x29
[    9.256198]  [<c11b88d7>] ? linkwatch_do_dev+0x9e/0xa7
[    9.267208]  [<c11b8b07>] ? __linkwatch_run_queue+0xd4/0x108
[    9.278611]  [<c11b8b58>] ? linkwatch_event+0x1d/0x22
[    9.289437]  [<c10351e2>] ? worker_thread+0xe1/0x15e
[    9.299891]  [<c11b8b3b>] ? linkwatch_event+0x0/0x22
[    9.310157]  [<c1037574>] ? autoremove_wake_function+0x0/0x2d
[    9.321305]  [<c1035101>] ? worker_thread+0x0/0x15e
[    9.331182]  [<c103737b>] ? kthread+0x52/0x57
[    9.340335]  [<c1037329>] ? kthread+0x0/0x57
[    9.349248]  [<c1002dfe>] ? kernel_thread_helper+0x6/0x10


On Fri, Aug 13, 2010 at 4:17 PM, Sven-Thorsten Dietrich
<sven@thebigcorporation.com> wrote:
> =A0On 08/13/2010 11:07 AM, John Culvertson wrote:
>>
>> Thanks for the suggestions. =A0I have tried the unpatched 2.6.33.7
>> kernel, and the problem does not occur. =A0The hardware is a single
>> board industrial computer with the network controllers onboard, so I
>> cannot easily try different NICs. =A0I have not seen the problem occ=
ur
>> with only one port in use, but I have not tested that long enough to
>> be positive.
>>
>> One thing that may be a little odd about this computer is that both
>> Ethernet controllers (Intel 82559) share the same PCI interrupt.
>> Interrupt sharing should be OK, but since adjacent PCI slots in norm=
al
>> PCs generally use different interrupts, it may not occur often in
>> other systems.
>>
>
> Does it reproduce when you turn off PREEMPT_RT, but leave all the IRQ
> threading options enabled?
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
