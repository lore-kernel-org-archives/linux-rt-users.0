Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30785C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 11:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC46E2333F
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 11:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLGLxk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgLGLxk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 06:53:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05559C0613D4
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Dec 2020 03:52:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z21so17604167lfe.12
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Dec 2020 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbcZ0bSg2oe4ybbJwcruH4k64DkgbzTjybs+KQ5OE8s=;
        b=VEaoCPEDDAXEVGvnKp4E2uwASKtfwpkbQoIvWCOasNNEPTcZ/pMfUVB84Qtsf/xj0+
         JM7lDwrUKTe6ocSQNaUeoqfnhcidA0PbzByw1ZyztXWPjA+3pqCFE5q0A71Npr5OeM/m
         LG/ihoaRB7xuh+XhjEAEhAB+qbNhyyXwa+t68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbcZ0bSg2oe4ybbJwcruH4k64DkgbzTjybs+KQ5OE8s=;
        b=C0gmTW+PPRnGTKL928mkTlUMwHgRqYjmY6xBBinyLXCG5vMnRs/kCGRo98AKLtfXok
         7h/05ZUmzlAEiZ41nFKFbPXehmbKqws9R90Sl2MhUJwkNKX1BWqIQvDJUX8ZmOsa1n2c
         Noko3lJFlQGipLw9W/pwU2d0oEDl6rH6ZF2m+KhKVWm/agZc7m3cssPMlf360JpkSYI6
         BoJkgbqbMZfCiJ8CbC2lVEtd87pLdVRQU6tEQ+xn89jG00j1ahSio6Wi3AqHrZ8HWF+w
         BUfDl1NPW5dACKuOzRtnjjr6ym9w9x0hqeBwjD51PonSKlJCGcBPQ47u0jdbZkWxoQ2P
         SJ2w==
X-Gm-Message-State: AOAM530B/ApmRSNFgtudVf0BH692+VmyNcZW7QFw9Da/5cAFckZr/TEZ
        vi+ShVOCp0737pTsWEyr4rlxTvvHu4xju6GXgx8hmg==
X-Google-Smtp-Source: ABdhPJx0iAjqX3slY9qXKo4pURaFZHetOLHdAM82Tvhl40dxaCVXqff12112d7tosd5dcjJprLDsnDMIZEzE9biT+8k=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr8618171lfd.571.1607341978531;
 Mon, 07 Dec 2020 03:52:58 -0800 (PST)
MIME-Version: 1.0
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de> <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de> <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de> <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de> <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de> <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de> <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
In-Reply-To: <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 7 Dec 2020 12:52:47 +0100
Message-ID: <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
Subject: Re: scheduling while atomic in z3fold
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Dec 7, 2020 at 3:18 AM Mike Galbraith <efault@gmx.de> wrote:
>
> On Mon, 2020-12-07 at 02:05 +0100, Vitaly Wool wrote:
> >
> > Could you please try the following patch in your setup:
>
> crash> gdb list *z3fold_zpool_free+0x527
> 0xffffffffc0e14487 is in z3fold_zpool_free (mm/z3fold.c:341).
> 336                     if (slots->slot[i]) {
> 337                             is_free = false;
> 338                             break;
> 339                     }
> 340             }
> 341             write_unlock(&slots->lock);  <== boom
> 342
> 343             if (is_free) {
> 344                     struct z3fold_pool *pool = slots_to_pool(slots);
> 345
> crash> z3fold_buddy_slots -x ffff99a3287b8780
> struct z3fold_buddy_slots {
>   slot = {0xdeadbeef, 0xdeadbeef, 0xdeadbeef, 0xdeadbeef},
>   pool = 0xffff99a3146b8400,
>   lock = {
>     rtmutex = {
>       wait_lock = {
>         raw_lock = {
>           {
>             val = {
>               counter = 0x1
>             },
>             {
>               locked = 0x1,
>               pending = 0x0
>             },
>             {
>               locked_pending = 0x1,
>               tail = 0x0
>             }
>           }
>         }
>       },
>       waiters = {
>         rb_root = {
>           rb_node = 0xffff99a3287b8e00
>         },
>         rb_leftmost = 0x0
>       },
>       owner = 0xffff99a355c24500,
>       save_state = 0x1
>     },
>     readers = {
>       counter = 0x80000000
>     }
>   }
> }

Thanks. This trace beats me because I don't quite get how this could
have happened.
Hitting write_unlock at line 341 would mean that HANDLES_ORPHANED bit
is set but obviously it isn't.
Could you please comment out the ".shrink = z3fold_zpool_shrink" line
and retry? Reclaim is the trickiest thing over there since I have to
drop page lock while reclaiming.

Thanks,
   Vitaly

> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 18feaa0bc537..efe9a012643d 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -544,12 +544,17 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
> >                       break;
> >               }
> >       }
> > -     if (!is_free)
> > +     if (!is_free) {
> >               set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
> > -     read_unlock(&zhdr->slots->lock);
> > -
> > -     if (is_free)
> > +             read_unlock(&zhdr->slots->lock);
> > +     } else {
> > +             zhdr->slots->slot[0] =
> > +                     zhdr->slots->slot[1] =
> > +                     zhdr->slots->slot[2] =
> > +                     zhdr->slots->slot[3] = 0xdeadbeef;
> > +             read_unlock(&zhdr->slots->lock);
> >               kmem_cache_free(pool->c_handle, zhdr->slots);
> > +     }
> >
> >       if (locked)
> >               z3fold_page_unlock(zhdr);
>
