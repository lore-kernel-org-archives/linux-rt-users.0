From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.5-rt6
Date: Tue, 17 Dec 2013 08:16:31 +0100
Message-ID: <1387264591.5340.23.camel@marge.simpson.net>
References: <20131216091431.GA13796@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131216091431.GA13796@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

Looks like there's a booboo here:

On Mon, 2013-12-16 at 10:14 +0100, Sebastian Andrzej Siewior wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 22fa2e2..9c87a17 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1115,9 +1129,11 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
>  		 * is actually now running somewhere else!
>  		 */
>  		while (task_running(rq, p)) {
> -			if (match_state && unlikely(p->state != match_state)
> -			    && unlikely(p->saved_state != match_state))
> +			if (match_state) {
> +				if (!unlikely(check_task_state(p, match_state)))
> +					return 0;
>  				return 0;
> +			}
>  			cpu_relax();
>  		}
>  

"ptrace: fix ptrace vs tasklist_lock race" added.. 

@@ -1068,8 +1082,11 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(p->state != match_state))
+			if (match_state) {
+				if (!unlikely(check_task_state(p, match_state)))
+					return 0;
 				return 0;
+			}
 			cpu_relax();
 		}
 
..which is how it stays with the whole series applied.

The patch contains hunk 2 from

   "sched/rt: Fix wait_task_interactive() to test rt_spin_lock state",

which went away in -rt6, so it seems the busted hunk should be as below
if the two are to be merged.

@@ -1068,8 +1082,10 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(p->state != match_state))
+			if (match_state && unlikely(p->state != match_state)
+			    && unlikely(p->saved_state != match_state))
 				return 0;
+			}
 			cpu_relax();
 		}
 
