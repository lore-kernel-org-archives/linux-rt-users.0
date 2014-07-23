From: Yoann LE BARS <yoann@le-bars.net>
Subject: What is to become concerning real time in Linux kernel?
Date: Thu, 24 Jul 2014 00:24:11 +0200
Message-ID: <53D0360B.30001@le-bars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 1.mo66.mail-out.ovh.net ([178.33.109.87]:53618 "EHLO
	mo66.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758405AbaGWXxk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jul 2014 19:53:40 -0400
Received: from ex.mail.ovh.net (gw2.ex.mail.ovh.net [176.31.149.1])
	by mo66.mail-out.ovh.net (Postfix) with SMTP id EFA4BFFB4D2
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Jul 2014 00:24:12 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello everybody out there!

	As a user of soft real-time Linux kernel, I have some question about
its future.

	During Real Time Linux Workshop in November 2013, developers involved
in the real-time patch have indicated the project will be done in 2014,
=93one way or another=94 (<http://lwn.net/Articles/572740/>). In this
workshop, it has also been said that 95 % of the real-time work was
already upstream.

	The question was how will it be done? In considering that the 95 % is
good enough? Get the rest of the code upstream =96 which imply an
important effort and several people involved in it? Something between
these two options?

	As SCHED_DEADLINE has been incorporated into Linux 3.14 kernel
(<http://www.phoronix.com/scan.php?page=3Dnews_item&px=3DMTU3Njk>), it =
seems
to me that it has been decided to get some more code upstream. Still,
the question remains: what way will be the project done?

	Does anyone have any more information about it? As for my part, I
cannot find anything more.

	Regards.

							Yoann
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
