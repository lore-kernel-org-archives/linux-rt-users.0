Return-Path: <SRS0=yTcV=CO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76FC43461
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Sep 2020 04:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F02E2078E
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Sep 2020 04:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LM2QCXyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIEEsO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Sep 2020 00:48:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:52997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgIEEsM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Sep 2020 00:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599281251;
        bh=fpCy1EppaDNfWJwTX5VOR4081bi2FMGJUu2If0h1/aY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=LM2QCXyhqK2ajjdTplkek7d6GERWMPwX7cYTvnzXRnZDcovL2oee0lNuL/+6CxO3p
         Qrp1qPshARWeqmFUztMSu2DWkheWkjcR8yvSZfIBfCY/Q2enwhVK315DPG0wUFzs3y
         JoA/q6CpAwpXIE4F1WNa9gh8FKEhAACY7ahjM2bw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.50.208]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1k75pJ3Qnz-00TVaO; Sat, 05
 Sep 2020 06:47:30 +0200
Message-ID: <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
Subject: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 05 Sep 2020 06:47:29 +0200
In-Reply-To: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0V+5HsGraGfVWdCRNcZ4+2QZ9LFxW8ayOq7ZwIbx0U03ACcBwBy
 Y/5NcjLmfJ/TKZOCOZmJmyvjW9i0uvWh2htAKENEysgz5Q+IMqzuZVdG+CPp13GrVjZ5DiQ
 wIa3ZOgxH/f7Mcjo+Cmrll06PDllWFkJmX3Fk97LUoAWYZmcj2WmIVXi6eH748uUUWbPHr8
 Of7B675J+dCPi7wQfSGrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YwuBIOS4jsE=:SUFkGxI3INT5p2tdCc5GQl
 VZ9CANTtYJJC22xYx8Y2ZXJjLd6tiNyljcXWFQgvGjL1n7udcYxq72411zw+WdnSBNUCJUMy/
 0MViz/m30x35A8wIQN2W5G7Mg0mW33/ffGw37RPhUqENlroppHhVqTx0AAjCvM6YquVojMkLJ
 7QWqLNELVgICoVEWn40XMihCdhiS6WiSqFrJESu7q5p6We1gYoq+hP/tEWma7ho/fmbwqd6V9
 10ErmUcqA2XTTVaS8KdZtsytAXjM4IT7HWqqk8LMnbQIE5l9bc3hxMcMTkXYJ9eS4Krp9LUGW
 3pkkU3jNyYkuhANickS5bXXxXxG4UzRDK1LEHtVIFoiSsJMbL7Yn4eysM2lkIXyD9bpIhTCLw
 yiBlDIHIKxVg+SYxCBG1S55lisdQArFY7+Uzla7L9TP9Ho/JaIncoAF5uX2XkWLCGJdGK8QaB
 WfIML280KCGPcmGPU1oS3DQcEc6ZhZO0Q6Y/V5EMD2XnGPtaOuSeEbU1VcbOoZGqlh+5GQ7sW
 0Cqro7WUxlGoBQOk6hLcTngW5ooYsFmQwVgEv9SDFZO4pK4EdsurJS9NJ0rkSeiDzTDwCqPPh
 E5PD4mqt2fI/V62lqUknuG5GWxyeGgtDcGQl0ikupqZ744ab26uhWu3WSpWrwIsdMK+nFTwUw
 idkJKDK7rcSOaY2Mo9JQyOsB5H8NMEd6d3Fo7RidkheOXGZakCUQ21bPE3u5HzwXNwJqDgBR8
 PU1KIYIbr9AmDeNylPt1Fnljno/kiHVNcDF/3kZwb4M5vdVoRycum+4p7aEwIn1GMvgGgE5Sg
 D++UKeaUoJAD4QvGfyQfVwTnCQNRQaGC+4B+tyjzBEh6wLWJU9OGMZwlSkTISv4JD6J2Mgz27
 zce4UY/ihQv7evqxXmQ8jS0ppQtI1wnV1pV+EWUwkLJju1DLHr0Wx3q/nwFPgVA52Zaj7DsWL
 PuJXUWZ8H0jzoqSaWGtVa7RvqgfIk/6uQNJn8CiNHf/l/ixoJRAj0a2joS7ywsd0kAsJtaBig
 Xa+XtceJWmh56uJKmy05SGFSYiNXFojuRCeFVKDh9F5HVpi2+3pOEBefo955mEMkew0tBKNzm
 Gx2m9ddHpqGxZjOqZjzO00dcXnOLj3ReQFQj7mqKC8fMoxCXUhOR0UcwKMK3xHr4A/XRF0bnc
 kC5X+Y2G5DRU01AvBeiDEXis0WKCDopjR86N40aIaHKCB2XPk9YQphGUs1klk7h1RcH/UHzTd
 UtEgAUqM8f30q1mN3
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[   22.004225] r8169 0000:03:00.0 eth0: Link is Up - 1Gbps/Full - flow con=
trol off
[   22.004450] br0: port 1(eth0) entered blocking state
[   22.004473] br0: port 1(eth0) entered forwarding state
[   22.006411] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready

