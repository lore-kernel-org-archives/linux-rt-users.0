From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 4/7] mm: defer vmalloc from atomic context
Date: Tue, 8 Nov 2016 18:03:58 +0300
Message-ID: <747aa42a-c236-ee25-eef5-59644687f01b@virtuozzo.com>
References: <1477149440-12478-1-git-send-email-hch@lst.de>
 <1477149440-12478-5-git-send-email-hch@lst.de>
 <25c117ae-6d06-9846-6a88-ae6221ad6bfe@virtuozzo.com>
 <CAJWu+oppRL5kD9qPcdCbFAbEkE7bN+kmrvTuaueVZnY+WtK_tg@mail.gmail.com>
 <a40cccff-3a6e-b0be-5d06-bac6cdb0e1e6@virtuozzo.com>
 <20161107150947.GA11279@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Joel Fernandes <joelaf@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jisheng Zhang <jszhang@marvell.com>, Chris
 Wilson <chris@chris-wilson.co.uk>, John Dias <joaodias@google.com>, "open
 list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	<linux-rt-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy
 Lutomirski <luto@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161107150947.GA11279@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org



On 11/07/2016 06:09 PM, Christoph Hellwig wrote:
> On Mon, Nov 07, 2016 at 06:01:45PM +0300, Andrey Ryabinin wrote:
>>> So because in_atomic doesn't work for !CONFIG_PREEMPT kernels, can we
>>> always defer the work in these cases?
>>>
>>> So for non-preemptible kernels, we always defer:
>>>
>>> if (!IS_ENABLED(CONFIG_PREEMPT) || in_atomic()) {
>>>   // defer
>>> }
>>>
>>> Is this fine? Or any other ideas?
>>>
>>
>> What's wrong with my idea?
>> We can add vfree_in_atomic() and use it to free vmapped stacks
>> and for any other places where vfree() used 'in_atomict() && !in_interrupt()' context.
> 
> I somehow missed the mail, sorry.  That beeing said always defer is
> going to suck badly in terms of performance, so I'm not sure it's an all
> that good idea.
> 
> vfree_in_atomic sounds good, but I wonder if we'll need to annotate
> more callers than just the stacks.  I'm fairly bust this week, do you
> want to give that a spin?  Otherwise I'll give it a try towards the
> end of this week or next week.
> 

Yeah, it appears that we need more annotations. I've found another case in free_ldt_struct(),
and I bet it won't be the last.
I'll send patches.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
