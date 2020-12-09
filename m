Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2F5C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 06:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5201723B7C
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 06:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgLIGPk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:15:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:36069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgLIGPj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 01:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607494413;
        bh=8dyN4rtIYnnwIMdWPdPBWZ1KQ9mVxM1H9J7rR/EOFzE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DrzsgUZm0/ibOoDf++Sl0wq+xplA9qSAtBChkf8ADNEhil0zSSasYxcg0Pps4s3Pr
         RiytE/oKPFscJfLmWykPuj1Xx+eQA00dIDemjyDQuH2ocf3V/h0y4yU0U/E41W6tdY
         MoD9QA8SootUt6GYr9SqDah+5RgOqp/UFkNKUUaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.92]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1khp4t0mNS-00UJDi; Wed, 09
 Dec 2020 07:13:33 +0100
Message-ID: <35863f8cbdb99b2a7eeac3bca13ae6962d6a98c0.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Wed, 09 Dec 2020 07:13:31 +0100
In-Reply-To: <159ce32b-a7c4-08be-9283-9e38a7c27848@konsulko.com>
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <20201203133934.37aotbdjnd36lrxv@linutronix.de>
         <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
         <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
         <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
         <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
         <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
         <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
         <9bd908b65ef15149458aa060c0daf065f9d45615.camel@gmx.de>
         <159ce32b-a7c4-08be-9283-9e38a7c27848@konsulko.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JJzj4cTWPub6wemccX2JYWzN9TJSMR7PXXoNaw9Zc6ySJvfrUKm
 Hs/pXiwXv1m+rTkaQTXawN6ddKt9nG61zzj+c8sW5lLmV88RZ3UkTQpuubECvjWZenBcA5P
 wYAwltEARQPtdaWwR1sFI+HeW1/pQm8gsEzXz9OxZffb2niDcLQRSwBoYXnotIzqzuXZbLH
 vrBrdVrAhChC2sQ564O9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mIpgD/nlw3g=:WdR/sna0D5G3b8HlzLIarS
 qqK9LyhicmmQz/+GTFkpwW2lfe99gwIZSJ0uRptLVPgniZ4ACbRYAUc6/4ogz8gS80wLsXPBm
 AcukSMbbcCvl5PU3X0ubEiJEhMtlzHqgc4z0BAdvFpS0GkH3t3+T9nPnjmodGDdUVDqqaz/FZ
 9Sp8kzY8+94TN7FL02bBsTYqDNtiPkGBNfNN+oMPgQWdjNJBePuPGYL2xJB3zDfRnlSoAjren
 BHtfXpyDKyNZYM3+n0mXPYMleParC4pc2QbznM+QZ+LcTvUfvJRi0bobdijcRXx9SE+Vot+4t
 PTLp+B23azu/J9OBuOyJOjQwTdsi2H+9pKX0yiaYelMmLm+LKLJO2lGQw8/dICFeIV2FFz7qX
 FXWoHrkaMymsnR5mWZSsX7jFfkmpCD+6+6qFGlBh8jGYPTToDSYJxOINyQEE/mw23HJA7GPG+
 1SbtZnKFIkJxT9xIbPPCeTdFwv/zqy3fou1Shf10OG05JwYajRcFGD+fccOxlQe6ro4/SB804
 FbY58fNZP4S/p4nLwwIzkjejHteIA5LsTUcDUgV1b1DTZjLnrjETk1vOpezxhE7g8VQ6StQCH
 ATL57tmNfNe6jcWmbFS7RTIL3/qgl8viaJGDr4XB0SUbfagRZAJwMxVmEZgFdRIAaDJhSEjeE
 KqykQpBN/4wCIkkX8Zul/CYd6WFhqmkBeK5XXvZ/IOtvALgQcuZi5IYOof7LT1uDo0vug7KQS
 7Nisigwp6dry2gr2wGJMS3ZQ00w4lqEdk/x/jsDsf1P0WHUybhroIsgra1IW0xDkV9ribUlkk
 Q8rmeG0cTy7OOt+VSYruwQzXZ1Aq9lrvdl6+oLwkRvWUBHJhr/z+UFt0ZeYoujfcPZyjJzTNW
 R6CEK9eqs1OGxLlZRRDQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-12-09 at 00:26 +0100, Vitaly Wool wrote:
> Hi Mike,
>
> On 2020-12-07 16:41, Mike Galbraith wrote:
> > On Mon, 2020-12-07 at 16:21 +0100, Vitaly Wool wrote:
> >> On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
> >>>
> >>
> >>> Unfortunately, that made zero difference.
> >>
> >> Okay, I suggest that you submit the patch that changes read_lock() to
> >> write_lock() in __release_z3fold_page() and I'll ack it then.
> >> I would like to rewrite the code so that write_lock is not necessary
> >> there but I don't want to hold you back and it isn't likely that I'll
> >> complete this today.
> >
> > Nah, I'm in no rush... especially not to sign off on "Because the
> > little voices in my head said this bit should look like that bit over
> > yonder, and testing _seems_ to indicate they're right about that" :)
> >
> > 	-Mike
> >
>
> okay, thanks. Would this make things better:

