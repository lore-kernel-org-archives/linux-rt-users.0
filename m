From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] lockdep: Add nr_save_trace_invocations counter
Date: Fri, 23 Apr 2010 11:40:52 +0200
Message-ID: <o2v520f0cf11004230240ubcdabe13ufba29de626d6b40b@mail.gmail.com>
References: <alpine.LFD.2.00.1004222208310.3155@localhost>
	 <20100423025850.GA21328@windriver.com>
	 <alpine.LFD.2.00.1004230907050.4151@localhost>
	 <1272009915.1646.25.camel@laptop>
	 <w2v520f0cf11004230131i743c596emfd0e5b8870330a8b@mail.gmail.com>
	 <20100423084926.GE21328@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Yong Zhang <yong.zhang@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57548 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805Ab0DWJky (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Apr 2010 05:40:54 -0400
In-Reply-To: <20100423084926.GE21328@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 23, 2010 at 10:49 AM, Yong Zhang <yong.zhang@windriver.com> wrote:
> On Fri, Apr 23, 2010 at 10:31:16AM +0200, John Kacur wrote:
>> > 8752+871+8+95+5+28+543+28+543+15=10888
>> >
>> > So you get a stack-trace for each direct-dependency, and you get a
>> > stack-trace for each LOCK_state, the sum seems to match the total
>> > invocations.
>> >
>> > Non of these numbers look strange..
>> >
>>
>> As I told Peter privately the laptop that triggered the
>> MAX_STACK_TRACE_ENTRIES every time, has met an
>> unfortunate early demise. However, I think it was the config - not the
>> hardware. On this machine where the above
>> numbers come from, I believe I have less debug options configured -
>> but it is running the exact same kernel as
>> the laptop was. (2.6.33.2-rt13)
>
> Through a rough computation:
> MAX_STACK_TRACE_ENTRIES/10888 = 24
> That means the average stack deepth is about 24.
> So I'm thinking if we can take a check on the biggest deepth?
> Could this make sense?
>

Hi Yong, yes that makes sense, I'll see if I can provide a patch for that too.

Thanks
