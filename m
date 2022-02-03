Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE0C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Feb 2022 08:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbiBCI71 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Feb 2022 03:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiBCI70 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Feb 2022 03:59:26 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B5C061714;
        Thu,  3 Feb 2022 00:59:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i62so6804820ybg.5;
        Thu, 03 Feb 2022 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6bLFj9eEexMSqacS3lsn8xaHOM8pa6JAmpNecQ7QYc=;
        b=AEUuETmUrGgY2TUa3AcBHgWbPfxGj/ykrF41u53RznkJN5AT0VH0+q0Obo7T6zYSTs
         onomrR6yoQNcTh/9tJH8HeePJOqMl6Bwdf3Yaqkf+oJfGZh3OZqO2FZF68vhFSuak/s1
         HA5MvtcEYcgwIPhkCnNMXBF+5NrIZiRSabW8W1CTNGiJ3XMdfVoUZQtCAy3515m1n1Ry
         gFlbR8siX9MDR7ry6aaFBsAZVc6t9D3WTboz9D7u6g0MR8RvdknSAp9EGOnQg9UPSBG7
         vsBpO12wNAQLZrW1YQa+gHXdgWFirxnAz4WEuj0uRZkH07tzmsiBiTGxIO7IwE557EDD
         gw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6bLFj9eEexMSqacS3lsn8xaHOM8pa6JAmpNecQ7QYc=;
        b=DORjMhu9PSBJeT1Lu+wPluhV8wDqql9op0H4NI3Go71IOCS6sST8hN2A+WoYTVZmYT
         g1Yt10b6z9iG606djZX+oBoPvhH4eQgkNCUvlHP0HIXkJ49XngPz1HQy4Z692sP42AnY
         tT+zyklfvYSipcAscmmAQxBIJRvf2ivHCQEukeGZ6GCndOtMTVBoSglXF8dcnaiC3GpG
         67PIwd/Kz7vk0Joh5vj3JZljM22HHRRNyzA0/OaEJ0gD6Hwr78FYcpBjN4WsKGDBLmN/
         GMp+PBczDSNhwrcthpYtnQOHalmvv2+fkxn22TcS7YTS1HhyWBuyecKd92jk7dfSUmgp
         FVJg==
X-Gm-Message-State: AOAM531+WIAFNHSgF3Avpgnw18eKA0BRKlvfi3iG/hfL5r5nxJXIbwtE
        Kev0mGcgqK6O2T2dXXtriE+DIv8Ww9ShHiy9JaA=
X-Google-Smtp-Source: ABdhPJzjkdEmFz8fsuQjVuJ5Uy1V9/mjo2tFShBt63eNCINTKFdI2Tu2Rn6GMcBMYfSwG8tyGRYIEL3ID5tV8TZR29I=
X-Received: by 2002:a0d:cf04:: with SMTP id r4mr3434589ywd.397.1643878765426;
 Thu, 03 Feb 2022 00:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20220107021502.1121597-1-lgoncalv@redhat.com> <20220107021502.1121597-2-lgoncalv@redhat.com>
In-Reply-To: <20220107021502.1121597-2-lgoncalv@redhat.com>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Thu, 3 Feb 2022 09:59:14 +0100
Message-ID: <CAA7rmPFkHO=2AA3hfsoeB4KSYqj4+GMFu7+AuqLObGvfCngVFw@mail.gmail.com>
Subject: Re: [PATCH RT 1/3] eventfd: Make signal recursion protection a task bit
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

OT: Btw for some reason you're sending a copy to
"stable-rt@vger.kernel.org"@redhat.com.

