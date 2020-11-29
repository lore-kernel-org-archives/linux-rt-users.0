Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D7DC3E8C5
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761A020771
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eRZqg7hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgK2JXu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Nov 2020 04:23:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:40403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2JXt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Nov 2020 04:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606641695;
        bh=PMGPeOb1/+9oXMNrHGoQTO0jg3TCyx67VHl7NFtKus0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=eRZqg7hLaT1s3VIVbvd972ldV11SR3w7pOQ9lwgpHQLQeRFubYLjBEw4HeWYPHBcF
         XSM5UJ1RVPhgTLerJlYxeZPVczKAkVkXRNb7YBGU0NL4IRfSjokLfZtAKvjAiLxpiM
         am7lLQJGchxbJQwllcPJoKWyWa12X+kqVCPeUuCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.83]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1kr13j1k5s-007l3b; Sun, 29
 Nov 2020 10:21:35 +0100
Message-ID: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 29 Nov 2020 10:21:33 +0100
In-Reply-To: <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GmjNT2HpE8rDEjh+40luuj9gtoGfFGc/krPqBwIyo9L7eaDBkFF
 Ics5SkMg1EIhV5O7dlW/B98VQ7By2dq/APUs8DZbzN5MF2gylQM0hbg7dNnRYYfKfQSLCFW
 NYtynQp+b4rcBHP1TVlcMQjgwCpekr3TY0sT20hfAwW9XtJkXjRildmYHuxQ3ZRJ7lfa0KX
 B/SUN/Udfk1HqGpUn7fnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BWqesIVaxb0=:2frNT0KDmeX30q+FDpL1FF
 7chXWWXp180O05kHQ68cuDh1XuLSQXk8+zYg3DA7N0iMXuoGiBuCU7MMx6CH6trfdEE5tBfkn
 mf45fVgV8EnPV3IXRNStiCggi1s11BBeCs7QJPJMY/pA0dH7avNd1iTROXkjxW1NP0fdq7mJg
 EbIFEuiNChvdY0ZX/DIpUvrZHK7YK6gJNndCayM1Uy/drmNJ377+5ISQ0NpFQImvkRqlZmNqS
 G0cQnMfRGP8Yaxx5ZZa0o/UBIRB0xuz3A3BKnueXqSASUy1zmAu8v9Sgwynv11OZ95YaKwb8o
 nXZJJWM4YU3rU4EqEmMVrjxVz3Xd2TYwcKZn3UBsUEZbJAQe787svrpPEK0dgRJBGD8ghfgwb
 imfEhScejPGA57SKELh28Du3svhVdIy6zb4gugaUYhHaqoN3nKD3f1exLuwnyeYh1Eayp0k1n
 SNMgcYqM+gyGX2vagk3Dcns8Mc0juZiZV2tqaKZJhYMEQt+8e8Bp76PwgPj4j86A9S8ciJcBd
 /QBirQizcrI0XLrUvZq58ROOAxNmeewJQ8uI6jHoDLE4N3KGbqJOoGGKAEDCwvmaGkD2IY3eX
 NbkzMzicT5V0zsqGMdWV3xDirlIKyuffzhBGCAuGI0Kub3tIFmt9tF6s7/lwHnAofbBTmxaKq
 RDTb9AOEedgcz+9z4c3EEr40RIdwApQFwKH7+Z4/Wj9QY1rZ8oTJuRk78a1DVyyafKcFjCmLG
 PHFEO/hZFnCdjPF+HAt2rIZtO9nkCsc8LUpF38hfF5DeFj892Ke31eXlBOqv1P7jZsiImPV+5
 Td/5HBzvzC4yqm2Ej9fkvplJfkdsrDJWSJKWwSL2yQ4KAC/jmTz6nK/5rYrJvTjnnJsoyMTjA
 X2jqkPefddy1J+kdwR4g==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2020-11-29 at 08:48 +0100, Mike Galbraith wrote:
