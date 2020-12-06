Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE34C4361B
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Dec 2020 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AF323108
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Dec 2020 09:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgLFJUh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Dec 2020 04:20:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:36285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgLFJUa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Dec 2020 04:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607246295;
        bh=Ed8BH6kWZqBsbi6oDVsNpvoSo06gEfeKE4I+LPP6d+I=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XI5TQTs5tnJXvga2vU62FiO4vaeavKNtG2P15bBSRxMmYP4JV2AGgAiZxMvkwM+Bz
         +0aNaa6JJTS43OmsCIAgChetL3CqoSKBbJp1Z6ZCuFT8QnZ9GIoZmzNUNCZ8AFSZsx
         TshRj9xocip54GFXqcHvD8Ml5bE0JKc4tG0UaCHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1kwYtU2TOB-00HMWm; Sun, 06
 Dec 2020 10:18:15 +0100
Message-ID: <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 06 Dec 2020 10:18:11 +0100
In-Reply-To: <20201203133934.37aotbdjnd36lrxv@linutronix.de>
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <20201203133934.37aotbdjnd36lrxv@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E0nNbFoReAPps7anMfyiLl/EZwTABPIpbr6k58Ug4NazFUEpK/5
 5svKJoAVFzk8ewKfrJU8ZtXFys1+uCsIMSvI14Y3NS+0F+104Jfi2naoBXlGuV3Q1xK73Kg
 vopR0iqdXBnNBwYR0rq9LruO89ZTQjpa2RQRb7DiAxK8ptozWaqfAPrpxnzBTseklUiZCwj
 GDtb6iZFpbSBKMKaOn/eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CU6DyySoO5U=:WLumhduxukQKr2oeW7LU6m
 //o8UUwnvaZ8TdUZ9lBX74rKUaT5ueeFp69CvaKamJ+AhZVff9mgu9AkeyWe3qXDahEyUB9Xx
 1TKk7mIH7GZ8W6dniN6cTt7Yk0g28JD8z5MUo6zorJ3F/laYwx7AVS6VJRISOJ4ehHIinScOM
 CPFF6Kzry6H39orF1oxRMP2MbKraCqxIZ81XeNlL5tqG9cBTmKJGAZpA5jhRrppoH+0FI+b+v
 wZCxdmxMGjhUO9pJSAVcDMpeFKqrShecy5w+fuebnZsDNrso3FsPT6PQ+jAJkpslofiix4yCg
 65mLsMj+y7Y+Jxdq+Il1X/afDcTnK8SzlRpbMpt8VdZLxLKrlXBNuYA4n06di/I9kaWt8fvHt
 S9uEKHMQMRojoUJoW80EpOBqXAPw+i2INQd2R2ceTuA4D0T8frGfnX7vHx9keoCyszNRKnAGi
 uD62DWtFLI3OaoCwQsubpSHZ4OmF7WjBwDyX+fcorQX6QvGfxoAQsdzXi2PUYmXrTZCbfRWzj
 5RAOsOlJ6kaUEcVYnPod7+QIzj0Y1gj45vRWhpw71izUtLiIIF4THGE3VAaPqwe5B8ZrrOD/+
 VMfInUcrVQ5BjD24jHnUJC/IUCvmCC0IZ4FKYzunvv4nswowOz/Ylkfoisiz2PDI47YAZDjXr
 IvPtbjhkXAXMVVMtvpepbZkSo6w4bga2BYWbUWlEjIYq16xCUqrofiKZvolSXOl6k6eSktbmM
 4UZ3YVggxrZgROIljm6RsTXiuGttj+rKqiNDIRrg3q1ZU3HAPp0mCLMpgRtwG2kKcb9LoHgr2
 GxTM+1oiOc1FItYQrnxR4zsbkec3o5i1WAJtD/NLawrd9rt8xMhfFQXzRfEnrNC1c3k3AAKP4
 bCPEeyPOhus4roA4cSOA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 14:39 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-03 09:18:21 [+0100], Mike Galbraith wrote:
