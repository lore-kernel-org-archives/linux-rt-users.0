From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH] futex: fix unbalanced spin_lock/spin_unlock() in exit_pi_state_list()
Date: Fri, 1 Mar 2013 13:58:52 +0800
Message-ID: <CAM2zO=A8UvTizpHWmkaxH+nT+yusmFFKagq3BNDAQ+XB0EBxhw@mail.gmail.com>
References: <1362101815-19968-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362101815-19968-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 1, 2013 at 9:36 AM, Yong Zhang <yong.zhang0@gmail.com> wrote:
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -562,16 +562,17 @@ void exit_pi_state_list(struct task_struct *curr)
>
>                 spin_lock(&hb->lock);
>
> -               raw_spin_lock_irq(&curr->pi_lock);
>                 /*
>                  * We dropped the pi-lock, so re-check whether this
>                  * task still owns the PI-state:
>                  */
>                 if (head->next != next) {

Just ignore this patch, race window is opened here.
New patch comes soon.

Thanks,
Yong

>                         spin_unlock(&hb->lock);
> +                       raw_spin_lock_irq(&curr->pi_lock);
>                         continue;
>                 }
>
> +               raw_spin_lock_irq(&curr->pi_lock);
>                 WARN_ON(pi_state->owner != curr);
>                 WARN_ON(list_empty(&pi_state->list));
>                 list_del_init(&pi_state->list);
> --
> 1.7.9.5
>



-- 
Only stand for myself
