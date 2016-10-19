From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/6] mm: mark all calls into the vmalloc subsystem as
 potentially sleeping
Date: Wed, 19 Oct 2016 08:34:40 -0700
Message-ID: <CALCETrVqjejgpQVUdem8RK3uxdEgfOZy4cOJqJQjCLtBDnJfyQ@mail.gmail.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de> <1476773771-11470-3-git-send-email-hch@lst.de>
 <20161019111541.GQ29358@nuc-i3427.alporthouse.com> <20161019130552.GB5876@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Andrew Morton <akpm@linux-foundation.org>,
	joelaf@google.com, jszhang@marvell.com, joaodias@google.com,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, linux-rt-users@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161019130552.GB5876@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 19, 2016 at 6:05 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 19, 2016 at 12:15:41PM +0100, Chris Wilson wrote:
>> On Tue, Oct 18, 2016 at 08:56:07AM +0200, Christoph Hellwig wrote:
>> > This is how everyone seems to already use them, but let's make that
>> > explicit.
>>
>> Ah, found an exception, vmapped stacks:
>
> Oh, fun.  So if we can't require vfree to be called from process context
> we also can't use a mutex to wait for the vmap flushing.  Given that we
> free stacks from the scheduler context switch I also fear there is no
> good way to get a sleepable context there.
>
> The only other idea I had was to use vmap_area_lock for the protection
> that purge_lock currently provides, but that would require some serious
> refactoring to avoid recursive locking first.

It would be quite awkward for a task stack to get freed from a
sleepable context, because the obvious sleepable context is the task
itself, and it still needs its stack.  This was true even in the old
regime when task stacks were freed from RCU context.

But vfree has a magic automatic deferral mechanism.  Couldn't you make
the non-deferred case might_sleep()?

-- 
Andy Lutomirski
AMA Capital Management, LLC

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