> > On Thu, 2020-12-03 at 03:16 +0100, Mike Galbraith wrote:
> > > On Wed, 2020-12-02 at 23:08 +0100, Sebastian Andrzej Siewior wrote:
> > > Looks like...
> > >
> > > d8f117abb380 z3fold: fix use-after-free when freeing handles
> > >
> > > ...wasn't completely effective...
> >
> > The top two hunks seem to have rendered the thing RT tolerant.
>
> Yes, it appears to. I have no idea if this is a proper fix or not.
> Without your write lock, after a few attempts, KASAN says:
>
> | BUG: KASAN: use-after-free in __pv_queued_spin_lock_slowpath+0x293/0x7=
70
> | Write of size 2 at addr ffff88800e0e10aa by task kworker/u16:3/237

Things that make ya go hmmm...

I started poking at it thinking ok, given write_lock() fixes it, bad
juju must be happening under another read_lock(), so I poisoned the
structure about to be freed by __release_z3fold_page() under lock, and
opened a delay window for bad juju to materialize, but it didn't, so I
just poisoned instead, and sprinkled landmines all over the place.

My landmines are not triggering but the detonator is materializing
inside the structure containing the lock we explode on.  Somebody
blasts a recycled z3fold_buddy_slots into ram we were working on?

crash> bt -sx
PID: 11850  TASK: ffff933ee67f2280  CPU: 1   COMMAND: "swapoff"
 #0 [ffffa7bf4e7f3900] machine_kexec+0x16e at ffffffff8405f86e
 #1 [ffffa7bf4e7f3948] __crash_kexec+0xd2 at ffffffff8414c182
 #2 [ffffa7bf4e7f3a08] crash_kexec+0x30 at ffffffff8414d370
 #3 [ffffa7bf4e7f3a18] oops_end+0xca at ffffffff8402680a
 #4 [ffffa7bf4e7f3a38] no_context+0x14d at ffffffff8406d7ed
 #5 [ffffa7bf4e7f3a98] exc_page_fault+0x2b8 at ffffffff848bdb88
 #6 [ffffa7bf4e7f3af0] asm_exc_page_fault+0x1e at ffffffff84a00ace
 #7 [ffffa7bf4e7f3b78] mark_wakeup_next_waiter+0x51 at ffffffff840ea141
 #8 [ffffa7bf4e7f3bd8] rt_mutex_futex_unlock+0x4f at ffffffff848c93ef
 #9 [ffffa7bf4e7f3c18] z3fold_zpool_free+0x580 at ffffffffc0f37680 [z3fold=
]
#10 [ffffa7bf4e7f3c78] zswap_free_entry+0x43 at ffffffff8427c863
#11 [ffffa7bf4e7f3c88] zswap_frontswap_invalidate_page+0x8a at ffffffff842=
7c96a
#12 [ffffa7bf4e7f3cb0] __frontswap_invalidate_page+0x48 at ffffffff8427c05=
8
#13 [ffffa7bf4e7f3cd8] swapcache_free_entries+0x1ee at ffffffff84276f8e
#14 [ffffa7bf4e7f3d20] free_swap_slot+0x9f at ffffffff8427b93f
#15 [ffffa7bf4e7f3d40] delete_from_swap_cache+0x61 at ffffffff84274651
#16 [ffffa7bf4e7f3d60] try_to_free_swap+0x70 at ffffffff84277550
#17 [ffffa7bf4e7f3d70] unuse_vma+0x55c at ffffffff842786cc
#18 [ffffa7bf4e7f3e90] try_to_unuse+0x139 at ffffffff84278eb9
#19 [ffffa7bf4e7f3ee8] __x64_sys_swapoff+0x1eb at ffffffff842798fb
#20 [ffffa7bf4e7f3f40] do_syscall_64+0x33 at ffffffff848b9ab3
#21 [ffffa7bf4e7f3f50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffff84a0=
007c
    RIP: 00007fdd9ce26d17  RSP: 00007ffe99f98238  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 00005625219e8b60  RCX: 00007fdd9ce26d17
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: 00005625219e8b60
    RBP: 0000000000000001   R8: 00007ffe99f982a0   R9: 0000000000000003
    R10: 00005625219e8721  R11: 0000000000000202  R12: 0000000000000001
    R13: 0000000000000000  R14: 00007ffe99f982a0  R15: 0000000000000000
    ORIG_RAX: 00000000000000a8  CS: 0033  SS: 002b
