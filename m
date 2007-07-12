From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [Patch RT] Fix CFS load balancing for RT tasks
Date: Thu, 12 Jul 2007 08:28:54 +0200
Message-ID: <20070712082854.12a385d3@frecb000686.frec.bull.fr>
References: <20070711164708.48907792@frecb000686.frec.bull.fr>
	<1184173580.12353.105.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:37206 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXGLGbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 02:31:00 -0400
In-Reply-To: <1184173580.12353.105.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Jul 2007 19:06:20 +0200 Thomas Gleixner <tglx@linutronix.de>=
 wrote:

> On Wed, 2007-07-11 at 16:47 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> >   The following patch fixes this by re-enabling the RT overload det=
ection
> > for the CFS. It may not be the right solution, maybe it should be i=
ncorporated
> > into the other load balancing mechanisms. I did not digg deep enoug=
h yet
> > to make that call ;-)
> >=20
> >   P.S. Thanks to Steven Rostedt for logdev which is proving invalua=
ble in
> >        cases like this.
> >=20
> >   S=C3=A9bastien.
>=20
> Nice catch. That was dropped during the CFS -> -rt merge.
>=20
> 	tglx

  Thanks, and sorry, I forgot to CC you :(

  S=C3=A9bastien.
