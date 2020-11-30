Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9EBC64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA3820725
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FnXWAuTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgK3OpF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:45:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:46127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgK3OpF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 09:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606747368;
        bh=mHchiFlGcnK77otjb4Iyu/vxjRJLoM6L57UebudkiWE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=FnXWAuTnfsjd1ZkBZMQal/zB4BbiWt7CHMOgni+TXAvcn5SjYkwJqXjX9kyMN+xM1
         8VQGSgB+lVtiLc2qj5dg0gPE32bMkrgdKYFarzv2VMPMLajQyQRBeyW7yucPJhDZcw
         QnxbS9kKOVvEVys56qWe6BCXyDgvdryJHI0rndPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1k4Tat1qXb-012pQV; Mon, 30
 Nov 2020 15:42:48 +0100
Message-ID: <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 15:42:46 +0100
In-Reply-To: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hRq1fml9WWHmv2oex1oi01QDiyxElNollCo264XN9LdcTPGnDBv
 0a7HAZjKgjCzCtG8UuW0hUAwnZXNPAWlCOUdPmfpl/XZJEJw1NKp4FTE/+wOAbp4fJ1g43o
 C8HNIJnonTL802HYP6o8BVZ4g17rFdpjdVZIfVw5XZTg6asqz8S7WEWEIAk4qF6LyMOE37A
 GJiDU+ALReiUxaccqJ8Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+fW0FMUqYc=:BK9WEj3NrUrxvyXsDhRhdr
 0+L8x/jYbNRWAndRQYT0blUrNG+C7ihaTuc/9H+yR2YU7dVoVQeki657m1pLKe8VOerOwvuZ4
 ob1/UxyKz/KZRDuuS2VU+f8C/gQyMCws37QwCdioJIzkK+V8Onb/8LQ+jjmSgBgCVtdMJkDqK
 Vj/Isou2l32q4UWiMKFC5hUyqaF/bmfRxQbaGYCNxxX9F8c/BuyjgbWEAX9LJB1ZnkQ5PhKJC
 j0IWfQNc/DDBBHVL/V7X5C3VyNKWKLScuFswyG4mG/SnD6j+aGTOjQqMVYQH60JVUe7IltS4E
 t7UFC8LbD4rerFfxydv11pHaZWO7qhclIx44YUzaJrcJwGtNeUEGS54cdDR7eNV12Zz6upNUq
 RjqYO7wphYTaXGrA/8xIRLyl+QSLeNmL9w8oeCZs0fUPppeYXO+R4Tcy279tCgUfPF+SRskTK
 RZ2L1iTsYb8Lvpu+awnToCtd6szDoZpXmXapUHk6oOnoLK3AssimIGYFWQlcsZphZP4MVJefR
 yaIozRSGV/oIfc5OjDWHF9cqjMQiAVmx8PKOnE2bHsfky50nAjqr+TW/oUdBQ3bKShK3+Ao78
 DmLeTcyscHQUdIOseO1Xu6kkBAXtsEGbTDpM9jbk7GNfTxQsJjfGQQbiNIpDyy/Z4AxQ9JeFr
 7OsbKpylqQAaowMIVgGTjaModf4JW5TJii158CLrg7Yk0CyCKbK7suQKkuRK+n4jHQB8QV4Pq
 8L0cmirpWuig+GmPnPxvDeBQNI9IJfSWFDNL0r9xqFL8f5QNHSZxZvwZmqe2moo/YsHD943I5
 K4A65cHd5Ba147J6XLyOuIhHOn0GypjlfL+LCwTrTYnIwRGdSfTIyaQnoLCNMH0KTCRsSZK4d
 Dho5LA25w55mtyEd5Isw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 14:20 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-29 12:41:14 [+0100], Mike Galbraith wrote:
> > On Sun, 2020-11-29 at 12:29 +0100, Oleksandr Natalenko wrote:
> > >
> > > Ummm so do compressors explode under non-rt kernel in your tests as
> > > well, or it is just -rt that triggers this?
> >
> > I only tested a non-rt kernel with z3fold, which worked just fine.
>
> I tried this and it did not not explode yet. Mike, can you please
> confirm?

This explodes in write_unlock() as mine did.   Oleksandr's local_lock()
variant explodes in the lock he added.  (ew, corruption)

