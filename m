From: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
Subject: Re: ARMv7 futex latency spike
Date: Mon, 14 Dec 2015 10:54:28 +0200
Message-ID: <20151214105428.661bf122@adi-pc-linux>
References: <55E950B1.4070603@ni.com>
	<alpine.DEB.2.11.1509041430340.15006@nanos>
	<55E9AEA5.50504@ni.com>
	<20151211163408.GF6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:33648 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752310AbbLNIyp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2015 03:54:45 -0500
In-Reply-To: <20151211163408.GF6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Dec 2015 17:34:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Ioan-Adrian Ratiu | 2015-09-04 17:45:57 [+0300]:
>=20
> >I will try the latest 4.1.5-rt5 and come back if this is still an
> >issue.
> I assume that problem went away=E2=80=A6

Yes, it was not happening anymore in 4.1.5-rt5 and I did a backport of
this [1] series on an older kernel and it also fixed the issue.

[1] https://lkml.org/lkml/2015/4/7/604
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
