Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BEC3E8C5
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 07:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD61207CD
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 07:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ew/PvgT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgK2HvN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:51:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:55057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2HvN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Nov 2020 02:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606636136;
        bh=nNgEG9W3/dgKx7pGvBI1VNzAAdYXJJj4vN/rQUPGggg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ew/PvgT/S8d7o33a2NMGzGkmsX3A+wG2snNirwEUedpXleVKRMb6AYb1Ts7IDDp1y
         AKzA0KQeWLgdqrmRzmaBQJaU2ARMN5zxjyiqrAXrVCqxglVnmHLO7KXJGpX3aMWe1D
         Fv8NUKAxRYCHegz4efA0rAymXbD8Gl6pbGQB5CA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.83]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1kU6DP1cmV-00Lpna; Sun, 29
 Nov 2020 08:48:56 +0100
Message-ID: <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 29 Nov 2020 08:48:55 +0100
In-Reply-To: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2s2Ig5gRyWZy9b0M8Nd1i3yTCSuJCmVCkdV7N2Z1b+QZR6GlNCQ
 gYAi3mUoJbjb3TE9YiiZCziwoCmVnPjsGQFWCIbl9BW0D04w8yYvhwNKN/zDEgWdTXtgutW
 10uw5I2Xe76rH+HAyGS53pLOhykN2pql+ZF//2+Yi0KDN8voHlBE8szwq/Oxpa/4giljffj
 J7J3KsvHPuoJbN/JpE2Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9bhgqDbcMzo=:p1nEDMgaPH73Vojta/5ixz
 oyfuwXPYpqOBa89CLx7Ki3+q4Ev3LsOYA3QFsiduk8+rmcjuoVsC/n37MoJqhhLavZcUgdnpm
 09Pb/r9LDlEWqacAqgutumMICTFZfYh0v1M4Vg3AUGnxcwOISXFZxicLzmsXWrpBYnzEay+n1
 6gmA3QlE3mSpLEHpjKSvRHpzsPAhTUhRcv+Pv73/T6m8SEp2endrIiZUsa9OpacTc5SDRf9zo
 95F2H+o53FY2GwOPQmV4w2WzF5AIGVxpvJ+Q4DHHOF2f3oWI1gvzP1jhns6tKHxPFBYbL+Pwv
 F9AIbnADBJchPxwU0c6o7zW96plrpbztcDIIJYFIqKA7djcbvtmXSWR+Ev8flxvAyFjpvz580
 faEcaksNXzz4s1YtN9tM/LKilBudJKy0vmuZfmCHZtdNvi9Szf2CqMBPuwCEkvdYcP70PPhCS
 S6cQBMgYcojKCc5ZdxwU4kkFXMZACkki6XZhM+ka0Ww7AOCUB+fj1A09itKShsV3G7Rg6IUPY
 5wKOy1QX8bBFXdhN/If1aS1fgl/NggWYvoSv/cKhXbBaKBd6dSJZWc17eZZrQhe1RgbO2gFcd
 9LZd8jVXMpT8Db76/Swzc7KSTdFrVoTo9LbK4h+7LqfIQKUuL4GY+cCWOKQ7k+W6KfhSOY+e7
 LKl3k2CXLNyUVE/aLtbFqfUQrrcmnfNEa0IVyT5108TQDhBqvF8/CQNeEqBiRtGwm7w1Ukd8M
 LtD5TO/KVdcp12uERJaOpPdSdey7cwAYYumx/1NAtFu5FzSYzNH5BK5szjqOn2A4RwhZFNKOx
 zlPCr9jTridCrnw59252CFQSrn05sMh+sGnHQO9lsAqbJdtTseFGbanAldjWTY4oh6A1cA3ZH
 qxLzqMjHnIIOPeUMhLQw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2020-11-29 at 07:41 +0100, Mike Galbraith wrote:
