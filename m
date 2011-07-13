From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] man page for pip_stress
Date: Wed, 13 Jul 2011 20:37:48 +0200
Message-ID: <20110713183748.GC21450@pengutronix.de>
References: <1309178508-7392-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <985116783.390457.1309180305814.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44491 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1GMSht (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jul 2011 14:37:49 -0400
Content-Disposition: inline
In-Reply-To: <985116783.390457.1309180305814.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

On Mon, Jun 27, 2011 at 09:11:45AM -0400, John Kacur wrote:
> ----- Original Message -----
> > The Debian package checker lintian criticizes that pip_stress doesn=
't
> > have a
> > man page. So put a short version of the description from the source
> > file
> > into a man page to make lintian happy.
> >=20
>=20
> Why not just steal the text in the comments at the top of the file an=
d
> put that into man page form?
I reread the description in pip_stress.c and I think it is too verbose
for a manpage. A few examples that are IMHO not suitable for a man page=
:

	Pay particular attention to how this [mmap to back the
	pthread_mutex_t] is intialized to support processes.

	The state structure keeps track of the progress.

	In either case this program demonstrates how to use priority
	inheritance mutexes with processes.

	If you are having difficulty triggering an inversion, merely
	increase the time that the low priority process sleeps while
	holding the lock.

These are good as comments in the source file but are not helpful for a
user who just wants to use pip_stress.
=09
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
