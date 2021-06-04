Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4580DC4743F
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Jun 2021 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDC761422
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Jun 2021 17:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFDRsQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:48:16 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:47047 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhFDRsP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Jun 2021 13:48:15 -0400
Received: by mail-io1-f49.google.com with SMTP id o21so10919365iow.13
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Jun 2021 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SNsl3j/8ASZy4N5sQkVd99L1HBy7cm1IwN9BKIQbU0=;
        b=mdcq7m6kVz/8yzfMXzynkMpDh3EpPMntum20e1R4VqEaY+YDhQDOHnaAC0Qu/+maop
         LRWvF4hfadCgK8NrH0ohhig6NiXXFMydx2smJIuDc+AZCq72xEWLQbG2G2mNqKY+bZRR
         t6xG36q/uGPLHg01947Um7McyXVAxZ1gNKmoTxn6Dj5rhWjXJCFERplZKD73ey1z1ZE0
         sG+0WIo09zvfi091NKvCVyawbemYhN7b8RuAVghDOzDLyq6qivCaDJguI+743u99E12q
         1kVjhV6oO/nM8PuHRDl4TFIfV9Uc4fdD4Csnoi81Yh72XA1x/MxaEwi41JIuxuNL8I3X
         QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SNsl3j/8ASZy4N5sQkVd99L1HBy7cm1IwN9BKIQbU0=;
        b=qFeSUypxAA1PaTI7hSOYsWJw1LqIhcdq7q2R6xsuotWyDLwXnjeKONG3axploip7i9
         BIxnYi3kiOkGZR5iJtOB3GUz3gVxNhRs8ai9h1xWIOepSNZOFyAqmjak7CdpL5QKBXPb
         BLuawY332tofasq6qGBij08Fkfgu4xHWhxiP8PsnIdJGRyAG+UyBYS7S9Ow14Rm9RlZt
         +Zwwa12r/rcsGHeQ/G+a5eLJsGKpfoWyc6Mu5FCbCMgy/L+0G0gEP9ClDoJbPKzNrtV9
         jF4h6JeuSeOaFQ5fzDwAT8BcRXmq0qCt2HQI5uysWfpqgclSphY5ORLxXm6L6OPPbpS3
         fXew==
X-Gm-Message-State: AOAM531wlacNsLIihTbcVCEUrWUcSQm0jPnaSBq+6r6tAYgGDFZIqUP/
        DypDNdEKWWWlXKNrKJbqDqnTry2SQaGFel+15+kKGA==
X-Google-Smtp-Source: ABdhPJwZFLGIJRWjRvwJdMqrAI/rNrpFs+crsDeX0fvacLDN+sXmZ7M04TjLgrj7wrZhAt0ObqfKndrkNWKTVGg8FxE=
X-Received: by 2002:a6b:cd08:: with SMTP id d8mr4788442iog.86.1622828728736;
 Fri, 04 Jun 2021 10:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210604163506.2103900-1-nsaenzju@redhat.com>
In-Reply-To: <20210604163506.2103900-1-nsaenzju@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 4 Jun 2021 10:44:52 -0700
Message-ID: <CAJHvVcjJa1dPfQ29LC65Ez+ixVio4qLgBnRW0tRd502HPaVVvw@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: Use local locks instead of disabling preemption
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, mtosatti@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I applied this patch and tried it out (*without* PREEMPT_RT), and it
works fine. Reading through the code carefully, it looks correct to
me.

I'm not as familiar with testing PREEMPT_RT kernels though, so likely
someone with more familiarity should take a look.