> On Sat, 2020-11-28 at 15:27 +0100, Oleksandr Natalenko wrote:
> >
> > > > Shouldn't the list manipulation be protected with
> > > > local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
> >
> > Totally untested:
>
> Hrm, the thing doesn't seem to care deeply about preemption being
> disabled, so adding another lock may be overkill.  It looks like you
> could get the job done via migrate_disable()+this_cpu_ptr().

There is however an ever so tiny chance that I'm wrong about that :)

crash.rt> bt -s
PID: 6699   TASK: ffff913c464b5640  CPU: 0   COMMAND: "oom01"
 #0 [ffffb6b94adff6f0] machine_kexec+366 at ffffffffbd05f87e
 #1 [ffffb6b94adff738] __crash_kexec+210 at ffffffffbd14c052
 #2 [ffffb6b94adff7f8] crash_kexec+48 at ffffffffbd14d240
 #3 [ffffb6b94adff808] oops_end+202 at ffffffffbd02680a
 #4 [ffffb6b94adff828] no_context+333 at ffffffffbd06d7ed
 #5 [ffffb6b94adff888] exc_page_fault+696 at ffffffffbd8c0b68
 #6 [ffffb6b94adff8e0] asm_exc_page_fault+30 at ffffffffbda00ace
 #7 [ffffb6b94adff968] mark_wakeup_next_waiter+81 at ffffffffbd0ea1e1
 #8 [ffffb6b94adff9c8] rt_mutex_futex_unlock+79 at ffffffffbd8cc3cf
 #9 [ffffb6b94adffa08] z3fold_zpool_free+1319 at ffffffffbd2b6b17
#10 [ffffb6b94adffa68] zswap_free_entry+67 at ffffffffbd27c6f3
#11 [ffffb6b94adffa78] zswap_frontswap_invalidate_page+138 at ffffffffbd27=
c7fa
#12 [ffffb6b94adffaa0] __frontswap_invalidate_page+72 at ffffffffbd27bee8
#13 [ffffb6b94adffac8] swapcache_free_entries+494 at ffffffffbd276e1e
#14 [ffffb6b94adffb10] free_swap_slot+173 at ffffffffbd27b7dd
#15 [ffffb6b94adffb30] __swap_entry_free+112 at ffffffffbd2768d0
#16 [ffffb6b94adffb58] free_swap_and_cache+57 at ffffffffbd278939
#17 [ffffb6b94adffb80] unmap_page_range+1485 at ffffffffbd24c52d
#18 [ffffb6b94adffc40] __oom_reap_task_mm+178 at ffffffffbd218f02
#19 [ffffb6b94adffd10] exit_mmap+339 at ffffffffbd257da3
#20 [ffffb6b94adffdb0] mmput+78 at ffffffffbd07fe7e
#21 [ffffb6b94adffdc0] do_exit+822 at ffffffffbd089bc6
#22 [ffffb6b94adffe28] do_group_exit+71 at ffffffffbd08a547
#23 [ffffb6b94adffe50] get_signal+319 at ffffffffbd0979ff
#24 [ffffb6b94adffe98] arch_do_signal+30 at ffffffffbd022cbe
#25 [ffffb6b94adfff28] exit_to_user_mode_prepare+293 at ffffffffbd1223e5
#26 [ffffb6b94adfff48] irqentry_exit_to_user_mode+5 at ffffffffbd8c1675
#27 [ffffb6b94adfff50] asm_exc_page_fault+30 at ffffffffbda00ace
    RIP: 0000000000414300  RSP: 00007f5ddf065ec0  RFLAGS: 00010206
    RAX: 0000000000001000  RBX: 00000000c0000000  RCX: 00000000adf28000
    RDX: 00007f5d0bf8d000  RSI: 00000000c0000000  RDI: 0000000000000000
    RBP: 00007f5c5e065000   R8: ffffffffffffffff   R9: 0000000000000000
    R10: 0000000000000022  R11: 0000000000000246  R12: 0000000000001000
    R13: 0000000000000001  R14: 0000000000000001  R15: 00007ffc953ebcd0
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
crash.rt>


