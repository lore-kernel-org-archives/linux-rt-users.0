Return-Path: <SRS0=BxWt=DU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D62C433E7
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Oct 2020 03:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2672320797
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Oct 2020 03:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LF/Rpxfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJMDAb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 23:00:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:45189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgJMDAa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 23:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602558019;
        bh=o8Bk9I/Jh6aJVgAJo/80Zhfeu3fuUmx/2h4DjtjCY6g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=LF/RpxfoNlbrTop/AJenkq7HzKZRTIJs/Cp/i5OBOMrgLKm9FsMnJ7JqbYafrIbBn
         KUAq0ltADwD5xCUDzbMcp2R9kBiR/baDqcNs2MVye7JotNu+6gxv5M3kxmE185DdW3
         +emHjnsuIm8Bwgy+WhpA3JvOxl9tegMMtyPvXgQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.248]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1kgTuB2hNE-00GZNL; Tue, 13
 Oct 2020 05:00:19 +0200
Message-ID: <eb7ebf5a02208c0d2880e304f34ee1f25983ce97.camel@gmx.de>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Oct 2020 05:00:18 +0200
In-Reply-To: <90459a197f5dad3b17ff8c484cc315c9b054f5c0.camel@gmx.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
         <20201012164553.kkk7aaeyb3y4wvyh@linutronix.de>
         <90459a197f5dad3b17ff8c484cc315c9b054f5c0.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:htRTdghFIMIyb/LlpergTCR5rEc97PgFaxXREJ69kYtQhoNB3uM
 pcCnHaOq+t5TPk6Yv9cX03UX2XvzvXLscV5r9FCna3TTkUZkpJWOzuJMOgdRxLthLCFL/13
 wHKRf5Q6SnHFXJH8RSK6Pfcd6Reps6gMoUGbd0FaLXpgJqWqEbQ/iO1h43rhHKBplCkYhAJ
 6CM/ibWQOSwOIhBV+PgUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1oV34MMKk2M=:jDo6Z9S8s+9IOfcgrK++N1
 IQSjENN5bJPcpVbgtel/rKaXnculzhv8QRnzmdQ8Wbv7YXZNNhxP/D+Xs09gp/mKV4wil/pjD
 JKQ/03nOSu1uhKogLtfgNqOiBa1P83sEDbvTX/dI8wa8MXJRysEJAkEq0BXVIfMj/4vNNBEJh
 lD9YQDlvSnxNkFDp2SDJmMOzjjNCk43CkkwwQkhOFZpOckqy6dxq4o46LkZNGaEz6mAVgSXJB
 QYkBqerwi4z2qqavE7X8j/J3YOrg33CQtLURgFqfMG0CHeF++0VAFXUmh2R2bdstBcTUAFUU6
 pDeW8OUdj/LhclKaQmtqiN2AXZJ8OgAk/txxc2NEAyU0qyW5ofi0hnQfhmdxufwA5GfCAf+ve
 Wd+HjmjL/XXWMKk7MubOfdEOVenSuwYxdZWTU/rd6OmjJELmR4OLZt0DrPwFugjk8xoAgTJlj
 ZqFIUmbmego1Vxj71/UAXLiJKrb7LrYUVipsupGkG0UXDZF7hbTvK/AEVsrijpUyTkk2CKHW/
 Y1O6oE63Dl0p4JRWwPc10jrpii1I527sqwVwtLN2dpVHREqP79ztwOxtEIZxTrfasd+x4fiic
 luxhkmFjEV88SWociZc7EKGZQCh04aRQb7fb4+qfgdwFCTL8fJKDvaglWa3dpwVfX2zzyGeXj
 /YnGDDTmLOZN09ytkRiKoiIPhppxgOkb4Ec2kTjXM8Bgq/PeLmEbttTkB1gpFEmPVT76D7zhf
 BbSHxwt7rrFLWX5vMS0CLgnUF1ZZ+HUI4gWmWK9Abre5VdMU0ikuQZ51VJKQ3WHRHEI104l+H
 tIbr9vRTRbNUIEmJOtYVt8skH0Z1qng3v9smI+qhXWJau3bmqdr3JkGf+4/CcgmuufuOC0jwK
 Gz5Zsh3Z9HAq76xJFJ3ssv8tcWMICmhER5wLTolkKipEdi/yBumo3t6QEZQy4gI5YblL5DQIH
 EP4dUDy/OSkQ1wctqBI2afZhan6AiEmbjJ5l1O4J7AwgiR2lOWlx8P0higytq00L6LQpvHNzZ
 Er88onHCNgYn69E7i+gnpxCRKLc5VOlGEm0gw/U5qx5+DoQ5YopYylY3gJxeQsM+bNT1M2xVY
 JHCBTvdA5CvT4+8M+6nPykt/ajQtG7Is+gbTBw9C5U715vpk5+j6qqOHSscSs17r7+nQgsgfC
 Jntx1sraZnpFBUs0BP14auKyjF8Yhxm3XhYbYm41KnO1XoT5U3aOQdYpslt07oZFR1Xd7LIHs
 ocgXgey27nfPWjXpq
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-10-12 at 20:34 +0200, Mike Galbraith wrote:
> On Mon, 2020-10-12 at 18:45 +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-10-10 06:31:57 [+0200], Mike Galbraith wrote:
> >
> > so this then. Do you have more of these?
>
> Nope....

