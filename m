From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 3.04-rt14 patch applies against which version?
Date: Wed, 21 Sep 2011 08:55:38 +0200
Message-ID: <20110921065538.GB27103@pengutronix.de>
References: <4E791F5D.8000105@caviumnetworks.com>
 <CAFQPvXcEjWod1k-UWjJ1AKwUtD+oGfXtqDd7xOVRGvKtfVpUrQ@mail.gmail.com>
 <4E792D0A.5070209@caviumnetworks.com>
 <4E793292.9050801@am.sony.com>
 <4E7937D1.4090203@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: frank.rowand@am.sony.com,
	Sankara Muthukrishnan <sankara.m@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55171 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1IUGzn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Sep 2011 02:55:43 -0400
Content-Disposition: inline
In-Reply-To: <4E7937D1.4090203@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Sep 20, 2011 at 06:03:13PM -0700, Venkat Subbiah wrote:
> Thanks for the info. I did see the kernel but didn't want to get the
> whole repo and I assumed it will probably apply against the repo
> from mainline. I did aplly now against v3.0 from mainline and it did
> apply pretty clean. There was one reject which is below and a few
> hunks which succeeded with offsets.
3.0.4 is a stable update to 3.0 that is not maintained in Linus'
repository. If kernel.org were available you could find it at

	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-3.0.y.git

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