crash> bt -e
PID: 11850  TASK: ffff933ee67f2280  CPU: 1   COMMAND: "swapoff"

  KERNEL-MODE EXCEPTION FRAME AT: ffffa7bf4e7f3950
    [exception RIP: mark_wakeup_next_waiter+81]
    RIP: ffffffff840ea141  RSP: ffffa7bf4e7f3ba0  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000001
    RDX: 0000000000000001  RSI: ffffa7bf4e7f3bf0  RDI: 0000000000000001
    RBP: ffff933e5a7baba8   R8: ffff933f502c2000   R9: ffff933e5a7babc0
    R10: 0000000000000001  R11: ffffffff855938b8  R12: ffffa7bf4e7f3be0
    R13: ffffa7bf4e7f3bf0  R14: 0000000000000018  R15: ffff933ee67f2280
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
...
crash> gdb list *z3fold_zpool_free+0x580
0xffffffffc0f37680 is in z3fold_zpool_free (mm/z3fold.c:338).
warning: Source file is more recent than executable.
333
334             /* we are freeing a foreign handle if we are here */
335             zhdr->foreign_handles--;
336             is_free =3D true;
337             if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
338                     write_unlock(&slots->lock);
339                     return;
340             }
341             for (i =3D 0; i <=3D BUDDY_MASK; i++) {
342                     if (slots->slot[i]) {
crash> z3fold_buddy_slots -x ffff933e5a7bab80
struct z3fold_buddy_slots {
  slot =3D {0x0, 0x0, 0x0, 0x0},
  pool =3D 0xffff933e4b6d8e00,
  lock =3D {
    rtmutex =3D {
      wait_lock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 0x1
            },
            {
              locked =3D 0x1,
              pending =3D 0x0
            },
            {
              locked_pending =3D 0x1,
              tail =3D 0x0
            }
          }
        }
      },
      waiters =3D {
        rb_root =3D {
          rb_node =3D 0xffff933e5a7ba700
        },
        rb_leftmost =3D 0x0          <=3D=3D yup, that's why we've been ex=
ploding
      },
      owner =3D 0xffff933ee67f2280,  <=3D=3D yup, that's our exploding tas=
k
      save_state =3D 0x1
    },
    readers =3D {
      counter =3D 0x80000000
    }
  },
  poison =3D 0xfeedbabedeadbeef      <=3D=3D oh dear, that SHOULD be impos=
sible
}
crash>

 326         write_lock(&slots->lock);
 327         BUG_ON(READ_ONCE(slots->poison));  <=3D=3D we got past this l=
andmine..
 328         *(unsigned long *)handle =3D 0;
 329         if (zhdr->slots =3D=3D slots) {
 330                 write_unlock(&slots->lock);
 331                 return; /* simple case, nothing else to do */
 332         }
 333
 334         /* we are freeing a foreign handle if we are here */
 335         zhdr->foreign_handles--;
 336         is_free =3D true;
 337         if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
 338                 write_unlock(&slots->lock);  <=3D=3D ..and exploded h=
ere due to a corrupt lock
                                                        AND poison written=
 under read_lock()
                                                        has suddenly mater=
ialized as well!?!
=2D--
 mm/z3fold.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

=2D-- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -44,6 +44,7 @@
 #include <linux/zpool.h>
 #include <linux/magic.h>
 #include <linux/kmemleak.h>
+#include <linux/delay.h>

 /*
  * NCHUNKS_ORDER determines the internal allocation granularity, effectiv=
ely
@@ -92,6 +93,7 @@ struct z3fold_buddy_slots {
 	unsigned long slot[BUDDY_MASK + 1];
 	unsigned long pool; /* back link + flags */
 	rwlock_t lock;
+	unsigned long poison;
 };
 #define HANDLE_FLAG_MASK	(0x03)

@@ -220,6 +222,7 @@ static inline struct z3fold_buddy_slots
 		kmemleak_not_leak(slots);
 		slots->pool =3D (unsigned long)pool;
 		rwlock_init(&slots->lock);
+		slots->poison =3D 0;
 	}

 	return slots;
