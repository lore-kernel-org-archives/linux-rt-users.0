From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] don't use exit(-1) for failures
Date: Thu, 14 Apr 2016 08:53:36 +0200
Message-ID: <20160414065336.GH10108@pengutronix.de>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
 <1458239345-30892-3-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com,
	jkacur@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36600 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbcDNGxj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Apr 2016 02:53:39 -0400
Content-Disposition: inline
In-Reply-To: <1458239345-30892-3-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hallo,

On Thu, Mar 17, 2016 at 02:29:04PM -0400, Luiz Capitulino wrote:
> The kernel uses only 8 bits of the status as a return
> code, so this actually becomes 255 in the shell.
>=20
> In any case, the most widely convension is exit(1)
> for failures, so let's be consistent.

The more portable version for this is to use EXIT_FAILURE. Not sure
though if it matters even for software that is not linux-centric like
rt-tests.

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