Well, I do have a gripe from 5.6-rt, which I just took a moment to
confirm in virgin source, but that kernel is probably EOL.

[   24.613988] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   24.613988] WARNING: possible circular locking dependency detected
[   24.613989] 5.6.19-rt12-rt #3 Tainted: G            E
[   24.613990] ------------------------------------------------------
[   24.613991] ksoftirqd/0/10 is trying to acquire lock:
[   24.613992] ffff94a639fd6a48 (&sch->q.lock){+...}, at: sch_direct_xmit+=
0x81/0x2f0
[   24.613998]
               but task is already holding lock:
[   24.613998] ffff94a639fd6a80 (&(&sch->running)->seqcount){+...}, at: br=
_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614007]
               which lock already depends on the new lock.

[   24.614008]
               the existing dependency chain (in reverse order) is:
[   24.614009]
               -> #1 (&(&sch->running)->seqcount){+...}:
[   24.614010]        __dev_queue_xmit+0xc86/0xda0
[   24.614012]        br_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614017]        br_forward_finish+0x10a/0x1b0 [bridge]
[   24.614021]        __br_forward+0x17d/0x340 [bridge]
[   24.614024]        br_dev_xmit+0x432/0x560 [bridge]
[   24.614029]        dev_hard_start_xmit+0xc5/0x3f0
[   24.614030]        __dev_queue_xmit+0x973/0xda0
[   24.614031]        ip6_finish_output2+0x290/0x980
[   24.614033]        ip6_output+0x6d/0x260
[   24.614034]        mld_sendpack+0x1d9/0x360
[   24.614035]        mld_ifc_timer_expire+0x1f7/0x370
[   24.614036]        call_timer_fn+0x98/0x390
[   24.614038]        run_timer_softirq+0x591/0x720
[   24.614040]        __do_softirq+0xca/0x561
[   24.614042]        run_ksoftirqd+0x45/0x70
[   24.614043]        smpboot_thread_fn+0x266/0x320
[   24.614045]        kthread+0x11c/0x140
[   24.614047]        ret_from_fork+0x24/0x50
[   24.614049]
               -> #0 (&sch->q.lock){+...}:
[   24.614050]        __lock_acquire+0x115a/0x1440
[   24.614052]        lock_acquire+0x93/0x230
[   24.614053]        rt_spin_lock+0x78/0xd0
[   24.614055]        sch_direct_xmit+0x81/0x2f0
[   24.614056]        __dev_queue_xmit+0xcd7/0xda0
[   24.614057]        br_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614062]        br_forward_finish+0x10a/0x1b0 [bridge]
[   24.614067]        __br_forward+0x17d/0x340 [bridge]
[   24.614072]        br_dev_xmit+0x432/0x560 [bridge]
[   24.614076]        dev_hard_start_xmit+0xc5/0x3f0
[   24.614077]        __dev_queue_xmit+0x973/0xda0
[   24.614078]        ip6_finish_output2+0x290/0x980
[   24.614079]        ip6_output+0x6d/0x260
[   24.614080]        mld_sendpack+0x1d9/0x360
[   24.614081]        mld_ifc_timer_expire+0x1f7/0x370
[   24.614082]        call_timer_fn+0x98/0x390
[   24.614084]        run_timer_softirq+0x591/0x720
[   24.614085]        __do_softirq+0xca/0x561
[   24.614086]        run_ksoftirqd+0x45/0x70
[   24.614087]        smpboot_thread_fn+0x266/0x320
[   24.614089]        kthread+0x11c/0x140
[   24.614090]        ret_from_fork+0x24/0x50
[   24.614091]
               other info that might help us debug this:

[   24.614092]  Possible unsafe locking scenario:

[   24.614092]        CPU0                    CPU1
[   24.614093]        ----                    ----
[   24.614093]   lock(&(&sch->running)->seqcount);
[   24.614094]                                lock(&sch->q.lock);
[   24.614095]                                lock(&(&sch->running)->seqco=
unt);
[   24.614096]   lock(&sch->q.lock);
[   24.614097]
                *** DEADLOCK ***

[   24.614097] 20 locks held by ksoftirqd/0/10:
[   24.614098]  #0: ffffffffa2485fc0 (rcu_read_lock){....}, at: rt_spin_lo=
ck+0x5/0xd0
[   24.614101]  #1: ffff94a65ec1b5a0 (per_cpu_ptr(&bh_lock.lock, cpu)){...=
.}, at: __local_bh_disable_ip+0xda/0x1c0
[   24.614103]  #2: ffffffffa2485fc0 (rcu_read_lock){....}, at: __local_bh=
_disable_ip+0x106/0x1c0
[   24.614105]  #3: ffffffffa2485fc0 (rcu_read_lock){....}, at: rt_spin_lo=
ck+0x5/0xd0
[   24.614107]  #4: ffff94a65ec1c1e0 (&base->expiry_lock){+...}, at: run_t=
imer_softirq+0x3e3/0x720
[   24.614110]  #5: ffffb3bd40077d70 ((&idev->mc_ifc_timer)){+...}, at: ca=
ll_timer_fn+0x5/0x390
[   24.614113]  #6: ffffffffa2485fc0 (rcu_read_lock){....}, at: mld_sendpa=
ck+0x5/0x360
[   24.614116]  #7: ffffffffa2485fc0 (rcu_read_lock){....}, at: __local_bh=
_disable_ip+0x106/0x1c0
[   24.614118]  #8: ffffffffa2485fa0 (rcu_read_lock_bh){....}, at: ip6_fin=
ish_output2+0x7a/0x980
[   24.614121]  #9: ffffffffa2485fc0 (rcu_read_lock){....}, at: __local_bh=
_disable_ip+0x106/0x1c0
[   24.614124]  #10: ffffffffa2485fa0 (rcu_read_lock_bh){....}, at: __dev_=
queue_xmit+0x63/0xda0
[   24.614126]  #11: ffffffffa2485fc0 (rcu_read_lock){....}, at: br_dev_xm=
it+0x5/0x560 [bridge]
[   24.614133]  #12: ffffffffa2485fc0 (rcu_read_lock){....}, at: __local_b=
h_disable_ip+0x106/0x1c0
[   24.614135]  #13: ffffffffa2485fa0 (rcu_read_lock_bh){....}, at: __dev_=
queue_xmit+0x63/0xda0
[   24.614138]  #14: ffffffffa2485fc0 (rcu_read_lock){....}, at: rt_spin_l=
ock+0x5/0xd0
[   24.614140]  #15: ffff94a639fd6d60 (&dev->qdisc_tx_busylock_key){+...},=
 at: __dev_queue_xmit+0x89e/0xda0
