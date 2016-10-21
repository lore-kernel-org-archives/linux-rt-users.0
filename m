From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/6] mm: remove free_unmap_vmap_area_addr
Date: Fri, 21 Oct 2016 12:58:28 +1100
Message-ID: <20161021125828.17b8960e@roar.ozlabs.ibm.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
        <1476773771-11470-5-git-send-email-hch@lst.de>
        <CAJWu+oqOw6uMh+Q_78MGjO8WKLxCuh4fmVmKxEJ5aoviXjoMcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Dias <joaodias@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-rt-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Joel Fernandes <joelaf@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJWu+oqOw6uMh+Q_78MGjO8WKLxCuh4fmVmKxEJ5aoviXjoMcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 20 Oct 2016 17:46:36 -0700
Joel Fernandes <joelaf@google.com> wrote:

> > @@ -1100,10 +1091,14 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> >         debug_check_no_locks_freed(mem, size);
> >         vmap_debug_free_range(addr, addr+size);
> >
> > -       if (likely(count <= VMAP_MAX_ALLOC))
> > +       if (likely(count <= VMAP_MAX_ALLOC)) {
> >                 vb_free(mem, size);
> > -       else
> > -               free_unmap_vmap_area_addr(addr);
> > +               return;
> > +       }
> > +
> > +       va = find_vmap_area(addr);
> > +       BUG_ON(!va);  
> 
> Considering recent objections to BUG_ON [1], lets make this a WARN_ON
> while we're moving the code?

If you lost track of your kernel memory mappings, you are in big trouble
and fail stop is really the best course of action for containing the
problem, which could have security and data corruption implications. This
is covered by Linus' last paragraph in that commit.

Thanks,
Nick
