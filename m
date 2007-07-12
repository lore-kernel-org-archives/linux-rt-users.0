From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [Patch RT] Fix CFS load balancing for RT tasks
Date: Thu, 12 Jul 2007 08:56:53 +0200
Message-ID: <20070712085653.0bb0064d@frecb000686.frec.bull.fr>
References: <20070711164708.48907792@frecb000686.frec.bull.fr>
	<1184173580.12353.105.camel@chaos>
	<Pine.LNX.4.58.0707111341190.18766@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42117 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbXGLG66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 02:58:58 -0400
In-Reply-To: <Pine.LNX.4.58.0707111341190.18766@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Jul 2007 13:41:55 -0400 (EDT) Steven Rostedt <rostedt@goodmi=
s.org> wrote:

> > On Wed, 2007-07-11 at 16:47 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> > >
> > >   P.S. Thanks to Steven Rostedt for logdev which is proving inval=
uable in
> > >        cases like this.
> > >
>=20
> Great to hear!!!
>=20
> I'll be uploading a new version of Logdev in a week or so.
>=20
> Thanks for the feedback.
>=20
> -- Steve
>=20

  Great! It's quite a nice and lightweight tool which I think will beco=
me
one of my top tools for kernel debugging.

  Just one suggestion, maybe, would be to add to the readme file the
order in which the patches should apply along with a short description
of what functionality they provide (or maybe document the patches and a=
dd a
series file).

  Anyway, thanks for that great tool.

  S=C3=A9bastien.