[   22.024936] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   22.024936] WARNING: possible circular locking dependency detected
[   22.024937] 5.9.0.gc70672d-rt3-rt #8 Tainted: G            E
[   22.024938] ------------------------------------------------------
[   22.024939] ksoftirqd/0/10 is trying to acquire lock:
[   22.024941] ffff983475521278 (&sch->q.lock){+...}-{0:0}, at: sch_direct=
_xmit+0x81/0x2f0
[   22.024947]
               but task is already holding lock:
[   22.024947] ffff9834755212b8 (&s->seqcount#9){+...}-{0:0}, at: br_dev_q=
ueue_push_xmit+0x7d/0x180 [bridge]
[   22.024959]
               which lock already depends on the new lock.

[   22.024960]
               the existing dependency chain (in reverse order) is:
[   22.024961]
               -> #1 (&s->seqcount#9){+...}-{0:0}:
[   22.024963]        lock_acquire+0x92/0x3f0
[   22.024967]        __dev_queue_xmit+0xce7/0xe30
[   22.024969]        br_dev_queue_push_xmit+0x7d/0x180 [bridge]
[   22.024974]        br_forward_finish+0x10a/0x1b0 [bridge]
[   22.024980]        __br_forward+0x17d/0x300 [bridge]
[   22.024984]        br_dev_xmit+0x442/0x570 [bridge]
[   22.024990]        dev_hard_start_xmit+0xc5/0x3f0
[   22.024992]        __dev_queue_xmit+0x9db/0xe30
[   22.024993]        ip6_finish_output2+0x26a/0x990
[   22.024995]        ip6_output+0x6d/0x260
[   22.024996]        mld_sendpack+0x1d9/0x360
[   22.024999]        mld_ifc_timer_expire+0x1f7/0x370
[   22.025000]        call_timer_fn+0xa0/0x390
[   22.025003]        run_timer_softirq+0x59a/0x720
[   22.025004]        __do_softirq+0xc1/0x5b2
[   22.025006]        run_ksoftirqd+0x47/0x70
[   22.025007]        smpboot_thread_fn+0x266/0x320
[   22.025009]        kthread+0x171/0x190
[   22.025010]        ret_from_fork+0x1f/0x30
[   22.025013]
               -> #0 (&sch->q.lock){+...}-{0:0}:
[   22.025015]        validate_chain+0xa81/0x1230
[   22.025016]        __lock_acquire+0x880/0xbf0
[   22.025017]        lock_acquire+0x92/0x3f0
[   22.025018]        rt_spin_lock+0x78/0xd0
[   22.025020]        sch_direct_xmit+0x81/0x2f0
[   22.025022]        __dev_queue_xmit+0xd38/0xe30
[   22.025023]        br_dev_queue_push_xmit+0x7d/0x180 [bridge]
[   22.025029]        br_forward_finish+0x10a/0x1b0 [bridge]
[   22.025033]        __br_forward+0x17d/0x300 [bridge]
[   22.025039]        br_dev_xmit+0x442/0x570 [bridge]
[   22.025043]        dev_hard_start_xmit+0xc5/0x3f0
[   22.025044]        __dev_queue_xmit+0x9db/0xe30
[   22.025046]        ip6_finish_output2+0x26a/0x990
[   22.025047]        ip6_output+0x6d/0x260
[   22.025049]        mld_sendpack+0x1d9/0x360
[   22.025050]        mld_ifc_timer_expire+0x1f7/0x370
[   22.025052]        call_timer_fn+0xa0/0x390
[   22.025053]        run_timer_softirq+0x59a/0x720
[   22.025054]        __do_softirq+0xc1/0x5b2
[   22.025055]        run_ksoftirqd+0x47/0x70
[   22.025056]        smpboot_thread_fn+0x266/0x320
[   22.025058]        kthread+0x171/0x190
[   22.025059]        ret_from_fork+0x1f/0x30
[   22.025060]
               other info that might help us debug this:

[   22.025061]  Possible unsafe locking scenario:

[   22.025061]        CPU0                    CPU1
[   22.025061]        ----                    ----
[   22.025062]   lock(&s->seqcount#9);
[   22.025064]                                lock(&sch->q.lock);
[   22.025065]                                lock(&s->seqcount#9);
[   22.025065]   lock(&sch->q.lock);
[   22.025066]
                *** DEADLOCK ***

[   22.025066] 20 locks held by ksoftirqd/0/10:
[   22.025067]  #0: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: rt_s=
pin_lock+0x5/0xd0
[   22.025071]  #1: ffff98351ec1a6d0 (per_cpu_ptr(&bh_lock.l.lock, cpu)){.=
...}-{3:3}, at: __local_bh_disable_ip+0xbf/0x230
[   22.025074]  #2: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: __lo=
cal_bh_disable_ip+0xfb/0x230
[   22.025077]  #3: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: rt_s=
pin_lock+0x5/0xd0
[   22.025080]  #4: ffff98351ec1b338 (&base->expiry_lock){+...}-{0:0}, at:=
 run_timer_softirq+0x3e6/0x720
[   22.025083]  #5: ffffb32e8007bd68 ((&idev->mc_ifc_timer)){+...}-{0:0}, =
at: call_timer_fn+0x5/0x390
[   22.025086]  #6: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: mld_=
sendpack+0x5/0x360
[   22.025090]  #7: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: __lo=
cal_bh_disable_ip+0xfb/0x230
[   22.025093]  #8: ffffffff9a4c7100 (rcu_read_lock_bh){....}-{1:3}, at: i=
p6_finish_output2+0x73/0x990
[   22.025096]  #9: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: __lo=
cal_bh_disable_ip+0xfb/0x230
[   22.025097]  #10: ffffffff9a4c7100 (rcu_read_lock_bh){....}-{1:3}, at: =
__dev_queue_xmit+0x63/0xe30
[   22.025100]  #11: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: br_=
dev_xmit+0x5/0x570 [bridge]
[   22.025108]  #12: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: __l=
ocal_bh_disable_ip+0xfb/0x230
[   22.025110]  #13: ffffffff9a4c7100 (rcu_read_lock_bh){....}-{1:3}, at: =
__dev_queue_xmit+0x63/0xe30
[   22.025113]  #14: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: rt_=
spin_lock+0x5/0xd0
[   22.025116]  #15: ffff9834755215f0 (dev->qdisc_tx_busylock ?: &qdisc_tx=
_busylock){+...}-{0:0}, at: __dev_queue_xmit+0x8a4/0xe30
[   22.025119]  #16: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: rt_=
spin_lock+0x5/0xd0
[   22.025121]  #17: ffff983475521398 (dev->qdisc_running_key ?: &qdisc_ru=
nning_key){+...}-{0:0}, at: __dev_queue_xmit+0xca6/0xe30
[   22.025124]  #18: ffff9834755212b8 (&s->seqcount#9){+...}-{0:0}, at: br=
_dev_queue_push_xmit+0x7d/0x180 [bridge]
[   22.025132]  #19: ffffffff9a4c7140 (rcu_read_lock){....}-{1:3}, at: rt_=
spin_lock+0x5/0xd0
[   22.025134]
               stack backtrace:
[   22.025134] CPU: 0 PID: 10 Comm: ksoftirqd/0 Kdump: loaded Tainted: G  =
          E     5.9.0.gc70672d-rt3-rt #8
[   22.025135] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   22.025136] Call Trace:
[   22.025138]  dump_stack+0x77/0x9b
[   22.025143]  check_noncircular+0x148/0x160
[   22.025147]  ? validate_chain+0xa81/0x1230
[   22.025148]  validate_chain+0xa81/0x1230
[   22.025153]  __lock_acquire+0x880/0xbf0
[   22.025157]  lock_acquire+0x92/0x3f0
[   22.025158]  ? sch_direct_xmit+0x81/0x2f0
[   22.025160]  ? rt_spin_unlock+0x39/0x90
[   22.025162]  rt_spin_lock+0x78/0xd0
[   22.025164]  ? sch_direct_xmit+0x81/0x2f0
[   22.025166]  sch_direct_xmit+0x81/0x2f0
[   22.025169]  __dev_queue_xmit+0xd38/0xe30
[   22.025173]  ? find_held_lock+0x2d/0x90
[   22.025176]  ? br_dev_queue_push_xmit+0x7d/0x180 [bridge]
[   22.025182]  br_dev_queue_push_xmit+0x7d/0x180 [bridge]
[   22.025190]  br_forward_finish+0x10a/0x1b0 [bridge]
[   22.025196]  ? __br_forward+0x151/0x300 [bridge]
[   22.025204]  __br_forward+0x17d/0x300 [bridge]
[   22.025211]  ? br_flood+0x98/0x120 [bridge]
[   22.025216]  br_dev_xmit+0x442/0x570 [bridge]
[   22.025224]  dev_hard_start_xmit+0xc5/0x3f0
[   22.025226]  ? netif_skb_features+0xb0/0x230
[   22.025228]  __dev_queue_xmit+0x9db/0xe30
[   22.025231]  ? eth_header+0x25/0xc0
[   22.025235]  ? ip6_finish_output2+0x26a/0x990
[   22.025236]  ip6_finish_output2+0x26a/0x990
[   22.025239]  ? ip6_mtu+0x135/0x1b0
[   22.025241]  ? ip6_output+0x6d/0x260
[   22.025243]  ip6_output+0x6d/0x260
[   22.025246]  ? __ip6_finish_output+0x210/0x210
[   22.025249]  mld_sendpack+0x1d9/0x360
[   22.025252]  ? mld_ifc_timer_expire+0x119/0x370
[   22.025254]  mld_ifc_timer_expire+0x1f7/0x370
[   22.025256]  ? mld_dad_timer_expire+0xb0/0xb0
[   22.025258]  ? mld_dad_timer_expire+0xb0/0xb0
[   22.025260]  call_timer_fn+0xa0/0x390
[   22.025263]  ? mld_dad_timer_expire+0xb0/0xb0
[   22.025264]  run_timer_softirq+0x59a/0x720
[   22.025268]  ? lock_acquire+0x92/0x3f0
[   22.025272]  __do_softirq+0xc1/0x5b2
[   22.025274]  ? smpboot_thread_fn+0x28/0x320
[   22.025276]  ? smpboot_thread_fn+0x28/0x320
[   22.025278]  ? smpboot_thread_fn+0x70/0x320
[   22.025279]  run_ksoftirqd+0x47/0x70
[   22.025281]  smpboot_thread_fn+0x266/0x320
[   22.025284]  ? smpboot_register_percpu_thread+0xe0/0xe0
[   22.025286]  kthread+0x171/0x190
[   22.025287]  ? kthread_park+0x90/0x90
[   22.025288]  ret_from_fork+0x1f/0x30
[   22.176416] NET: Registered protocol family 17

