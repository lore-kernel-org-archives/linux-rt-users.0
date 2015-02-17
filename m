From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt-tests] pi_stress: remove timestamp of compilation from
 version output
Date: Tue, 17 Feb 2015 19:03:55 +0100
Message-ID: <20150217180355.GD26177@linutronix.de>
References: <1424185739-29680-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <clark.williams@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44584 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbBQSD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 13:03:58 -0500
Content-Disposition: inline
In-Reply-To: <1424185739-29680-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Uwe Kleine-K=C3=B6nig | 2015-02-17 16:08:59 [+0100]:

>Hello,
>
>a few people work on getting reproducible builds for Debian. Using
>__DATE__ and __TIME__ obviously makes the rt-tests package fail to
>compile in a deterministic fashion.

We used faketime (fed from changelog) to achieve the same goal but we
still got the warning while beeing deterministic. As a plus the build
crashed on hurd :)

>Best regards
>Uwe

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
