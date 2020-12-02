Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB2C64E8A
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07F2221E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgLBCct (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:32:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:57673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgLBCct (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 21:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606876230;
        bh=JYWSBaR1m/qmjRsttwsKbWrSt3nUWN3Ng8/mnZm85V8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=b2Q+cPxczL1TkRcdAjEIsBjf+fyz65ppm09yz/r8pywbo3UPhS9hJns4bi+b9c5Zd
         jSUBDeNd4jwtOXkbwSInQpgVAiYCD23iUF0RxOpmG+uIZdHdQe6narvM7ejECDhLXB
         mm2FQtUkB/iDjMizSHB/Ha9e84du8NTGo5hqVi4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1ktKT92LSL-0098c2; Wed, 02
 Dec 2020 03:30:30 +0100
Message-ID: <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Wed, 02 Dec 2020 03:30:27 +0100
In-Reply-To: <20201130160327.ov32m4rapk4h432a@linutronix.de>
References: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2fg4PjjaPSM9CHEZNboKDwHcR5xonHW8ZaHzqV1yboxM3sWNnzA
 VGrL/qwf+QbIUSGH+mt2ByRAyZiKESPIig/l8SyrJ9uX8TabZkvA+df649ktXJVhK30I4ko
 iFY9RhAIkcbm/2s403pguhtOENvjk1dv0iw17Q0AYffH2jDLvHOozsj0WguPBDirhSZRdK9
 R3erfj9wPFbqUq16P8/RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h104xzhMY44=:27C1c2a7/QqQJ9Iiq3GnBl
 4HgpN+xOEoU06eaR5mrirKK7DpO7+vUBq1LsUDU03fuK/GHeDfpLTzYtfcvxnfXiPoYQftXNB
 rbYpKGlQ2vC1kLdHl+Gn9KQqOOFm18sau3MZ1PnwrthH/AehrdMkDDcKe9jnOCcZZP/GJmxiy
 /LB/uveGdEaeOvVYL7riwlhF02McfEB771D0f+BUkW1YDcuhuHlA01ksFJFCkpce1aZpWhUUX
 1YbIIeZYXygtI2wxkB8gWi85kmr7qatcx5QAKuu2aHuFhPw3MNI4ytx1rSYGKEFDQPkWc+OlP
 QC042w4N7dDbyRPNvCTcEClRZdOzRmWJ0RYK20QfMGmZycbumNzBqQ7fVWpdldyGsT4YGUyZM
 bxlwckqs/g6BUe4sE2Q9u1aQHpYLLQRxqV7fuBCkR3fQC6MsMdmPcgmH3tb6aFeiFak6TWqN6
 3YCZ+/r8mhxj0EH6UEmvPXw3fA2oHkxfDxTOolvvTYtzAfQ9Vu/dJeX3h/aC4vTN6e6wFnX7+
 +OaPgg2zmAileKtwZzgaupELLFyayyPTSdphS4In4USI13hbqb3SYD7PnJfsCsnzlKFU5ykaS
 v9A9BCOgYdDBPFyiuN0ufg2rsZttwqd3lDG9cLg9biuFSV/4v+096yJPhiead2vCLyDZ+sSXt
 zANYRclzZfJS49rAMmHUIMsjeF0fukqno/+JdxdPyFwC6uW4ypH72RJCfVXqcgggbAfWGY+aa
 s3mHso7eOZgKBJxRgq1B2qyuIg8Uj7KcEFlnqhmbNubkIG6+5uQQpi1oZOMnrxd3Bj6hLKc9N
 hAAJK3Saa46urI7Nkps8LbDu5M68IIY0qlauvPoAmG7ouF4n/GjaQKzp4emB+G4w2O+n/NxJq
 ATs+ETfmMkOiPk/0TpyQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 17:03 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-30 16:01:11 [+0100], Mike Galbraith wrote:
> > On Mon, 2020-11-30 at 15:52 +0100, Sebastian Andrzej Siewior wrote:
> > > How do you test this? I triggered a few oom-killer and I have here g=
it
> > > gc running for a few hours now=E2=80=A6 Everything is fine.
> >
> > In an LTP install, ./runltp -f mm.  Shortly after box starts swapping
> > insanely, it explodes quite reliably here with either z3fold or
> > zsmalloc.. but not with zbud.
>
> This just passed. It however killed my git-gc task which wasn't done.
> Let me try tomorrow with your config.

What I'm seeing is the below.  rt_mutex_has_waiters() says yup we have
a waiter, rt_mutex_top_waiter() emits the missing cached leftmost, and
rt_mutex_dequeue_pi() chokes on it.  Lock is buggered.

[  894.376962] BUG: kernel NULL pointer dereference, address: 000000000000=
0018
[  894.377639] #PF: supervisor read access in kernel mode
[  894.378130] #PF: error_code(0x0000) - not-present page
[  894.378735] PGD 0 P4D 0
[  894.378974] Oops: 0000 [#1] PREEMPT_RT SMP PTI
[  894.379384] CPU: 2 PID: 78 Comm: oom_reaper Kdump: loaded Tainted: G   =
         E     5.9.11-rt20-rt #9
[  894.380253] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  894.381352] RIP: 0010:mark_wakeup_next_waiter+0x51/0x150
[  894.381869] Code: 00 00 49 89 f5 e8 9f 1c 7c 00 48 8b 5d 10 48 85 db 74=
 0a 48 3b 6b 38 0f 85 00 01 00 00 65 4c 8b 3c 25 c0 8d 01 00 4c 8d 73 18 <=
4c> 39 73 18 0f 85 94 00 00 00 65 48 8b 3c 25 c0 8d 01 00 48 8b 87
[  894.383640] RSP: 0018:ffffb792802cfb18 EFLAGS: 00010046
[  894.384135] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000=
000001
[  894.384804] RDX: 0000000000000001 RSI: ffffb792802cfb68 RDI: 0000000000=
000001
[  894.385473] RBP: ffff997b4e508628 R08: ffff997b39075000 R09: ffff997a47=
800db0
[  894.386134] R10: 0000000000000000 R11: ffffffff8a58f4d8 R12: ffffb79280=
2cfb58
[  894.387030] R13: ffffb792802cfb68 R14: 0000000000000018 R15: ffff997a7f=
1d3300
[  894.387715] FS:  0000000000000000(0000) GS:ffff997b77c80000(0000) knlGS=
:0000000000000000
[  894.388476] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  894.389209] CR2: 0000000000000018 CR3: 00000001cc156006 CR4: 0000000000=
1706e0
[  894.389881] Call Trace:
[  894.390127]  rt_mutex_futex_unlock+0x4f/0x90
[  894.390547]  z3fold_zpool_free+0x539/0x5c0
[  894.390930]  zswap_free_entry+0x43/0x50
[  894.391193]  zswap_frontswap_invalidate_page+0x8a/0x90
[  894.391544]  __frontswap_invalidate_page+0x48/0x80
[  894.391875]  swapcache_free_entries+0x1ee/0x330
[  894.392189]  ? rt_mutex_futex_unlock+0x65/0x90
[  894.392502]  free_swap_slot+0xad/0xc0
[  894.392757]  __swap_entry_free+0x70/0x90
[  894.393046]  free_swap_and_cache+0x39/0xe0
[  894.393351]  unmap_page_range+0x5e1/0xb30
[  894.393646]  ? flush_tlb_mm_range+0xfb/0x170
[  894.393965]  __oom_reap_task_mm+0xb2/0x170
[  894.394254]  ? __switch_to+0x12a/0x520
[  894.394514]  oom_reaper+0x119/0x540
[  894.394756]  ? wait_woken+0xa0/0xa0
[  894.394997]  ? __oom_reap_task_mm+0x170/0x170
[  894.395297]  kthread+0x169/0x180
[  894.395535]  ? kthread_park+0x90/0x90
[  894.395867]  ret_from_fork+0x22/0x30
[  894.396252] Modules linked in: ebtable_filter(E) ebtables(E) uinput(E) =
fuse(E) rpcsec_gss_krb5(E) nfsv4(E) xt_comment(E) dns_resolver(E) nfs(E) n=
f_log_ipv6(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) nfs_ss=
c(E) fscache(E>
[  894.396280]  cryptd(E) glue_helper(E) pcspkr(E) nfsd(E) auth_rpcgss(E) =
nfs_acl(E) lockd(E) grace(E) sunrpc(E) sch_fq_codel(E) hid_generic(E) usbh=
id(E) ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) virtio_console(E)=
 virtio_blk(E)>
[  894.406791] Dumping ftrace buffer:
[  894.407037]    (ftrace buffer empty)
[  894.407293] CR2: 0000000000000018

crash> gdb list *mark_wakeup_next_waiter+0x51
0xffffffff810e87e1 is in mark_wakeup_next_waiter (kernel/locking/rtmutex.c=
:362).
357     }
358
359     static void
360     rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_wait=
er *waiter)
361     {
362             if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
363                     return;
364
365             rb_erase_cached(&waiter->pi_tree_entry, &task->pi_waiters)=
;
366             RB_CLEAR_NODE(&waiter->pi_tree_entry);

crash> rwlock_t -x 0xffff997b4e508628
struct rwlock_t {
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
        rb_node =3D 0xffff997b4e508580
      },
      rb_leftmost =3D 0x0
    },
    owner =3D 0xffff997a7f1d3300,
    save_state =3D 0x1
  },
  readers =3D {
    counter =3D 0x80000000
  }
}
crash> rb_root 0xffff997b4e508580
struct rb_root {
  rb_node =3D 0x0
}

