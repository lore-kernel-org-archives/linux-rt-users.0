From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] v3.2-rc1-52e4c2a05-rt1 fix for compile break
Date: Mon, 14 Nov 2011 08:50:39 -0800
Message-ID: <20111114165039.GA2372@linux.vnet.ibm.com>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 14, 2011 at 02:44:42AM +0100, John Kacur wrote:
> kernel/rcutorture.c:492: error: =E2=80=98synchronize_rcu_bh=E2=80=99 =
undeclared here (not in a function)
>=20
> In CONFIG_PREEMPT_RT_FULL
> doesn't cover function pointer assignment unless we remove the bracke=
ts.
>=20
> Compile-tested.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

I have not yet queued this because mainline does not yet fold RCU and
RCU-bh together.

							Thanx, Paul

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
> --=20
> 1.7.2.3
>=20
