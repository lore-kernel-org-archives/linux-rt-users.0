Return-Path: <SRS0=WTR/=7R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BFC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBCB20772
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RddgsrxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgFDQE1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDQE1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jun 2020 12:04:27 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16825C08C5C0;
        Thu,  4 Jun 2020 09:04:27 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j189so5512661oih.10;
        Thu, 04 Jun 2020 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyEXKQd2BY4YmEYue/9C/OskPugUl+fc38Pnjfb6Uj4=;
        b=RddgsrxZN6bfYmd7z5j85IiMU0Ow5+/UkyMgbgaYIhmGRDeI2i5c3tHWc9ilgnYpjj
         pbneeyg6nDT6Ek/HhaDIfvKwSA33vCjvKSeCj4xe51tvehJiWL3KVR254liFkESy71XA
         wbZpZS1c5G1fYFhBZw8oRFvn+oDQvo31cRk1eMtl8A5eNbpyRGdTKGJwjegpE+pio87i
         Ixc4Jm3HQKC0Vg5iW0VniAjCLnHklmzSi9nLFrhdTiAfUpV86fE/kKgNJA9PTnkwCRcX
         EtPMTOSyfJMtgQEtntn7SI0kLbTpROYIgh6sFHcpgSG6YDsT9vog5uGHlf3vqARUKFIY
         zZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyEXKQd2BY4YmEYue/9C/OskPugUl+fc38Pnjfb6Uj4=;
        b=PN5G+f2NYNCSX0SbNo3HeIbNeT90hlpizmFk5hNFnEEYm3Wnmm5wAuou8wPVehnRE4
         RrXRYks31MX9OlAqLxZWileEYaECQ8id2WPf5msZK7AZTU4O5fxQJGhbd76KCHwf6nJu
         sgDWMzaZtG6Tl2mTJVLl9KZL4KUUOwu7Bg/dZpTjtbG0be8NQbWZhXqhHbNJPp1E9pbI
         s+tZ3SgSwmI9Vlu0pNrxhaO954D0OoPVv5GVEWUq8uVV4fK87iWV7eU/xh1pXEJWEcGJ
         T8WjjmI+44IfQhDtnnxCECQsPESMx6WV2QAUO/OU5HHcFSccqIiWz5CORj4MZMTw3AKn
         bPhQ==
X-Gm-Message-State: AOAM5336+f0jUMdMc12BsSVrwrJnsD67eSBBfRlLr3jVe5tOw+M64nuv
        IE41BmoRpBpUe8j9rNgB+Z+mJNpafetljOx6T8DoaWtKM6Y=
X-Google-Smtp-Source: ABdhPJy5SksdkK+uqbcZf0bANmy9lEbz7loqxIPPmAtSSC3lTTua2okfxZzVZksSEISwV7IWg6aNoyQMpVMyzSxUDxo=
X-Received: by 2002:aca:dfc1:: with SMTP id w184mr3554049oig.113.1591286666298;
 Thu, 04 Jun 2020 09:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587675252.git.zanussi@kernel.org> <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