I think I'll try a stable-rt tree.  This master tree _should_ be fine
given it seems to work just peachy for everything else, but my box is
the only one making boom... and also NOT making boom with the zbud
compressor.  Hrmph.

crash.rt> bt -sx
PID: 27961  TASK: ffff8f6ad5344500  CPU: 4   COMMAND: "oom01"
 #0 [ffffa439d4747708] machine_kexec+0x16e at ffffffffbb05eace
 #1 [ffffa439d4747750] __crash_kexec+0x5a at ffffffffbb145e5a
 #2 [ffffa439d4747810] crash_kexec+0x24 at ffffffffbb147004
 #3 [ffffa439d4747818] oops_end+0x93 at ffffffffbb025c03
 #4 [ffffa439d4747838] exc_page_fault+0x6b at ffffffffbb9011bb
 #5 [ffffa439d4747860] asm_exc_page_fault+0x1e at ffffffffbba00ace
 #6 [ffffa439d47478e8] mark_wakeup_next_waiter+0x51 at ffffffffbb0e6781
 #7 [ffffa439d4747950] rt_mutex_futex_unlock+0x50 at ffffffffbb90bae0
 #8 [ffffa439d4747990] z3fold_free+0x4a8 at ffffffffbb2bf8a8
 #9 [ffffa439d47479f0] zswap_free_entry+0x82 at ffffffffbb285dd2
#10 [ffffa439d4747a08] zswap_frontswap_invalidate_page+0x8c at ffffffffbb2=
85edc
#11 [ffffa439d4747a30] __frontswap_invalidate_page+0x4e at ffffffffbb28548=
e
#12 [ffffa439d4747a58] swap_range_free.constprop.0+0x9e at ffffffffbb27fd4=
e
#13 [ffffa439d4747a78] swapcache_free_entries+0x10d at ffffffffbb28101d
#14 [ffffa439d4747ac0] free_swap_slot+0xac at ffffffffbb284d8c
#15 [ffffa439d4747ae0] __swap_entry_free+0x8f at ffffffffbb2808ff
#16 [ffffa439d4747b08] free_swap_and_cache+0x3b at ffffffffbb2829db
#17 [ffffa439d4747b38] zap_pte_range+0x164 at ffffffffbb258004
#18 [ffffa439d4747bc0] unmap_page_range+0x1dd at ffffffffbb258b6d
#19 [ffffa439d4747c38] __oom_reap_task_mm+0xd5 at ffffffffbb2235c5
#20 [ffffa439d4747d08] exit_mmap+0x154 at ffffffffbb264084
#21 [ffffa439d4747da0] mmput+0x4e at ffffffffbb07e66e
#22 [ffffa439d4747db0] exit_mm+0x172 at ffffffffbb088372
#23 [ffffa439d4747df0] do_exit+0x1a8 at ffffffffbb088588
#24 [ffffa439d4747e20] do_group_exit+0x39 at ffffffffbb0888a9
#25 [ffffa439d4747e48] get_signal+0x155 at ffffffffbb096ef5
#26 [ffffa439d4747e98] arch_do_signal+0x1a at ffffffffbb0224ba
#27 [ffffa439d4747f18] exit_to_user_mode_loop+0xc7 at ffffffffbb11c037
#28 [ffffa439d4747f38] exit_to_user_mode_prepare+0x6a at ffffffffbb11c12a
#29 [ffffa439d4747f48] irqentry_exit_to_user_mode+0x5 at ffffffffbb901ae5
#30 [ffffa439d4747f50] asm_exc_page_fault+0x1e at ffffffffbba00ace
    RIP: 0000000000414300  RSP: 00007f193033bec0  RFLAGS: 00010206
    RAX: 0000000000001000  RBX: 00000000c0000000  RCX: 00000000a6e6a000
    RDX: 00007f19159a4000  RSI: 00000000c0000000  RDI: 0000000000000000
    RBP: 00007f186eb3a000   R8: ffffffffffffffff   R9: 0000000000000000
    R10: 0000000000000022  R11: 0000000000000246  R12: 0000000000001000
    R13: 0000000000000001  R14: 0000000000000001  R15: 00007ffd0ffb96d0
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

>

