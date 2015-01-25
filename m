From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock functions
Date: Sun, 25 Jan 2015 15:55:08 -0500
Message-ID: <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
References: <20150120200229.GA17473@gbitten>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52358 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbAYUzj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2015 15:55:39 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so5963798wgh.6
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Jan 2015 12:55:38 -0800 (PST)
In-Reply-To: <20150120200229.GA17473@gbitten>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jan 20, 2015 at 3:02 PM, Gustavo Bittencourt <gbitten@gmail.com> wrote:
> The functions ww_mutex_lock_interruptible and ww_mutex_lock should return -EDEADLK when faced with
> a deadlock. To do so, the paramenter detect_deadlock in rt_mutex_slowlock must be TRUE.
> This patch corrects potential deadlocks when running PREEMPT_RT with nouveau driver.
>
> Kernel version: 3.14.25-rt22

You might want to have a look at this:

http://www.spinics.net/lists/linux-rt-users/msg12259.html

as it also impacts what the deadlock detection flag does.

Paul.
--

>
> Signed-off-by: Gustavo Bittencourt <gbitten@gmail.com>
> ---
>  kernel/locking/rtmutex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 6c40660..3f6ef91 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1965,7 +1965,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
>         might_sleep();
>
>         mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
> -       ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
> +       ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 1, ww_ctx);
>         if (ret)
>                 mutex_release(&lock->base.dep_map, 1, _RET_IP_);
>         else if (!ret && ww_ctx->acquired > 1)
> @@ -1984,7 +1984,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
>
>         mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map,
>                         _RET_IP_);
> -       ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
> +       ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 1, ww_ctx);
>         if (ret)
>                 mutex_release(&lock->base.dep_map, 1, _RET_IP_);
>         else if (!ret && ww_ctx->acquired > 1)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