Yup, z3fold became RT tolerant with this (un-munged and) applied.

BTW, I don't think my write_lock() hacklet actually plugged the hole
that leads to the below.  I think it just reduced the odds of the two
meeting enough to make it look ~solid in fairly limited test time.

[ 3369.373023] kworker/-7413      4.....12 3368809247us : do_compact_page:=
 zhdr: ffff95d93abd8000 zhdr->slots: ffff95d951f5df80 zhdr->slots->slot[0]=
: 0
[ 3369.373025] kworker/-7413      4.....12 3368809248us : do_compact_page:=
 old_handle ffff95d951f5df98 *old_handle was ffff95d93abd804f now is ffff9=
5da3ab8104c
[ 3369.373027] kworker/-7413      4.....11 3368809249us : __release_z3fold=
_page.constprop.25: freed ffff95d951f5df80
[ 3369.373028] ---------------------------------
[ 3369.373029] CR2: 0000000000000018
crash> p debug_handle | grep '\[2'
  [2]: ffff95dc1ecac0d0
crash> rd ffff95dc1ecac0d0
ffff95dc1ecac0d0:  ffff95d951f5df98                    ...Q....
crash> p debug_zhdr | grep '\[2'
  [2]: ffff95dc1ecac0c8
crash> rd ffff95dc1ecac0c8
ffff95dc1ecac0c8:  ffff95da3ab81000                    ...:....  <=3D=3D k=
worker is not working on same zhdr as free_handle()..
crash> p debug_slots | grep '\[2'
  [2]: ffff95dc1ecac0c0
crash> rd ffff95dc1ecac0c0
ffff95dc1ecac0c0:  ffff95d951f5df80                    ...Q....  <=3D=3D .=
.but is the same slots, and frees it under free_handle().
crash> bt -sx                                                          lea=
ding to use after free+corruption+explosion 1us later.
PID: 9334   TASK: ffff95d95a1eb3c0  CPU: 2   COMMAND: "swapoff"
 #0 [ffffb4248847f8f0] machine_kexec+0x16e at ffffffffa605f8ce
 #1 [ffffb4248847f938] __crash_kexec+0xd2 at ffffffffa614c162
 #2 [ffffb4248847f9f8] crash_kexec+0x30 at ffffffffa614d350
 #3 [ffffb4248847fa08] oops_end+0xca at ffffffffa602680a
 #4 [ffffb4248847fa28] no_context+0x14d at ffffffffa606d7cd
 #5 [ffffb4248847fa88] exc_page_fault+0x2b8 at ffffffffa68bdb88
 #6 [ffffb4248847fae0] asm_exc_page_fault+0x1e at ffffffffa6a00ace
 #7 [ffffb4248847fb68] mark_wakeup_next_waiter+0x51 at ffffffffa60ea121
 #8 [ffffb4248847fbd0] rt_mutex_futex_unlock+0x4f at ffffffffa68c93ef
 #9 [ffffb4248847fc10] z3fold_zpool_free+0x593 at ffffffffc0ecb663 [z3fold=
]
#10 [ffffb4248847fc78] zswap_free_entry+0x43 at ffffffffa627c823
#11 [ffffb4248847fc88] zswap_frontswap_invalidate_page+0x8a at ffffffffa62=
7c92a
#12 [ffffb4248847fcb0] __frontswap_invalidate_page+0x48 at ffffffffa627c01=
8
#13 [ffffb4248847fcd8] swapcache_free_entries+0x1ee at ffffffffa6276f5e
#14 [ffffb4248847fd20] free_swap_slot+0x9f at ffffffffa627b8ff
#15 [ffffb4248847fd40] delete_from_swap_cache+0x61 at ffffffffa6274621
#16 [ffffb4248847fd60] try_to_free_swap+0x70 at ffffffffa6277520
#17 [ffffb4248847fd70] unuse_vma+0x55c at ffffffffa627869c
#18 [ffffb4248847fe90] try_to_unuse+0x139 at ffffffffa6278e89
#19 [ffffb4248847fee8] __x64_sys_swapoff+0x1eb at ffffffffa62798cb
#20 [ffffb4248847ff40] do_syscall_64+0x33 at ffffffffa68b9ab3
#21 [ffffb4248847ff50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffffa6a0=
007c
    RIP: 00007fbd835a5d17  RSP: 00007ffd60634458  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 0000559540e34b60  RCX: 00007fbd835a5d17
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: 0000559540e34b60
    RBP: 0000000000000001   R8: 00007ffd606344c0   R9: 0000000000000003
    R10: 0000559540e34721  R11: 0000000000000202  R12: 0000000000000001
    R13: 0000000000000000  R14: 00007ffd606344c0  R15: 0000000000000000
    ORIG_RAX: 00000000000000a8  CS: 0033  SS: 002b
