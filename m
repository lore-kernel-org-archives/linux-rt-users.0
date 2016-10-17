From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2] mm: vmalloc: Replace purge_lock spinlock with atomic refcount
Date: Mon, 17 Oct 2016 10:34:51 -0700
Message-ID: <CAJWu+oqg9vjit6=p24rYn3X0e4Z+TLLqn79AApoE1rTBNpbB1Q@mail.gmail.com>
References: <1476528162-21981-1-git-send-email-joelaf@google.com> <20161017150005.4c8f890d@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>, Jisheng Zhang <jszhang@marvell.com>,
	John Dias <joaodias@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
To: Nicholas Piggin <npiggin@gmail.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161017150005.4c8f890d@roar.ozlabs.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Hi Nick,

On Sun, Oct 16, 2016 at 9:00 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Sat, 15 Oct 2016 03:42:42 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> The purge_lock spinlock causes high latencies with non RT kernel. This has been
>> reported multiple times on lkml [1] [2] and affects applications like audio.
>>
>> In this patch, I replace the spinlock with an atomic refcount so that
>> preemption is kept turned on during purge. This Ok to do since [3] builds the
>> lazy free list in advance and atomically retrieves the list so any instance of
>> purge will have its own list it is purging. Since the individual vmap area
>> frees are themselves protected by a lock, this is Ok.
>
> This is a good idea, and good results, but that's not what the spinlock was
> for -- it was for enforcing the sync semantics.
>
> Going this route, you'll have to audit callers to expect changed behavior
> and change documentation of sync parameter.
>
> I suspect a better approach would be to instead use a mutex for this, and
> require that all sync=1 callers be able to sleep. I would say that most
> probably already can.

Thanks, I agree mutex is the right way to fix this.

Regards,
Joel

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