[   24.614143]  #16: ffffffffa2485fc0 (rcu_read_lock){....}, at: rt_spin_l=
ock+0x5/0xd0
[   24.614145]  #17: ffff94a639fd6b40 (&dev->qdisc_running_key){+...}, at:=
 __dev_queue_xmit+0xc52/0xda0
[   24.614148]  #18: ffff94a639fd6a80 (&(&sch->running)->seqcount){+...}, =
at: br_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614154]  #19: ffffffffa2485fc0 (rcu_read_lock){....}, at: rt_spin_l=
ock+0x5/0xd0
[   24.614155]
               stack backtrace:
[   24.614156] CPU: 0 PID: 10 Comm: ksoftirqd/0 Kdump: loaded Tainted: G  =
          E     5.6.19-rt12-rt #3
[   24.614157] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   24.614158] Call Trace:
[   24.614160]  dump_stack+0x71/0x9b
[   24.614163]  check_noncircular+0x155/0x170
[   24.614166]  ? __lock_acquire+0x115a/0x1440
[   24.614168]  __lock_acquire+0x115a/0x1440
[   24.614172]  lock_acquire+0x93/0x230
[   24.614173]  ? sch_direct_xmit+0x81/0x2f0
[   24.614177]  rt_spin_lock+0x78/0xd0
[   24.614178]  ? sch_direct_xmit+0x81/0x2f0
[   24.614180]  sch_direct_xmit+0x81/0x2f0
[   24.614182]  __dev_queue_xmit+0xcd7/0xda0
[   24.614184]  ? find_held_lock+0x2d/0x90
[   24.614186]  ? br_forward_finish+0xde/0x1b0 [bridge]
[   24.614192]  ? br_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614197]  br_dev_queue_push_xmit+0x79/0x160 [bridge]
[   24.614203]  br_forward_finish+0x10a/0x1b0 [bridge]
[   24.614210]  __br_forward+0x17d/0x340 [bridge]
[   24.614216]  ? br_flood+0x98/0x120 [bridge]
[   24.614222]  br_dev_xmit+0x432/0x560 [bridge]
[   24.614228]  dev_hard_start_xmit+0xc5/0x3f0
[   24.614232]  __dev_queue_xmit+0x973/0xda0
[   24.614233]  ? mark_held_locks+0x2d/0x80
[   24.614235]  ? eth_header+0x25/0xc0
[   24.614238]  ? ip6_finish_output2+0x290/0x980
[   24.614239]  ip6_finish_output2+0x290/0x980
[   24.614242]  ? ip6_mtu+0x135/0x1b0
[   24.614246]  ? ip6_output+0x6d/0x260
[   24.614247]  ip6_output+0x6d/0x260
[   24.614249]  ? __ip6_finish_output+0x210/0x210
[   24.614252]  mld_sendpack+0x1d9/0x360
[   24.614255]  ? mld_ifc_timer_expire+0x119/0x370
[   24.614256]  mld_ifc_timer_expire+0x1f7/0x370
[   24.614258]  ? mld_dad_timer_expire+0xb0/0xb0
[   24.614259]  ? mld_dad_timer_expire+0xb0/0xb0
[   24.614260]  call_timer_fn+0x98/0x390
[   24.614263]  ? mld_dad_timer_expire+0xb0/0xb0
[   24.614264]  run_timer_softirq+0x591/0x720
[   24.614267]  __do_softirq+0xca/0x561
[   24.614271]  ? smpboot_thread_fn+0x28/0x320
[   24.614273]  ? smpboot_thread_fn+0x70/0x320
[   24.614274]  run_ksoftirqd+0x45/0x70
[   24.614275]  smpboot_thread_fn+0x266/0x320
[   24.614277]  ? smpboot_register_percpu_thread+0xe0/0xe0
[   24.614278]  kthread+0x11c/0x140
[   24.614280]  ? kthread_park+0x90/0x90
[   24.614282]  ret_from_fork+0x24/0x50