In-Reply-To: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Thu, 4 Jun 2020 19:04:15 +0300
Message-ID: <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 23, 2020 at 11:55 PM <zanussi@kernel.org> wrote:
>
> From: Zhang Xiao <xiao.zhang@windriver.com>
>
> v4.19.115-rt49-rc1 stable review patch.
> If anyone has any objections, please let me know.
>
> -----------
>
>
> The kernel bugzilla has the following race condition reported:
>
> CPU0                    CPU1            CPU2
> ------------------------------------------------
> test_set SCHED
>  test_set RUN
>    if SCHED
>     add_list
>     raise
>     clear RUN
> <softirq>
> test_set RUN
> test_clear SCHED
>  ->func
>                         test_set SCHED
> tasklet_try_unlock ->0
> test_clear SCHED
>                                         test_set SCHED
>  ->func
> tasklet_try_unlock ->1
>                                         test_set RUN
>                                         if SCHED
>                                         add list
>                                         raise
>                                         clear RUN
>                         test_set RUN
>                         if SCHED
>                          add list
>                          raise
>                          clear RUN
>
> As a result the tasklet is enqueued on both CPUs and run on both CPUs. Due
> to the nature of the list used here, it is possible that further
> (different) tasklets, which are enqueued after this double-enqueued
> tasklet, are scheduled on CPU2 but invoked on CPU1. It is also possible
> that these tasklets won't be invoked at all, because during the second
> enqueue process the t->next pointer is set to NULL - dropping everything
> from the list.
>
> This race will trigger one or two of the WARN_ON() in
> tasklet_action_common().
> The problem is that the tasklet may be invoked multiple times and clear
> SCHED bit on each invocation. This makes it possible to enqueue the
> very same tasklet on different CPUs.
>
> Current RT-devel is using the upstream implementation which does not
> re-run tasklets if they have SCHED set again and so it does not clear
> the SCHED bit multiple times on a single invocation.
>
> Introduce the CHAINED flag. The tasklet will only be enqueued if the
> CHAINED flag has been set successfully.
> If it is possible to exchange the flags (CHAINED | RUN) -> 0 then the
> tasklet won't be re-run. Otherwise the possible SCHED flag is removed
> and the tasklet is re-run again.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61451
> Not-signed-off-by: Zhang Xiao <xiao.zhang@windriver.com>
> [bigeasy: patch description]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  include/linux/interrupt.h | 5 ++++-
>  kernel/softirq.c          | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 97d9ba26915e..a3b5edb26bc5 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -579,12 +579,15 @@ enum
>  {
>         TASKLET_STATE_SCHED,    /* Tasklet is scheduled for execution */
>         TASKLET_STATE_RUN,      /* Tasklet is running (SMP only) */
> -       TASKLET_STATE_PENDING   /* Tasklet is pending */
> +       TASKLET_STATE_PENDING,  /* Tasklet is pending */
> +       TASKLET_STATE_CHAINED   /* Tasklet is chained */
>  };
>
>  #define TASKLET_STATEF_SCHED   (1 << TASKLET_STATE_SCHED)
>  #define TASKLET_STATEF_RUN     (1 << TASKLET_STATE_RUN)
>  #define TASKLET_STATEF_PENDING (1 << TASKLET_STATE_PENDING)
> +#define TASKLET_STATEF_CHAINED (1 << TASKLET_STATE_CHAINED)
> +#define TASKLET_STATEF_RC      (TASKLET_STATEF_RUN | TASKLET_STATEF_CHAINED)
>
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>  static inline int tasklet_trylock(struct tasklet_struct *t)
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 25bcf2f2714b..73dae64bfc9c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -947,6 +947,10 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
>          * is locked before adding it to the list.
>          */
>         if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> +               if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
> +                       tasklet_unlock(t);
> +                       return;
> +               }
>                 t->next = NULL;
>                 *head->tail = t;
>                 head->tail = &(t->next);
> @@ -1040,7 +1044,7 @@ static void tasklet_action_common(struct softirq_action *a,
>  again:
>                 t->func(t->data);
>
> -               while (!tasklet_tryunlock(t)) {
> +               while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
>                         /*
>                          * If it got disabled meanwhile, bail out:
>                          */
> --
> 2.17.1
>

Hi, This patch introduced a regression in our kernel
(v4.19.124-rt53-rebase), It occurs when we're jumping to crush kernel
using kexec, in the initialization of the emmc driver.
I'm still debugging the root cause, but I thought of mentioning this
in the mailing list if you have any idea why this could occur.
The issue doesn't happen on normal boot, only when I specifically
crash the kernel into the crash kernel.
Thanks,
Ramon.

[    0.546142] macb 2b00000.eth1 eth1: Cadence GEM rev 0x00070200 at
0x02b00000 irq 16 (00:28:f8:b7:a0:40)
[    0.548041] sdhci: Secure Digital Host Controller Interface driver
[    0.548042] sdhci: Copyright(c) Pierre Ossman
[    0.548044] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.580588] mmc0: SDHCI controller on 2200000.sdhci [2200000.sdhci]
using ADMA 64-bit
[    0.605753] hm, tasklet state: 00000008
[    0.605757] ------------[ cut here ]------------
[    0.605763] WARNING: CPU: 0 PID: 1 at ../kernel/softirq.c:1061
0xa80000080282649c
[    0.605771] CPU: 0 PID: 1 Comm: swapper Not tainted
4.19.124.eyeq5_ssnt-local-rt53-07819-g3519e8cf4110 #4
[    0.605774] Stack : 0000000000000000 0000000000000018
a80000080340bd40 0000000002d40000
[    0.605780]         a80000080340be70 0000000000000000
0000000000000000 000000000000007e
[    0.605785]         0000000000000000 0000000000000001
0000000000000001 0000000002d30000
[    0.605790]         0000000000000000 a800000802b2a688
0000000002d30000 0000000002d30000
[    0.605795]         0000000000000000 0000000000000000
a80000080282649c a800000802b6cf28
[    0.605799]         0000000000000009 0000000000000425
0000000000000000 0000000000000007
[    0.605804]         0000000002d30000 0000000002d30000
0000000000000000 a800000802d20000
[    0.605809]         a800000803430000 a80000080340bd40
a800000802d284c0 a80000080280a6c4
[    0.605813]         0000000000000000 0000000000000000
0000000000000000 0000000000000000
[    0.605818]         0000000000000000 a80000080280a6c8
0000000000000000 a800000802823b0c
[    0.605823]         ...
[    0.605825] Call Trace:
[    0.605830] [<a800000802b2a688>] 0xa800000802b2a688
[    0.605833] [<a80000080282649c>] 0xa80000080282649c
[    0.605835] [<a80000080280a6c4>] 0xa80000080280a6c4
[    0.605838] [<a80000080280a6c8>] 0xa80000080280a6c8
[    0.605840] [<a800000802823b0c>] 0xa800000802823b0c
[    0.605842] [<a80000080282649c>] 0xa80000080282649c
[    0.605845] [<a800000802b30394>] 0xa800000802b30394
[    0.605847] [<a8000008029cd2ec>] 0xa8000008029cd2ec
[    0.605850] [<a800000802805490>] 0xa800000802805490
[    0.605851]
[    0.605854] ---[ end trace 293afee709e91e0b ]---
[    0.607548] stn8500_serial 800000.uart: detected port #0
[    0.607576] stn8500_serial 800000.uart: uartclk 125000000
[    0.607605] 800000.uart: ttyST0 at MMIO 0x800000 (irq = 46,
base_baud = 7812500) is a stn8500
[    0.610303] stn8500_serial 900000.uart: detected port #1
[    0.610324] stn8500_serial 900000.uart: uartclk 125000000
[    0.611564] 900000.uart: ttyST1 at MMIO 0x900000 (irq = 46,
base_baud = 7812500) is a stn8500
[    0.614645] stn8500_serial a00000.uart: detected port #2
[    0.614891] stn8500_serial a00000.uart: uartclk 125000000
[    0.614919] a00000.uart: ttyST2 at MMIO 0xa00000 (irq = 46,
base_baud = 7812500) is a stn8500
[    0.614930] stn8500_serial a00000.uart: console setup on port #2 :
uartclk 125000000 115207-n-8-n
[    0.615943] console [ttyST2] enabled
[    0.615945] bootconsole [stn8500] disabled
[    0.620959] Freeing unused kernel memory: 1324K
[    0.620965] This architecture does not have kernel memory protection.
[    0.620967] Run /init as init process
[    0.710641] random: dd: uninitialized urandom read (512 bytes read)