On Fri, Jan 7, 2022 at 8:04 PM Luis Claudio R. Goncalves
<lgoncalv@redhat.com> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> v5.10.90-rt61-rc1 stable review patch.
> If anyone has any objections, please let me know.
>
> -----------
>
>
> Upstream commit b542e383d8c005f06a131e2b40d5889b812f19c6
>
> The recursion protection for eventfd_signal() is based on a per CPU
> variable and relies on the !RT semantics of spin_lock_irqsave() for
> protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
> disables preemption nor interrupts which allows the spin lock held section
> to be preempted. If the preempting task invokes eventfd_signal() as well,
> then the recursion warning triggers.
>
> Paolo suggested to protect the per CPU variable with a local lock, but
> that's heavyweight and actually not necessary. The goal of this protection
> is to prevent the task stack from overflowing, which can be achieved with a
> per task recursion protection as well.
>
> Replace the per CPU variable with a per task bit similar to other recursion
> protection bits like task_struct::in_page_owner. This works on both !RT and
> RT kernels and removes as a side effect the extra per CPU storage.
>
> No functional change for !RT kernels.
>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/r/87wnp9idso.ffs@tglx
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  fs/aio.c                |  2 +-
>  fs/eventfd.c            | 12 +++++-------
>  include/linux/eventfd.h | 11 +++++------
>  include/linux/sched.h   |  4 ++++
>  4 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index c72b2c51b446c..f7d47c9ff6deb 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1761,7 +1761,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>                 list_del_init(&req->wait.entry);
>                 list_del(&iocb->ki_list);
>                 iocb->ki_res.res = mangle_poll(mask);
> -               if (iocb->ki_eventfd && eventfd_signal_count()) {
> +               if (iocb->ki_eventfd && eventfd_signal_allowed()) {

IIUC, the logic changed and this should read
!eventfd_signal_allowed(). Or am I missing something here?

Actually checking other stable branches and upstream, this looks to be
a typo only in v5.10.90-rt61-rc1

--nX




>                         iocb = NULL;
>                         INIT_WORK(&req->work, aio_poll_put_work);
>                         schedule_work(&req->work);
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index df466ef81dddf..9035ca60bfcf3 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -25,8 +25,6 @@
>  #include <linux/idr.h>
>  #include <linux/uio.h>
>
> -DEFINE_PER_CPU(int, eventfd_wake_count);
> -
>  static DEFINE_IDA(eventfd_ida);
>
>  struct eventfd_ctx {
> @@ -67,21 +65,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>          * Deadlock or stack overflow issues can happen if we recurse here
>          * through waitqueue wakeup handlers. If the caller users potentially
>          * nested waitqueues with custom wakeup handlers, then it should
> -        * check eventfd_signal_count() before calling this function. If
> -        * it returns true, the eventfd_signal() call should be deferred to a
> +        * check eventfd_signal_allowed() before calling this function. If
> +        * it returns false, the eventfd_signal() call should be deferred to a
>          * safe context.
>          */
> -       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +       if (WARN_ON_ONCE(current->in_eventfd_signal))
>                 return 0;
>
>         spin_lock_irqsave(&ctx->wqh.lock, flags);
> -       this_cpu_inc(eventfd_wake_count);
> +       current->in_eventfd_signal = 1;
>         if (ULLONG_MAX - ctx->count < n)
>                 n = ULLONG_MAX - ctx->count;
>         ctx->count += n;
>         if (waitqueue_active(&ctx->wqh))
>                 wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -       this_cpu_dec(eventfd_wake_count);
> +       current->in_eventfd_signal = 0;
>         spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>
>         return n;
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index dc4fd8a6644dd..836b4c021a0a4 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/percpu.h>
> +#include <linux/sched.h>
>
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -42,11 +43,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
>  int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
>                                   __u64 *cnt);
>
> -DECLARE_PER_CPU(int, eventfd_wake_count);
> -
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>  {
> -       return this_cpu_read(eventfd_wake_count);
> +       return !current->in_eventfd_signal;
>  }
>
>  #else /* CONFIG_EVENTFD */
> @@ -77,9 +76,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
>         return -ENOSYS;
>  }
>
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>  {
> -       return false;
> +       return true;
>  }
>
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 409a24036952c..29e6ff1af1df9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -852,6 +852,10 @@ struct task_struct {
>         /* Stalled due to lack of memory */
>         unsigned                        in_memstall:1;
>  #endif
> +#ifdef CONFIG_EVENTFD
> +       /* Recursion prevention for eventfd_signal() */
> +       unsigned                        in_eventfd_signal:1;
> +#endif
>
>         unsigned long                   atomic_flags; /* Flags requiring atomic access. */
>
> --
> 2.33.1
>
