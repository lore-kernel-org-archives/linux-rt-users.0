From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] rcu: Fix macro substitution for
 synchronize_rcu_bh() on RT
Date: Sun, 20 Nov 2011 15:23:42 -0800
Message-ID: <20111120232341.GC17982@linux.vnet.ibm.com>
References: <20111119044510.811163517@goodmis.org>
 <20111119044831.614814511@goodmis.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:41263 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136Ab1KTXXt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Nov 2011 18:23:49 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 20 Nov 2011 18:23:48 -0500
Content-Disposition: inline
In-Reply-To: <20111119044831.614814511@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 18, 2011 at 11:45:12PM -0500, Steven Rostedt wrote:
> From: John Kacur <jkacur@redhat.com>
>=20
> kernel/rcutorture.c:492: error: =E2=80=98synchronize_rcu_bh=E2=80=99 =
undeclared here (not in a function)
>=20
> synchronize_rcu_bh() is not just called as a normal function, but can
> also be referenced as a function pointer. When CONFIG_PREEMPT_RT_FULL
> is enabled, synchronize_rcu_bh() is defined as synchronize_rcu(), but
> needs to be defined without the parenthesis because the compiler will
> complain when synchronize_rcu_bh is referenced as a function pointer
> and not a function.
>=20
> Signed-off-by: John Kacur <jkacur@redhat.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: stable-rt@vger.kernel.org
> Link: http://lkml.kernel.org/r/1321235083-21756-1-git-send-email-jkac=
ur@redhat.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  include/linux/rcutree.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 7a25aea..3bf47dc 100644
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
> 1.7.7.1
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