crash>

>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 18feaa0bc537..340c38a5ffac 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -303,10 +303,9 @@ static inline void put_z3fold_header(struct
> z3fold_header *zhdr)
>   		z3fold_page_unlock(zhdr);
>   }
>
> -static inline void free_handle(unsigned long handle)
> +static inline void free_handle(unsigned long handle, struct
> z3fold_header *zhdr)
>   {
>   	struct z3fold_buddy_slots *slots;
> -	struct z3fold_header *zhdr;
>   	int i;
>   	bool is_free;
>
> @@ -316,22 +315,13 @@ static inline void free_handle(unsigned long handl=
e)
>   	if (WARN_ON(*(unsigned long *)handle =3D=3D 0))
>   		return;
>
> -	zhdr =3D handle_to_z3fold_header(handle);
>   	slots =3D handle_to_slots(handle);
>   	write_lock(&slots->lock);
>   	*(unsigned long *)handle =3D 0;
> -	if (zhdr->slots =3D=3D slots) {
> -		write_unlock(&slots->lock);
> -		return; /* simple case, nothing else to do */
> -	}
> +	if (zhdr->slots !=3D slots)
> +		zhdr->foreign_handles--;
>
> -	/* we are freeing a foreign handle if we are here */
> -	zhdr->foreign_handles--;
>   	is_free =3D true;
> -	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
> -		write_unlock(&slots->lock);
> -		return;
> -	}
>   	for (i =3D 0; i <=3D BUDDY_MASK; i++) {
>   		if (slots->slot[i]) {
>   			is_free =3D false;
> @@ -343,6 +333,8 @@ static inline void free_handle(unsigned long handle)
>   	if (is_free) {
>   		struct z3fold_pool *pool =3D slots_to_pool(slots);
>
> +		if (zhdr->slots =3D=3D slots)
> +			zhdr->slots =3D NULL;
>   		kmem_cache_free(pool->c_handle, slots);
>   	}
>   }
> @@ -525,8 +517,6 @@ static void __release_z3fold_page(struct
> z3fold_header *zhdr, bool locked)
>   {
>   	struct page *page =3D virt_to_page(zhdr);
>   	struct z3fold_pool *pool =3D zhdr_to_pool(zhdr);
> -	bool is_free =3D true;
> -	int i;
>
>   	WARN_ON(!list_empty(&zhdr->buddy));
>   	set_bit(PAGE_STALE, &page->private);
> @@ -536,21 +526,6 @@ static void __release_z3fold_page(struct
> z3fold_header *zhdr, bool locked)
>   		list_del_init(&page->lru);
>   	spin_unlock(&pool->lock);
>
> -	/* If there are no foreign handles, free the handles array */
> -	read_lock(&zhdr->slots->lock);
> -	for (i =3D 0; i <=3D BUDDY_MASK; i++) {
> -		if (zhdr->slots->slot[i]) {
> -			is_free =3D false;
> -			break;
> -		}
> -	}
> -	if (!is_free)
> -		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
> -	read_unlock(&zhdr->slots->lock);
> -
> -	if (is_free)
> -		kmem_cache_free(pool->c_handle, zhdr->slots);
> -
>   	if (locked)
>   		z3fold_page_unlock(zhdr);
>
> @@ -973,6 +948,9 @@ static inline struct z3fold_header
> *__z3fold_alloc(struct z3fold_pool *pool,
>   		}
>   	}
>
> +	if (zhdr && !zhdr->slots)
> +		zhdr->slots =3D alloc_slots(pool,
> +					can_sleep ? GFP_NOIO : GFP_ATOMIC);
>   	return zhdr;
>   }
>
> @@ -1270,7 +1248,7 @@ static void z3fold_free(struct z3fold_pool *pool,
> unsigned long handle)
>   	}
>
>   	if (!page_claimed)
> -		free_handle(handle);
> +		free_handle(handle, zhdr);
>   	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
>   		atomic64_dec(&pool->pages_nr);
>   		return;
> @@ -1429,19 +1407,19 @@ static int z3fold_reclaim_page(struct
> z3fold_pool *pool, unsigned int retries)
>   			ret =3D pool->ops->evict(pool, middle_handle);
>   			if (ret)
>   				goto next;
> -			free_handle(middle_handle);
> +			free_handle(middle_handle, zhdr);
>   		}
>   		if (first_handle) {
>   			ret =3D pool->ops->evict(pool, first_handle);
>   			if (ret)
>   				goto next;
> -			free_handle(first_handle);
> +			free_handle(first_handle, zhdr);
>   		}
>   		if (last_handle) {
>   			ret =3D pool->ops->evict(pool, last_handle);
>   			if (ret)
>   				goto next;
> -			free_handle(last_handle);
> +			free_handle(last_handle, zhdr);
>   		}
>   next:
>   		if (test_bit(PAGE_HEADLESS, &page->private)) {
>
> --
>
> Best regards,
>     Vitaly

