From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Fix VERSION in rt-migrate-test
Date: Fri, 14 Aug 2015 22:00:05 +0200
Message-ID: <20150814200005.GX9999@pengutronix.de>
References: <1439556507-28759-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47989 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbHNUAI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Aug 2015 16:00:08 -0400
Content-Disposition: inline
In-Reply-To: <1439556507-28759-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Aug 14, 2015 at 01:48:27PM +0100, John Kacur wrote:
> - Change VERSION_STRING to VERSION to get the same version number as =
the
>   the rest of the suite
>=20
> - Assume that VERSION is defined, instead of replacing it with a
>   nonsensical number
>=20
> - Print the help option in the usage() function
>=20
> Reported-by: DIXLOR <dixlor@gmail.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
Patch looks good. It makes me remember my rework to let rt-tests use
autoconf (which I only sent to jkacur by private mail, but if you want
to take a look:

	git://git.pengutronix.de/git/ukl/rt-tests.git convert-to-autoconf

). Is it worth to rebase my work on top of v0.93?

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
