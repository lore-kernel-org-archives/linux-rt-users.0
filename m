From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH][RT] Fix pushable_tasks list corruption
Date: Thu, 02 Oct 2008 08:35:54 -0400
Message-ID: <48E4C02A.4020406@novell.com>
References: <1222945573-29082-1-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig606AA4233E1C7617BE4D88ED"
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: Gilles Carry <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:36632 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYJBMba (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Oct 2008 08:31:30 -0400
In-Reply-To: <1222945573-29082-1-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig606AA4233E1C7617BE4D88ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles

Gilles Carry wrote:
> From: gilles.carry <gilles.carry@bull.net>
>
> Symptoms:
> System hang (endless loop in plist_check_list) or BUG because
> of faulty prev/next pointers in pushable_task node.
>
>
> When push_rt_task successes finding a task to push away, it
> performs a double lock on the runqueues (local and target) but
> before getting both locks, it releases the local rq lock letting
> other cpus grab the task in between. (eg. pull_rt_task, timers...)
> When push_rt_task calls deactivate_task (which calls
> dequeue_pushable_task) the task may have already been removed
> from the pushable_tasks list by another cpu.
> Removing the node again corrupts the list.
>  =20

Hmm,  I was looking at this same area of the code earlier this week.=20
The problem with your assessment is that find_lock_lowest_rq() already
accounts for the dropped-lock-migration and will return NULL if the task
was moved in the interim.  I suppose there could be some weird
circumstance where the task is moved away, and then moved back, but even
so plist_del() is supposed to be idempotent, so I dont see why an extra
dequeue_pushable itself would be a problem.

At this point I don't really *love* your patch because it seems to just
be plastering over the problem that the list is corrupted.  I do
appreciate that you are looking at this problem, however!  So thank you
for that and please keep it up.

I am on vacation every thursday+friday for a while, so I will not be
responsive until Monday.  Ill catch up with you guys then.  Have a good
weekend.

-Greg


--------------enig606AA4233E1C7617BE4D88ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjkwCoACgkQlOSOBdgZUxkZBQCgiM7XEMJ0Ofl+w6cyBg6ApbLQ
ux4AniSDkQBt+vjMk0JHxQ9ZeJ+HydUK
=lEcJ
-----END PGP SIGNATURE-----

--------------enig606AA4233E1C7617BE4D88ED--
