From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] ipc: mqueue: wq_add priority changed to dynamic
 priority
Date: Mon, 11 Dec 2017 14:32:41 -0500
Message-ID: <20171211143241.6b5e627d@gandalf.local.home>
References: <1513006652-7014-1-git-send-email-jhaws@sdl.usu.edu>
        <1513012323038.16494@sdl.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "mingo@kernel.org" <mingo@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513012323038.16494@sdl.usu.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 11 Dec 2017 17:12:05 +0000
Jonathan Haws <jhaws@sdl.usu.edu> wrote:

> Adding linux-rt-users group to thread.
> ________________________________________
> From: Jonathan Haws <jhaws@sdl.usu.edu>
> Sent: Monday, December 11, 2017 08:37
> To: mingo@kernel.org; viro@zeniv.linux.org.uk; arnd@arndb.de; akpm@linux-foundation.org; deepa.kernel@gmail.com
> Cc: linux-kernel@vger.kernel.org; tglx@linutronix.de; bigeasy@linutronix.de; rostedt@goodmis.org; Jonathan Haws
> Subject: [RFC][PATCH] ipc: mqueue: wq_add priority changed to dynamic priority
> 
> Previous behavior added tasks to the work queue using the static_prio value
> instead of the dynamic priority value in prio. This caused RT tasks to be
> added to the work queue in a FIFO manner rather than by priority. Normal
> tasks were handled by priority.
> 
> This fix utilizes the dynamic priority of the task to ensure that both RT
> and normal tasks are added to the work queue in priority order. Utilizing
> the dynamic priority (prio) rather than the base priority (normal_prio) was
> chosen to ensure that if a task had a boosted priority when it was added to
> the work queue, it would be woken sooner to to ensure that it releases any
> other locks it may be holding in a more timely manner. It is understood that
> the task could have a lower priority when it wakes than when it was added to
> the queue in this (unlikely) case.

Probably a better subject would be:

 ipc: mqueue: Have RT tasks queue in by priority in wq_add()

Other than that (and that this doesn't handle DL tasks),

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> ---
>  ipc/mqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 9649ecd..cb96db9 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -546,7 +546,7 @@ static void wq_add(struct mqueue_inode_info *info, int sr,
>         ewp->task = current;
> 
>         list_for_each_entry(walk, &info->e_wait_q[sr].list, list) {
> -               if (walk->task->static_prio <= current->static_prio) {
> +               if (walk->task->prio <= current->prio) {
>                         list_add_tail(&ewp->list, &walk->list);
>                         return;
>                 }
> --
> 2.7.4
> 
