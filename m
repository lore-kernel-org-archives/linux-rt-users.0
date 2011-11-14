From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] v3.2-rc1-52e4c2a05-rt1 fix for compile break
Date: Mon, 14 Nov 2011 15:57:40 -0500
Message-ID: <1321304260.5011.12.camel@frodo>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2011-11-14 at 02:44 +0100, John Kacur wrote:
> kernel/rcutorture.c:492: error: =E2=80=98synchronize_rcu_bh=E2=80=99 =
undeclared here (not in a function)
>=20
> In CONFIG_PREEMPT_RT_FULL
> doesn't cover function pointer assignment unless we remove the bracke=
ts.

John,

Please write better change logs. Do not assume that people are looking
at the patch while looking at the logs. I mostly read change logs as
"git log" which doesn't include the changes, and most other developers
do this too. The above sentence does not make any real sense.

Something like:

synchronize_rcu_bh() is not just called as a normal function, but can
also be referenced as a function pointer. When CONFIG_PREEMPT_RT_FULL i=
s
enabled, synchronize_rcu_bh() is defined as synchronize_rcu(), but need=
s
to be defined without the parenthesis because the compiler will complai=
n
when synchronize_rcu_bh is referenced as a function pointer and not a
function.

-- Steve



>=20
> Compile-tested.
>=20
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  include/linux/rcutree.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 800b840..6e503a3 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -60,7 +60,7 @@ static inline void exit_rcu(void)
>  #ifndef CONFIG_PREEMPT_RT_FULL
>  extern void synchronize_rcu_bh(void);
>  #else
> -# define synchronize_rcu_bh()	synchronize_rcu()
> +# define synchronize_rcu_bh	synchronize_rcu
>  #endif
>  extern void synchronize_sched_expedited(void);
>  extern void synchronize_rcu_expedited(void);
