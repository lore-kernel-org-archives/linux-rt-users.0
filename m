From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: how to put in higher priority a thread in rt-kernel?
Date: Sun, 09 Sep 2012 22:23:08 -0700
Message-ID: <504D793C.7030402@gentil.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>  <20120902194911.GT28643@pengutronix.de> <50444D2F.3040607@gentil.com>  <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com>  <5046A959.3080904@gentil.com>  <20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>  <504824F4.2060606@gentil.com> <504D1D5A.4030704@gentil.com> <1347249175.4436.15.camel@marge.simpson.net>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:55020 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2IJFXM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Sep 2012 01:23:12 -0400
In-Reply-To: <1347249175.4436.15.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 09/09/2012 08:52 PM, Mike Galbraith wrote:
> On Sun, 2012-09-09 at 15:51 -0700, Gregoire Gentil wrote:
>> In other words, is there an equivalent of
>> sched_setscheduler for thread inside the kernel?
>
> Yup, and it's even called sched_setscheduler() :)
>
> -Mike
Thanks for answering! I don't think that my question is the smartest on=
e=20
ever asked on this mailing list ;-)

Gr=C3=A9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
