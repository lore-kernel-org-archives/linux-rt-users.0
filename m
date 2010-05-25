From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 25 May 2010 09:25:41 -0400
Message-ID: <1274793941.22648.207.camel@gandalf.stny.rr.com>
References: <20100525130254.GA1715@rivendell>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nivedita Singhvi <niv@us.ibm.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <clark.williams@gmail.com>
To: Raphael Hertzog <raphael@ouaza.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:47633 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab0EYNZo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 May 2010 09:25:44 -0400
In-Reply-To: <20100525130254.GA1715@rivendell>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-05-25 at 15:02 +0200, Raphael Hertzog wrote:
> Hi,
>=20
> Le mercredi 05 mai 2010, Nivedita Singhvi a =E9crit :
> > Raphael Hertzog wrote:
> >=20
> > >In case it was not clear, I want to run the IRQ handler of the ser=
ial
> > >ports at a higher priority than the other ones (like network, disk=
,
> > >etc.) to avoid buffer overruns.
> >=20
> > Have you tried using the rtctl utility and the /etc/rtgroups file?
>=20
> Nope, not yet. I was not aware of it.
>=20
> Le jeudi 06 mai 2010, Steven Rostedt a =E9crit :
> > Also try out tuna. If you have fedora:
> >=20
> >  yum install tuna
>=20
> I have Debian and none of the two tools quoted above seem to be packa=
ged.
> But thanks for your answers, I will check them out.
>=20

I have installed and used tuna on a Debian machine. It takes a bit to
get all the dependencies straight, but it is possible.

> BTW I can't find a "rtctl" project, are the SRPM the official upstrea=
m
> sources? For tuna there's a least a git repo.

I added Clark Williams to the Cc. He should be able to answer that
question.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
