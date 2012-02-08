From: =?ISO-8859-1?Q?Matthias_S=F6llner?= <m.soellner@haw-aw.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Wed, 08 Feb 2012 16:46:48 +0100
Message-ID: <4F3298E8.9090303@haw-aw.de>
References: <4F143AB2.6070404@haw-aw.de> <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com> <4F16D7E9.9070707@haw-aw.de> <20120118191955.GA4066@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Austin Hendrix <ahendrix@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.haw-aw.de ([195.37.42.4]:37545 "EHLO smtp.haw-aw.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689Ab2BHPqx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 10:46:53 -0500
In-Reply-To: <20120118191955.GA4066@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18.01.2012 20:19, Uwe Kleine-K=F6nig wrote:
> On Wed, Jan 18, 2012 at 03:32:09PM +0100, Matthias wrote:
>> Ok.
>> Where do I get a 3.0 Kernel with included preempt-Patch for installi=
ng
>> in Debian 6.0?
> if you're on amd64 install linux-image-3.0.0-2-rt-amd64 from
> http://debian.pengutronix.de/debian sid main.=20

I can't find the package in
http://debian.pengutronix.de/debian sid main

Added it to /etc/apt/sources.list, and made a sudo apt-get update.
But the package is not there.

What am I doing wrong?

Thanks
Matthias





--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
