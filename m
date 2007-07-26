From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Thu, 26 Jul 2007 12:17:00 -0300
Message-ID: <46A8BAEC.9070507@redhat.com>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>	<1184615557.2698.3.camel@laptopd505.fenrus.org>	<20070726072858.GC13061@in.ibm.com> <20070726133138.GA30559@Krystal> <y0mps2f1asz.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Ankita Garg <ankita@in.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>, linux@bohmer.net,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36493 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757965AbXGZPRy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 11:17:54 -0400
In-Reply-To: <y0mps2f1asz.fsf@ton.toronto.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Frank Ch. Eigler wrote:
> Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:
>
>   
>> [...]
>> The problem is also in _stp_print_flush, not *only* in relay code:
>> void _stp_print_flush (void)
>> ...
>>                 spin_lock(&_stp_print_lock);
>>                 ...
>>                 spin_unlock(&_stp_print_lock);
>>
>> Those will turn into mutexes with -rt.
>>     
>
> Indeed, plus systemtap-generated locking code uses rwlocks,
> local_irq_save/restore or preempt_disable, in various places.  Could
> someone point to a place that spells out what would be more
> appropriate way of ensuring atomicity while being compatible with -rt?
>   

https://ols2006.108.redhat.com/2007/Reprints/rostedt-Reprint.pdf

And his slides too, haven't checked if they are already only at the OLS 
site.

- Arnaldo
