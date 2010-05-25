From: Raphael Hertzog <raphael@ouaza.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 25 May 2010 15:02:54 +0200
Message-ID: <20100525130254.GA1715@rivendell>
References: <1273168487.22438.44.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arrakeen.ouaza.com ([212.85.152.62]:35771 "EHLO
	arrakeen.ouaza.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab0EYNDY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 May 2010 09:03:24 -0400
Content-Disposition: inline
In-Reply-To: <1273168487.22438.44.camel@gandalf.stny.rr.com>
 <4BE1BADA.3040902@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Le mercredi 05 mai 2010, Nivedita Singhvi a =E9crit :
> Raphael Hertzog wrote:
>=20
> >In case it was not clear, I want to run the IRQ handler of the seria=
l
> >ports at a higher priority than the other ones (like network, disk,
> >etc.) to avoid buffer overruns.
>=20
> Have you tried using the rtctl utility and the /etc/rtgroups file?

Nope, not yet. I was not aware of it.

Le jeudi 06 mai 2010, Steven Rostedt a =E9crit :
> Also try out tuna. If you have fedora:
>=20
>  yum install tuna

I have Debian and none of the two tools quoted above seem to be package=
d.
But thanks for your answers, I will check them out.

BTW I can't find a "rtctl" project, are the SRPM the official upstream
sources? For tuna there's a least a git repo.

Cheers,
--=20
Rapha=EBl Hertzog -+- http://www.ouaza.com

=46reexian : des d=E9veloppeurs Debian au service des entreprises
http://www.freexian.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
