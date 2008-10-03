From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH replace] Fix pushable_tasks list corruption
Date: Fri, 03 Oct 2008 08:50:55 -0400
Message-ID: <48E6152F.1020400@novell.com>
References: <1223022275-6626-1-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05FC93F0D623A22A96170E7A"
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: Gilles Carry <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:59772 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYJCMqf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 08:46:35 -0400
In-Reply-To: <1223022275-6626-1-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05FC93F0D623A22A96170E7A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

Gilles Carry wrote:
> From: gilles.carry <gilles.carry@bull.net>
>
> Symptoms:
> System hang (endless loop in plist_check_list)
> or BUG because of faulty prev/next pointers in
> pushable_task node.
>
> When push_rt_task successes finding a task to push away, it
> performs a double lock on the runqueues (local and target) but
> before getting both locks, it releases the local rq lock allowing
> other cpus grab the task in between. (eg. pull_rt_task, timers...)
> In some situations, when push_rt_task calls dequeue_pushable_task
> the task may have already been removed from the pushable_tasks
> list by another cpu. Removing the node again corrupts the list.
>
> This patch adds a sanity check to dequeue_pushable_task which only
> removes the node if it's still on the original list.
>  =20

I think your analysis is spot on, though I am still concerned about your
implementation.  It still "papers over" the issue, so to speak, which is
that the item moved to a new RQ.  In addition, it adds a relatively
expensive check to the fast path of the list dequeue.

Based on this, I have submitted patches that address your finding but in
a more targeted and efficient approach (crediting you and Chirag) here:

http://lkml.org/lkml/2008/10/3/130

So I have to respectfully NACK this patch, but I do thank you for
investigating and pointing me at the actual root problem.  It is
sincerely appreciated.

Regards,
-Greg

> Signed-off-by: Gilles Carry <gilles.carry@bull.net>
> Cc: ghaskins@novell.com
> ---
>  kernel/sched_rt.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
> index 57a0c0d..7aa4450 100644
> --- a/kernel/sched_rt.c
> +++ b/kernel/sched_rt.c
> @@ -62,7 +62,17 @@ static void enqueue_pushable_task(struct rq *rq, str=
uct task_struct *p)
> =20
>  static void dequeue_pushable_task(struct rq *rq, struct task_struct *p=
)
>  {
> -	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
> +	struct plist_node *next;
> +
> +	/* Sanity check: delete only if node is still on this list */
> +	plist_for_each(next, &rq->rt.pushable_tasks) {
> +		if (&p->pushable_tasks =3D=3D next) {
> +			plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
> +			return;
> +		}
> +	}
> +
> +
>  }
> =20
>  #else
> @@ -1105,6 +1115,12 @@ static int push_rt_task(struct rq *rq)
>  		 * try again, since the other cpus will pull from us
>  		 * when they are ready
>  		 */
> +
> +		/*
> +		 * If we reach here and the task has migrated to another cpu
> +		 * (paranoid =3D=3D 0?) calling dequeue_pushable_task may cause
> +		 * pushable_tasks list corruption.
> +		 */
>  		dequeue_pushable_task(rq, next_task);
>  		goto out;
>  	}
>  =20



--------------enig05FC93F0D623A22A96170E7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjmFS8ACgkQlOSOBdgZUxl/uACdEEE1bQr1TSS6KIhBf/Zxpi2l
EGYAnRAFhD5e0XkceN5lgNyfWD6lk+TW
=Np9+
-----END PGP SIGNATURE-----

--------------enig05FC93F0D623A22A96170E7A--