@@ -267,11 +270,13 @@ static inline struct z3fold_header *__ge
 			unsigned long addr;

 			read_lock(&slots->lock);
+			BUG_ON(READ_ONCE(slots->poison));
 			addr =3D *(unsigned long *)handle;
 			zhdr =3D (struct z3fold_header *)(addr & PAGE_MASK);
 			if (lock)
 				locked =3D z3fold_page_trylock(zhdr);
 			read_unlock(&slots->lock);
+			BUG_ON(READ_ONCE(slots->poison));
 			if (locked)
 				break;
 			cpu_relax();
@@ -319,6 +324,7 @@ static inline void free_handle(unsigned
 	zhdr =3D handle_to_z3fold_header(handle);
 	slots =3D handle_to_slots(handle);
 	write_lock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));          <=3D=3D poison was zero here
 	*(unsigned long *)handle =3D 0;
 	if (zhdr->slots =3D=3D slots) {
 		write_unlock(&slots->lock);
@@ -338,6 +344,10 @@ static inline void free_handle(unsigned
 			break;
 		}
 	}
+	if (is_free)
+		slots->poison =3D 0xdeaddeaddeaddead;
+	else
+		BUG_ON(READ_ONCE(slots->poison));
 	write_unlock(&slots->lock);

 	if (is_free) {
@@ -475,8 +485,10 @@ static unsigned long __encode_handle(str
 		h |=3D (zhdr->last_chunks << BUDDY_SHIFT);

 	write_lock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));
 	slots->slot[idx] =3D h;
 	write_unlock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));
 	return (unsigned long)&slots->slot[idx];
 }

@@ -492,8 +504,10 @@ static unsigned short handle_to_chunks(u
 	unsigned long addr;

 	read_lock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));
 	addr =3D *(unsigned long *)handle;
 	read_unlock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));
 	return (addr & ~PAGE_MASK) >> BUDDY_SHIFT;
 }

@@ -509,10 +523,12 @@ static enum buddy handle_to_buddy(unsign
 	unsigned long addr;

 	read_lock(&slots->lock);
+	BUG_ON(READ_ONCE(slots->poison));
 	WARN_ON(handle & (1 << PAGE_HEADLESS));
 	addr =3D *(unsigned long *)handle;
 	read_unlock(&slots->lock);
 	zhdr =3D (struct z3fold_header *)(addr & PAGE_MASK);
+	BUG_ON(READ_ONCE(slots->poison));
 	return (addr - zhdr->first_num) & BUDDY_MASK;
 }

@@ -538,6 +554,7 @@ static void __release_z3fold_page(struct

 	/* If there are no foreign handles, free the handles array */
 	read_lock(&zhdr->slots->lock);
+	BUG_ON(READ_ONCE(zhdr->slots->poison));
 	for (i =3D 0; i <=3D BUDDY_MASK; i++) {
 		if (zhdr->slots->slot[i]) {
 			is_free =3D false;
@@ -546,6 +563,11 @@ static void __release_z3fold_page(struct
 	}
 	if (!is_free)
 		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
+	else {
+		zhdr->slots->poison =3D 0xfeedbabedeadbeef;
+//		usleep_range(100, 200);
+//		zhdr->slots->poison =3D 0;
+	}
 	read_unlock(&zhdr->slots->lock);

 	if (is_free)
@@ -750,11 +772,14 @@ static struct z3fold_header *compact_sin
 		new_zhdr->foreign_handles++;
 		memcpy(q, p, sz);
 		write_lock(&zhdr->slots->lock);
+		BUG_ON(READ_ONCE(zhdr->slots->poison));
 		*(unsigned long *)old_handle =3D (unsigned long)new_zhdr +
 			__idx(new_zhdr, new_bud);
 		if (new_bud =3D=3D LAST)
 			*(unsigned long *)old_handle |=3D
 					(new_zhdr->last_chunks << BUDDY_SHIFT);
+		BUG_ON(READ_ONCE(zhdr->slots->poison));
+		BUG_ON(READ_ONCE(new_zhdr->slots->poison));
 		write_unlock(&zhdr->slots->lock);
 		add_to_unbuddied(pool, new_zhdr);
 		z3fold_page_unlock(new_zhdr);

