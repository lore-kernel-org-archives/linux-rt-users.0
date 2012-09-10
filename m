From: Mike Galbraith <efault@gmx.de>
Subject: Re: how to put in higher priority a thread in rt-kernel?
Date: Mon, 10 Sep 2012 05:52:55 +0200
Message-ID: <1347249175.4436.15.camel@marge.simpson.net>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <20120902194911.GT28643@pengutronix.de> <50444D2F.3040607@gentil.com>
	 <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com>
	 <5046A959.3080904@gentil.com>
	 <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>
	 <504824F4.2060606@gentil.com> <504D1D5A.4030704@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: gregoire@gentil.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:49472 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754427Ab2IJDxA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 9 Sep 2012 23:53:00 -0400
In-Reply-To: <504D1D5A.4030704@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2012-09-09 at 15:51 -0700, Gregoire Gentil wrote: 
> In other words, is there an equivalent of 
> sched_setscheduler for thread inside the kernel?

Yup, and it's even called sched_setscheduler() :)

-Mike

