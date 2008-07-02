From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: [Ksummit-2008-discuss] Delayed interrupt work, thread pools
Date: Wed, 2 Jul 2008 13:19:39 +0200
Message-ID: <c384c5ea0807020419o4d5b9ff1j34d4dc11a41dd2@mail.gmail.com>
References: <1214916335.20711.141.camel@pasglop>
	 <486B0298.5030508@linux.intel.com> <1214977447.21182.33.camel@pasglop>
	 <87zlp0sg4l.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: benh@kernel.crashing.org,
	"Arjan van de Ven" <arjan@linux.intel.com>,
	ksummit-2008-discuss@lists.linux-foundation.org,
	"Linux Kernel list" <linux-kernel@vger.kernel.org>,
	"Jeremy Kerr" <jk@ozlabs.org>, RT <linux-rt-users@vger.kernel.org>
To: "Andi Kleen" <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:58879 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758953AbYGBLTk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jul 2008 07:19:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so60768and.103
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Jul 2008 04:19:39 -0700 (PDT)
In-Reply-To: <87zlp0sg4l.fsf@basil.nowhere.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

(including linux-rt-users in the CC:, irqthreads are on-topic there)

On Wed, Jul 2, 2008 at 1:02 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>>> how much of this would be obsoleted if we had irqthreads ?
>>
>> I'm not sure irqthreads is what I want...
>>
> I also think interrupts threads are a bad idea in many cases because
> their whole "advantage" over classical interrupts is that they can
> block. Now blocking can be usually take a unbounded potentially long
> time.
>
> What do you do when there are more interrupts in that unbounded time?
>
If by irqthreads the -rt implementation is meant, isn't this what happens:

irq kernel handler masks the source interrupt
irq handler awakes the matching irqthread (they always are present)
irqthread is scheduled, does work and returns
irq kernel unmasks the source interrupt

> Create more interrupt threads?  At some point you'll have hundreds
> of threads doing nothing when you're unlucky.
>
Each irqthread handles one irq.
So now new irq thread would spawn for any interrupt.

Regards,
-- 
Leon
