From: Gregoire Gentil <gregoire@gentil.com>
Subject: how to put in higher priority a thread in rt-kernel?
Date: Sun, 09 Sep 2012 15:51:06 -0700
Message-ID: <504D1D5A.4030704@gentil.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de> <50444D2F.3040607@gentil.com> <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com> <5046A959.3080904@gentil.com> <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com> <504824F4.2060606@gentil.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:41873 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab2IIWvJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 9 Sep 2012 18:51:09 -0400
Received: from [192.168.10.5] (c-69-181-223-70.hsd1.ca.comcast.net [69.181.223.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id 6AC5214000096
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Sep 2012 00:51:08 +0200 (CEST)
In-Reply-To: <504824F4.2060606@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have a mission critical job (reading some I2C and turning on/off some=
=20
GPIOs) running inside a thread of my rt-kernel. This thread is created=20
by my driver (create_singlethread_workqueue). How can I put this thread=
=20
in highest priority? In other words, is there an equivalent of=20
sched_setscheduler for thread inside the kernel?

Thanks in advance for any advice,

Gr=E9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
