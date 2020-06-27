Return-Path: <SRS0=RlOU=AI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F78C433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jun 2020 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AA520885
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jun 2020 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TTkSQyqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgF0NaZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:30:25 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:43181 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgF0NaZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Jun 2020 09:30:25 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id pAuSjk0AnxmkVpAuTjlwsf; Sat, 27 Jun 2020 15:30:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1593264621; bh=CV9gGn59Lk0RODuWryaR1XrRtftrt0oAXhTDrvogTzU=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=TTkSQyqI3XzG7lB34bYizJTfdO7tQ0L0MbfpnAMsZCxJCJI5yEqZDrBcbLBYJC6Tn
         2MkV2IiDapWWDNd1TJoHCpDKkOSgOXg/dB+biogTBCrPMoC9/O0oQqPXTiMrEmwUs3
         oSuWNS1qRqk4siJ/D1xMSNX+TULIAwx2notO5XiWnxuj76J9xxjc4e6rm7EjPW5f9k
         cCB7aqDWhm4oP8G5Ez/TmIZPNbvN+8OBs9COrBgdER1OZujauFSFIY7KdY+ug9Nkyy
         iQ/f8OcE7owvuvH4Y9DMFYp+GZFTFZ8nvMsDLQnj4pWJZ+toi5XMhEVmzhbrZJrlIX
         R7fyPPye35rWA==
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.4.13-rt7 stall on CPU?
To:     RT <linux-rt-users@vger.kernel.org>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 mQINBFTtuO0BEACwwf5qDINuMWL9poNLJdZh/FM5RxwfCFgfbM29Aip4wAUD3CaQHRLILtNO
 Oo4JwIPtDp7fXZ3MB82tqhBRU3W3HVHodSzvUk2VzV0dE1prJiVizpPtIeYRRDr4KnWTvJOx
 Fd3I7CiLv8oTH9j5yPTMfZ58Prp6Fgssarv66EdPWpKjQMY4mS8sl7/3SytvXiACeFTYPBON
 1I2yPIeYK4pKoMq9y/zQ9RjGai5dg2nuiCvvHANzKLJJ2dzfnQNGaCTxdEAuCbmMQDb5M+Gs
 8AT+cf0IWNO4xpExo61aRDT9N7dUPm/URcLjCAGenX10kPdeJP6I3RauEUU+QEDReYCMRnOM
 +nSiW7C/hUIIbiVEBn9QlgmoFINO3o5uAxpQ2mYViNbG76fnsEgxySnasVQ57ROXdEfgBcgv
 YSl4anSKyCVLoFUFCUif4NznkbrKkh7gi26aNmD8umK94E3a9kPWwXV9LkbEucFne/B7jHnH
 QM6rZImF+I/Xm5qiwo3p2MU4XjWJ1hhf4RBA3ZN9QVgn5zqluGHjGChg/WxhZVRdBl8Un3AY
 uixd0Rd9jFSUhZm/rcgoKyeW6c1Vkh8a2F+joZ/8wzxk6A8keiWq/pE00Lo9/Ed2w5dVBe1p
 N7rNh2+7DjAqpCSshYIsHYs0l5Q2W+0zYfuPM1kRbUdQF1PK0wARAQABtCVVZG8gdmFuIGRl
 biBIZXV2ZWwgPHVkb3ZkaEB4czRhbGwubmw+iQJiBBMBAgBMJhpodHRwOi8vcGluZGFyb3Rz
 LnhzNGFsbC5ubC9wb2xpY3kudHh0AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCVkiW
 pwIZAQAKCRCOFcDCBOMObsjdD/oDH+DvcAFakVThGdFi00o1W0j7fFcPhrP34Ulf+5idkgJm
 RzarJrz7Av7L6fwCS3JtrzfEJ+qoP84ONxnhNhj5ItHpVUlxyRWPBisklNlGJWK277Naw3BT
 mql2edPRIcR5Ypd8O7DBXIypG0CigjOVWfWLspjLmEGlinqpjHWuv4/LJ3qwSbbpW0rXpb44
 xSWB+u605pfrO3vDox5ORGCLktN8IXWISm9mS6vSXAi797KHwVX55OsiKqCbNkSM3bl6XfHh
 CPUpbOHXHzZXvP7JTINZfSfTPJx0iWCn3KArcsy7MzSwpUpUpDizrWwVRW1XySQydb8m+lnl
 8IVpJFiXiFEYGhFYU9HbUFSNGku134O5tf3VurfpOXmxGyeoyXWt4m9l7fcSaBAZq21iJT+S
 VCSmsI0JfhxMHjMbwdghPQ3UYK4q95TOcVRUkH0h+b2cZPirol4htc+ZCSzPKI++AGjXWIc5
 ZyQbthmFesrYGGttNIFFWsj3RUkyB58toDE7gXmarkhBg74tsSGbCyJp8/foy5hrci5sSi5P
 cygZxEDytCTNw1Dno/EAHUOpI2lJsVN8ACws16a6vh/UgQnBPsVFgVd0HSnlEX9XLO65lHlX
 aXo0zXomy+DDYD1sKARt8sKJk/H/VGs3SMRH3QtSBtWcUQKyJXMafWP/8A1Bz7kCDQRU7bjt
 ARAAwdK6VLsLLfyqYuA2/X+agquHh3U44IVxuRGAjQ7NSec9il+ENpbsaK6QGFBlyaWHkqcL
 e2u7DWTmG1uBqU9XqXGgeQJiOY8aof0rMsOVd1yYZsQO7+t2yfMOuS9+eRDxxj5l8gZXOKl3
 eQ5akqlKIWJy4G4D5pwCKuA5XFphpikPLm84Fb4V8IgRuiHaeHjeZyfkwYhKqxiyneGZ387b
 S3r4pMKprXlvFzWTr+x2TxexAECP3Tjg9ZakOIaVmgvFtl8L12ib6YJke7HxY/a3P3Glt+Zl
 5r/qcbWQoqyKBX+flWAjCPw+9EbdQNjBnIes3sPTTZ4YP4s2qC9rd/afeTSy3iUJhjGrEF+5
 d0AB1F+ZipmnZkGFF7tlvu6T/66JzsndOiEaLBYUa4VqJ+T0pvgX+MkbueYaQlsDl9eB24sC
 HTwfexUnvK5sUKnFFn5ZYZoIein2XHXb8EjbiT1G3G0Yj/q/DrRH1T7EiP6JPIIFdVVccnth
 j6rinWVJPiXRC8Gby/uSZP8t7HmQRYKV+xCESfRb4ZEfZqVm1/3wo3wYL5ek71yLEZC57+Hb
 RWgjaZuQg7Pn59Bh+M6cx5xTdyQ3PSeR14uXWLvMnVO2yF5pd6Ou2ySWatgtqmeTd77MpJ9+
 mPZTSG/lDGXpL2s1P6GiroiY0g3aicCgObwzr/MAEQEAAYkCRgQYAQIAMAUCVO247SYaaHR0
 cDovL3BpbmRhcm90cy54czRhbGwubmwvcG9saWN5LnR4dAIbDAAKCRCOFcDCBOMObqXID/9+
 lT7u4VJlreAFpSXOxwRlAtN88rzap3sZyQ1Z4YCxEZLHg4Ew2X0xS8w6t5jM4atOiuUW6fHY
 nI5KiYV7GARWWhZe/zsTjSs/tZVC68Q9qNwE1Ck+tuBV7d59l8qLBgQITsl6HCiYBaGJR2BF
 RdhP8a/aC6i3MWP8umK0yLJrV7gvP0sL8EKuz1zBARL5WuvzgsTA72QsilEQ/ZGYXwWnPOiI
 vTrGxZHD9apKOacSoY+CT+W+xe+tAKT0I8k4Ejda/hg6jMnaNNONX6rtiQEoUxv3R+iRhnaA
 NIsdTpUoZAbvFwStnRWgn+LgIMvKa5uW0Mjk0ynd14UxFluPs7J3saUukF4jXJGiWS2APD2K
 nNc7sAZraeSk/JFy0Y0WFCCr/UHzVLZnwdWpdw3inoIQeKtN2jWpuPP2l+4fgLybHJVnrDAs
 jujgAUTyaLDYoUryBiodY8G8gdZxTZvXk0RA9ux2TnFJJvdw8rR1sej5Lax1CZnQYwXNLvIi
 OcFUtIrTXnUj2uK2teab0RBIE4QedGoTGGHPuua8WqFpvVzC9iCIQlVtfGw6CVvq92icqbdz
 QYrlFbsVCXOM9TvO5ppqJowfdKmqFUjQPAsO40bwbphkt1NBalgZaxMCinpqEggVm/rGqbj2
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <3ef1ba37-6b83-e12a-e493-9c45fa3bb3c1@xs4all.nl>
Date:   Sat, 27 Jun 2020 15:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMf0vgU3anY3D9W+Ka/YCu0JQjN7UNXX5sTg4u515lrM22mdnx5uHpazumeVFL+dcHR/otAKbmVuEU18Jo8Oo6YGOku5/SGsUEtrl/zGjo5anUq2GXI2
 EkYUYmqYpzXm6oaMwau4qmq+GqEgGFcEi+LPV8YMYHimqsidy+W9aAwsPHzZqdpbEW1d0897FuOU/hNXQEDvJ7mtVDHKrFh2ODOMXqfkGvM1qSxGDG00hKyp
 cYsvjWHZaKM8OusBuJnW5A==
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Found this in /var/log/messages:

Jun 25 16:31:39 vuurmuur pppd[1522583]: local  LL address
fe80::ed36:3ac4:4115:e23e
Jun 25 16:31:39 vuurmuur pppd[1522583]: remote LL address
fe80::2a8a:1cff:fee0:9484
Jun 26 04:50:24 vuurmuur kernel: 002: rcu: INFO: rcu_preempt
self-detected stall on CPU
Jun 26 04:50:24 vuurmuur kernel: 002: rcu:      2-....: (5336 ticks this
GP) idle=f6a/1/0x4000000000000002 softirq=347363113/347363115 fqs=2430
Jun 26 04:50:24 vuurmuur kernel: 002:   (t=5250 jiffies g=608224341 q=1297)
Jun 26 04:50:24 vuurmuur kernel: 002: NMI backtrace for cpu 2
Jun 26 04:50:24 vuurmuur kernel: 002: CPU: 2 PID: 3468730 Comm: ntpd
Tainted: G           O      5.4.13-rt7 #9
Jun 26 04:50:24 vuurmuur kernel: 002: Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Jun 26 04:50:24 vuurmuur kernel: 002: Call Trace:
Jun 26 04:50:24 vuurmuur kernel: 002:  <IRQ>
Jun 26 04:50:24 vuurmuur kernel: 002:  dump_stack+0x50/0x70
Jun 26 04:50:24 vuurmuur kernel: 002:  nmi_cpu_backtrace.cold+0x14/0x53
Jun 26 04:50:24 vuurmuur kernel: 002:  ? lapic_can_unplug_cpu.cold+0x3b/0x3b
Jun 26 04:50:24 vuurmuur kernel: 002:
nmi_trigger_cpumask_backtrace+0x8e/0xa2
Jun 26 04:50:24 vuurmuur kernel: 002:  rcu_dump_cpu_stacks+0x8b/0xb9
Jun 26 04:50:24 vuurmuur kernel: 002:  rcu_sched_clock_irq.cold+0x17e/0x4fd
Jun 26 04:50:24 vuurmuur kernel: 002:  ? account_system_index_time+0xa6/0xd0
Jun 26 04:50:24 vuurmuur kernel: 002:  update_process_times+0x1f/0x50
Jun 26 04:50:24 vuurmuur kernel: 002:  tick_sched_timer+0x5a/0x1c0
Jun 26 04:50:24 vuurmuur kernel: 002:  ?
tick_switch_to_oneshot.cold+0x74/0x74
Jun 26 04:50:24 vuurmuur kernel: 002:  __hrtimer_run_queues+0xba/0x1b0
Jun 26 04:50:24 vuurmuur kernel: 002:  hrtimer_interrupt+0x108/0x230
Jun 26 04:50:24 vuurmuur kernel: 002:  smp_apic_timer_interrupt+0x61/0xa0
Jun 26 04:50:24 vuurmuur kernel: 002:  apic_timer_interrupt+0xf/0x20
Jun 26 04:50:24 vuurmuur kernel: 002:  </IRQ>
Jun 26 04:50:24 vuurmuur kernel: 002: RIP: 0010:__fget_light+0x3d/0x60
Jun 26 04:50:24 vuurmuur kernel: 002: Code: ca 75 2e 48 8b 50 50 8b 02
39 c7 73 21 89 f9 48 39 c1 48 19 c0 21 c7 48 8b 42 08 48 8d 04 f8 48 8b
00 48 85 c0 74 07 85 70 7c <75> 02 f3 c3 31 c0 c3 ba 01 00 00 00 e8 22
fe ff ff 48 85 c0 74 ee
Jun 26 04:50:24 vuurmuur kernel: 002: RSP: 0018:ffffc90001ebb930 EFLAGS:
00000246 ORIG_RAX: ffffffffffffff13
Jun 26 04:50:24 vuurmuur kernel: 002: RAX: ffff888059007c00 RBX:
000000007fff0010 RCX: 000000000000001a
Jun 26 04:50:24 vuurmuur kernel: 002: RDX: ffff888136edb458 RSI:
0000000000004000 RDI: 000000000000001a
Jun 26 04:50:24 vuurmuur kernel: 002: RBP: ffffc90001ebbcd0 R08:
00000000000000db R09: ffffffff81639c01
Jun 26 04:50:24 vuurmuur kernel: 002: R10: 0000000000000001 R11:
0000000000000000 R12: 0000000004000000
Jun 26 04:50:24 vuurmuur kernel: 002: R13: 000000000000001a R14:
000000000000001f R15: 0000000000000000
Jun 26 04:50:24 vuurmuur kernel: 002:  ? sock_ioctl+0x381/0x440
Jun 26 04:50:24 vuurmuur kernel: 002:  do_select+0x350/0x7a0
Jun 26 04:50:24 vuurmuur kernel: 002:  ?
select_estimate_accuracy+0x100/0x100
Jun 26 04:50:24 vuurmuur kernel: 002:  ? poll_select_finish+0x1d0/0x1d0
Jun 26 04:50:24 vuurmuur kernel: 002:  ? poll_select_finish+0x1d0/0x1d0
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? put_prev_task_rt+0x22/0x140
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? __schedule+0x435/0x4f0
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? put_prev_task_rt+0x22/0x140
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? __schedule+0x435/0x4f0
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? core_sys_select+0x5c/0x380
Jun 26 04:50:24 vuurmuur kernel: 002:  core_sys_select+0x1d0/0x380
Jun 26 04:50:24 vuurmuur kernel: 002:  ? core_sys_select+0x5c/0x380
Jun 26 04:50:24 vuurmuur kernel: 002:  ? tty_ldisc_ref_wait+0x27/0x70
Jun 26 04:50:24 vuurmuur kernel: 002:  ? __ldsem_down_read_nested+0x5e/0x240
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? find_held_lock+0x2b/0x80
Jun 26 04:50:24 vuurmuur kernel: 002:  ? set_user_sigmask+0x62/0x90
Jun 26 04:50:24 vuurmuur kernel: 002:  __x64_sys_pselect6+0x141/0x190
Jun 26 04:50:24 vuurmuur kernel: 002:  ? _raw_spin_unlock_irq+0x1f/0x40
Jun 26 04:50:24 vuurmuur kernel: 002:  ? sigprocmask+0x6d/0x90
Jun 26 04:50:24 vuurmuur kernel: 002:  do_syscall_64+0x77/0x440
Jun 26 04:50:24 vuurmuur kernel: 002:  ? schedule+0x3b/0xb0
Jun 26 04:50:24 vuurmuur kernel: 002:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jun 26 04:50:24 vuurmuur kernel: 002: RIP: 0033:0x7fba5ae5a096
Jun 26 04:50:24 vuurmuur kernel: 002: Code: e8 9f dd f8 ff 4c 8b 0c 24
4c 8b 44 24 08 89 c5 4c 8b 54 24 28 48 8b 54 24 20 b8 0e 01 00 00 48 8b
74 24 18 8b 7c 24 14 0f 05 <48> 3d 00 f0 ff ff 77 28 89 ef 89 04 24 e8
c8 dd f8 ff 8b 04 24 eb
Jun 26 04:50:24 vuurmuur kernel: 002: RSP: 002b:00007ffcff164a10 EFLAGS:
00000293 ORIG_RAX: 000000000000010e
Jun 26 04:50:24 vuurmuur kernel: 002: RAX: ffffffffffffffda RBX:
00005613a62cde78 RCX: 00007fba5ae5a096
Jun 26 04:50:24 vuurmuur kernel: 002: RDX: 0000000000000000 RSI:
00007ffcff164b00 RDI: 000000000000001f
Jun 26 04:50:24 vuurmuur kernel: 002: RBP: 0000000000000000 R08:
0000000000000000 R09: 00007ffcff164a50
Jun 26 04:50:24 vuurmuur kernel: 002: R10: 0000000000000000 R11:
0000000000000293 R12: 00005613a62a9c43
Jun 26 04:50:24 vuurmuur kernel: 002: R13: 0000000000000009 R14:
ffffffffffffffff R15: 00005613a62a9e1c
Jun 26 05:03:01 vuurmuur named[1433212]: received control channel
command 'flush'


What went wrong?
How bad is this?
How to avoid?

Kind regards,
Udo
