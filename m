From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 02 Feb 2012 16:34:26 -0500
Message-ID: <1328218466.5882.119.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
	 <201202021338.44950.tim.sander@hbm.com>
	 <20120202201336.GF25594@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Sander <tim.sander@hbm.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org, efault@gmx.de
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:53207 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932585Ab2BBVe3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 16:34:29 -0500
In-Reply-To: <20120202201336.GF25594@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-02-02 at 21:13 +0100, Uwe Kleine-K=F6nig wrote:

> enabled the ksoftirq is also running wild with 3.0-rt. This also happ=
ens when
> I fail to reproduce that on a pcm043 machine using 3.0.18-rt34. Can y=
ou
> provide me your config. Does the problem occur on every boot for you?=
 If
> not, how often do I need to reboot?

Note, you also said (on IRC) that you boot off this card via NFS root.
I'm not sure Tim has the same setup, and that may be a big difference i=
n
how this bug comes about.

It's a race issue, and it may require enabling the network interface
after the system is up and running.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