> On Sun, 2020-11-29 at 07:41 +0100, Mike Galbraith wrote:
> > On Sat, 2020-11-28 at 15:27 +0100, Oleksandr Natalenko wrote:
> > >
> > > > > Shouldn't the list manipulation be protected with
> > > > > local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
> > >
> > > Totally untested:
> >
> > Hrm, the thing doesn't seem to care deeply about preemption being
> > disabled, so adding another lock may be overkill.  It looks like you
> > could get the job done via migrate_disable()+this_cpu_ptr().
>
> There is however an ever so tiny chance that I'm wrong about that :)

Or not, your local_lock+this_cpu_ptr version exploded too.

Perhaps there's a bit of non-rt related racy racy going on in zswap
thingy that makes swap an even less wonderful idea for RT than usual.

crash.rt> bt -s
PID: 32399  TASK: ffff8e4528cd8000  CPU: 4   COMMAND: "cc1"
 #0 [ffff9f0f1228f488] machine_kexec+366 at ffffffff8c05f87e
 #1 [ffff9f0f1228f4d0] __crash_kexec+210 at ffffffff8c14c052
 #2 [ffff9f0f1228f590] crash_kexec+48 at ffffffff8c14d240
 #3 [ffff9f0f1228f5a0] oops_end+202 at ffffffff8c02680a
 #4 [ffff9f0f1228f5c0] exc_general_protection+403 at ffffffff8c8be413
 #5 [ffff9f0f1228f650] asm_exc_general_protection+30 at ffffffff8ca00a0e
 #6 [ffff9f0f1228f6d8] __z3fold_alloc+118 at ffffffff8c2b4ea6
 #7 [ffff9f0f1228f760] z3fold_zpool_malloc+115 at ffffffff8c2b56c3
 #8 [ffff9f0f1228f7c8] zswap_frontswap_store+789 at ffffffff8c27d335
 #9 [ffff9f0f1228f828] __frontswap_store+110 at ffffffff8c27bafe
#10 [ffff9f0f1228f858] swap_writepage+55 at ffffffff8c273b17
#11 [ffff9f0f1228f870] shmem_writepage+612 at ffffffff8c232964
#12 [ffff9f0f1228f8a8] pageout+210 at ffffffff8c225f12
#13 [ffff9f0f1228f928] shrink_page_list+2428 at ffffffff8c22744c
#14 [ffff9f0f1228f9c0] shrink_inactive_list+534 at ffffffff8c229746
#15 [ffff9f0f1228fa68] shrink_lruvec+927 at ffffffff8c22a35f
#16 [ffff9f0f1228fb78] shrink_node+567 at ffffffff8c22a7d7
#17 [ffff9f0f1228fbf8] do_try_to_free_pages+185 at ffffffff8c22ad39
#18 [ffff9f0f1228fc40] try_to_free_pages+201 at ffffffff8c22c239
#19 [ffff9f0f1228fcd0] __alloc_pages_slowpath.constprop.111+1056 at ffffff=
ff8c26eb70
#20 [ffff9f0f1228fda8] __alloc_pages_nodemask+786 at ffffffff8c26f7e2
#21 [ffff9f0f1228fe00] alloc_pages_vma+309 at ffffffff8c288f15
#22 [ffff9f0f1228fe40] handle_mm_fault+1687 at ffffffff8c24ee97
#23 [ffff9f0f1228fef8] exc_page_fault+821 at ffffffff8c8c1be5
#24 [ffff9f0f1228ff50] asm_exc_page_fault+30 at ffffffff8ca00ace
    RIP: 00000000010fea3b  RSP: 00007ffc88ad5a50  RFLAGS: 00010206
    RAX: 00007f4a548d1638  RBX: 00007f4a5c0c5000  RCX: 0000000000000000
    RDX: 0000000000020000  RSI: 000000000000000f  RDI: 0000000000018001
    RBP: 00007f4a5547a000   R8: 0000000000018000   R9: 0000000000240000
    R10: 00007f4a5523a000  R11: 0000000000098628  R12: 00007f4a548d1638
    R13: 00007f4a54ab1478  R14: 000000005002ac29  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
crash.rt>