Feel free to take:
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, Jun 4, 2021 at 9:35 AM Nicolas Saenz Julienne
<nsaenzju@redhat.com> wrote:
>
> mmap_lock will explicitly disable/enable preemption upon manipulating
> its local CPU variables. This is to be expected, but in this case, it
> doesn't play well with PREEMPT_RT. The preemption disabled code section
> also takes a spin-lock. Spin-locks in RT systems will try to schedule,
> which is exactly what we're trying to avoid.
>
> To mitigate this, convert the explicit preemption handling to
> local_locks. Which are RT aware, and will disable migration instead of
> preemption when PREEMPT_RT=y.
>
> The faulty call trace looks like the following:
>     __mmap_lock_do_trace_*()
>       preempt_disable()
>       get_mm_memcg_path()
>         cgroup_path()
>           kernfs_path_from_node()
>             spin_lock_irqsave() /* Scheduling while atomic! */
>
> Fixes: 2b5067a8143e3 ("mm: mmap_lock: add tracepoints around lock acquisition ")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  mm/mmap_lock.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index dcdde4f722a4..2ae3f33b85b1 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -11,6 +11,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/smp.h>
>  #include <linux/trace_events.h>
> +#include <linux/local_lock.h>
>
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
> @@ -39,21 +40,30 @@ static int reg_refcount; /* Protected by reg_lock. */
>   */
>  #define CONTEXT_COUNT 4
>
> -static DEFINE_PER_CPU(char __rcu *, memcg_path_buf);
> +struct memcg_path {
> +       local_lock_t lock;
> +       char __rcu *buf;
> +       local_t buf_idx;
> +};
> +static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
> +       .lock = INIT_LOCAL_LOCK(lock),
> +       .buf_idx = LOCAL_INIT(0),
> +};
> +
>  static char **tmp_bufs;
> -static DEFINE_PER_CPU(int, memcg_path_buf_idx);
>
>  /* Called with reg_lock held. */
>  static void free_memcg_path_bufs(void)
>  {
> +       struct memcg_path *memcg_path;
>         int cpu;
>         char **old = tmp_bufs;
>
>         for_each_possible_cpu(cpu) {
> -               *(old++) = rcu_dereference_protected(
> -                       per_cpu(memcg_path_buf, cpu),
> +               memcg_path = per_cpu_ptr(&memcg_paths, cpu);
> +               *(old++) = rcu_dereference_protected(memcg_path->buf,
>                         lockdep_is_held(&reg_lock));
> -               rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
> +               rcu_assign_pointer(memcg_path->buf, NULL);
>         }
>
>         /* Wait for inflight memcg_path_buf users to finish. */
> @@ -88,7 +98,7 @@ int trace_mmap_lock_reg(void)
>                 new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
>                 if (new == NULL)
>                         goto out_fail_free;
> -               rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), new);
> +               rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
>                 /* Don't need to wait for inflights, they'd have gotten NULL. */
>         }
>
> @@ -122,23 +132,24 @@ void trace_mmap_lock_unreg(void)
>
>  static inline char *get_memcg_path_buf(void)
>  {
> +       struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
>         char *buf;
>         int idx;
>
>         rcu_read_lock();
> -       buf = rcu_dereference(*this_cpu_ptr(&memcg_path_buf));
> +       buf = rcu_dereference(memcg_path->buf);
>         if (buf == NULL) {
>                 rcu_read_unlock();
>                 return NULL;
>         }
> -       idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
> +       idx = local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_idx) -
>               MEMCG_PATH_BUF_SIZE;
>         return &buf[idx];
>  }
>
>  static inline void put_memcg_path_buf(void)
>  {
> -       this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
> +       local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
>         rcu_read_unlock();
>  }
>
> @@ -179,14 +190,14 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
>  #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
>         do {                                                                   \
>                 const char *memcg_path;                                        \
> -               preempt_disable();                                             \
> +               local_lock(&memcg_paths.lock);                                 \
>                 memcg_path = get_mm_memcg_path(mm);                            \
>                 trace_mmap_lock_##type(mm,                                     \
>                                        memcg_path != NULL ? memcg_path : "",   \
>                                        ##__VA_ARGS__);                         \
>                 if (likely(memcg_path != NULL))                                \
>                         put_memcg_path_buf();                                  \
> -               preempt_enable();                                              \
> +               local_unlock(&memcg_paths.lock);                               \
>         } while (0)
>
>  #else /* !CONFIG_MEMCG */
> --
> 2.31.1
>
