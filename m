From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 2/6] mm: mark all calls into the vmalloc subsystem as
 potentially sleeping
Date: Thu, 20 Oct 2016 17:32:19 -0700
Message-ID: <CAJWu+oric2eq1WOrx9fKHxiMhyq490av-1TbRPDfTptOydfM+A@mail.gmail.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de> <1476773771-11470-3-git-send-email-hch@lst.de>
 <20161019111541.GQ29358@nuc-i3427.alporthouse.com> <20161019130552.GB5876@lst.de>
 <CALCETrVqjejgpQVUdem8RK3uxdEgfOZy4cOJqJQjCLtBDnJfyQ@mail.gmail.com> <20161019163112.GA31091@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andy Lutomirski <luto@amacapital.net>, Chris Wilson <chris@chris-wilson.co.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Jisheng Zhang <jszhang@marvell.com>,
	John Dias <joaodias@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-rt-users@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161019163112.GA31091@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Hi Christoph,

On Wed, Oct 19, 2016 at 9:31 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 19, 2016 at 08:34:40AM -0700, Andy Lutomirski wrote:
>>
>> It would be quite awkward for a task stack to get freed from a
>> sleepable context, because the obvious sleepable context is the task
>> itself, and it still needs its stack.  This was true even in the old
>> regime when task stacks were freed from RCU context.
>>
>> But vfree has a magic automatic deferral mechanism.  Couldn't you make
>> the non-deferred case might_sleep()?
>
> But it's only magic from interrupt context..
>
> Chris, does this patch make virtually mapped stack work for you again?
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f2481cb..942e02d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1533,7 +1533,7 @@ void vfree(const void *addr)
>
>         if (!addr)
>                 return;
> -       if (unlikely(in_interrupt())) {
> +       if (in_interrupt() || in_atomic()) {

in_atomic() also checks in_interrupt() cases so only in_atomic() should suffice.

Thanks,

Joel

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
