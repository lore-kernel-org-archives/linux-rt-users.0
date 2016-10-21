From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 4/6] mm: remove free_unmap_vmap_area_addr
Date: Thu, 20 Oct 2016 17:46:36 -0700
Message-ID: <CAJWu+oqOw6uMh+Q_78MGjO8WKLxCuh4fmVmKxEJ5aoviXjoMcA@mail.gmail.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de> <1476773771-11470-5-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Dias <joaodias@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-rt-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35301 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbcJUAqj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 20:46:39 -0400
Received: by mail-lf0-f48.google.com with SMTP id l131so108384047lfl.2
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Oct 2016 17:46:38 -0700 (PDT)
In-Reply-To: <1476773771-11470-5-git-send-email-hch@lst.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Christoph,

On Mon, Oct 17, 2016 at 11:56 PM, Christoph Hellwig <hch@lst.de> wrote:
> Just inline it into the only caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 8cedfa0..2af2921 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -717,16 +717,6 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
>         return va;
>  }
>
> -static void free_unmap_vmap_area_addr(unsigned long addr)
> -{
> -       struct vmap_area *va;
> -
> -       va = find_vmap_area(addr);
> -       BUG_ON(!va);
> -       free_unmap_vmap_area(va);
> -}
> -
> -
>  /*** Per cpu kva allocator ***/
>
>  /*
> @@ -1090,6 +1080,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  {
>         unsigned long size = (unsigned long)count << PAGE_SHIFT;
>         unsigned long addr = (unsigned long)mem;
> +       struct vmap_area *va;
>
>         might_sleep();
>         BUG_ON(!addr);
> @@ -1100,10 +1091,14 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>         debug_check_no_locks_freed(mem, size);
>         vmap_debug_free_range(addr, addr+size);
>
> -       if (likely(count <= VMAP_MAX_ALLOC))
> +       if (likely(count <= VMAP_MAX_ALLOC)) {
>                 vb_free(mem, size);
> -       else
> -               free_unmap_vmap_area_addr(addr);
> +               return;
> +       }
> +
> +       va = find_vmap_area(addr);
> +       BUG_ON(!va);

Considering recent objections to BUG_ON [1], lets make this a WARN_ON
while we're moving the code?

> +       free_unmap_vmap_area(va);
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
>
> --
> 2.1.4

Thanks,

Joel

[1] https://lkml.org/lkml/2016/10/6/65
