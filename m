From: John Culvertson <jculvertson@gmail.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Mon, 16 Aug 2010 13:16:18 -0400
Message-ID: <AANLkTim=1td8RPtsGTGTZZTZRzQ8CSsJCchykzfCGiar@mail.gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
	<AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
	<AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>
	<AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com>
	<AANLkTimU0pf-9xRzJ8p4-OY=itmfjS3GJX4CKBZ9XorG@mail.gmail.com>
	<4C65A844.1010702@gmail.com>
	<AANLkTimpc8ToaPxMCK4yH2Q2cNQsWs+xOO_grQ1c2Yt0@mail.gmail.com>
	<1281740245.13891.11.camel@baracus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60062 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0HPRQT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Aug 2010 13:16:19 -0400
Received: by pvg2 with SMTP id 2so1999516pvg.19
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 10:16:18 -0700 (PDT)
In-Reply-To: <1281740245.13891.11.camel@baracus>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linkwatch_event is defined in net/core/link_watch.c.

It appears to work fine if I disable PREEMPT_HARDIRQs.

Thanks for the feedback.  My main objective with this platform at the
moment is to learn about preempt-rt and evaluate its stability and
suitability for use.

On Fri, Aug 13, 2010 at 6:57 PM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Fri, 2010-08-13 at 17:20 -0400, John Culvertson wrote:
>> I changed from PREEMPT_RT to PREEMPT_DESKTOP, and now it will not
>> boot. =A0I get the following error, then it hangs:
>
> LOL. =A0Sounds like there is a little more work to be done on the .33
> release.
>
> I think you are onto something however - although I am not at the mom=
ent
> blessed with the time to dig for you -
>
> linkwatch_event - is that part of e1000?
>
> If so, that's where I'd start digging.
>
> What happens if you first disable PREEMPT_HARDIRQs,
> and then next also disable PREEMPT_SOFTIRQs?
>
> I would assume after the latter it would work just fine.
>
> Regards,
>
> Sven
>
>>
>> [ =A0 =A09.025745] BUG: sleeping function called from invalid contex=
t at
>> mm/slab.c:3266
>> [ =A0 =A09.044859] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid=
: 16,
>> name: events/0
>> [ =A0 =A09.064192] Pid: 16, comm: events/0 Not tainted 2.6.33.7-rt29=
 #3
>> [ =A0 =A09.076674] Call Trace:
>> [ =A0 =A09.085224] =A0[<c108ed63>] ? kmem_cache_alloc+0x1b/0x99
>> [ =A0 =A09.096780] =A0[<c11a8aef>] ? __alloc_skb+0x2e/0x10a
>> [ =A0 =A09.108079] =A0[<c1209db2>] ? alloc_skb+0x9/0xb
>> [ =A0 =A09.118763] =A0[<c120a5fd>] ? inet6_rt_notify+0x2f/0xb3
>> [ =A0 =A09.130285] =A0[<c120d630>] ? fib6_add+0x21e/0x38e
>> [ =A0 =A09.141487] =A0[<c120ac83>] ? __ip6_ins_rt+0x23/0x35
>> [ =A0 =A09.152743] =A0[<c120536d>] ? addrconf_add_mroute+0x6c/0x72
>> [ =A0 =A09.164855] =A0[<c12061f8>] ? addrconf_add_dev+0x3d/0x49
>> [ =A0 =A09.176495] =A0[<c12070ed>] ? addrconf_notify+0x4f6/0x6d7
>> [ =A0 =A09.188213] =A0[<c114ddff>] ? extract_entropy+0x45/0xfe
>> [ =A0 =A09.199753] =A0[<c11c18a2>] ? need_resched+0x11/0x1a
>> [ =A0 =A09.210686] =A0[<c11c1d97>] ? rt_do_flush+0x26/0x105
>> [ =A0 =A09.221572] =A0[<c103b3dc>] ? notifier_call_chain+0x2a/0x52
>> [ =A0 =A09.233426] =A0[<c103b418>] ? raw_notifier_call_chain+0x9/0xc
>> [ =A0 =A09.244968] =A0[<c11af6ff>] ? netdev_state_change+0x18/0x29
>> [ =A0 =A09.256198] =A0[<c11b88d7>] ? linkwatch_do_dev+0x9e/0xa7
>> [ =A0 =A09.267208] =A0[<c11b8b07>] ? __linkwatch_run_queue+0xd4/0x10=
8
>> [ =A0 =A09.278611] =A0[<c11b8b58>] ? linkwatch_event+0x1d/0x22
>> [ =A0 =A09.289437] =A0[<c10351e2>] ? worker_thread+0xe1/0x15e
>> [ =A0 =A09.299891] =A0[<c11b8b3b>] ? linkwatch_event+0x0/0x22
>> [ =A0 =A09.310157] =A0[<c1037574>] ? autoremove_wake_function+0x0/0x=
2d
>> [ =A0 =A09.321305] =A0[<c1035101>] ? worker_thread+0x0/0x15e
>> [ =A0 =A09.331182] =A0[<c103737b>] ? kthread+0x52/0x57
>> [ =A0 =A09.340335] =A0[<c1037329>] ? kthread+0x0/0x57
>> [ =A0 =A09.349248] =A0[<c1002dfe>] ? kernel_thread_helper+0x6/0x10
>>
>>
>> On Fri, Aug 13, 2010 at 4:17 PM, Sven-Thorsten Dietrich
>> <sven@thebigcorporation.com> wrote:
>> > =A0On 08/13/2010 11:07 AM, John Culvertson wrote:
>> >>
>> >> Thanks for the suggestions. =A0I have tried the unpatched 2.6.33.=
7
>> >> kernel, and the problem does not occur. =A0The hardware is a sing=
le
>> >> board industrial computer with the network controllers onboard, s=
o I
>> >> cannot easily try different NICs. =A0I have not seen the problem =
occur
>> >> with only one port in use, but I have not tested that long enough=
 to
>> >> be positive.
>> >>
>> >> One thing that may be a little odd about this computer is that bo=
th
>> >> Ethernet controllers (Intel 82559) share the same PCI interrupt.
>> >> Interrupt sharing should be OK, but since adjacent PCI slots in n=
ormal
>> >> PCs generally use different interrupts, it may not occur often in
>> >> other systems.
>> >>
>> >
>> > Does it reproduce when you turn off PREEMPT_RT, but leave all the =
IRQ
>> > threading options enabled?
>> >
>> >
>> >
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
