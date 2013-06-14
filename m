From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: pagefaults ...
Date: Fri, 14 Jun 2013 08:03:35 -0500
Message-ID: <20130614130335.GG22418@beefymiracle.amer.corp.natinst.com>
References: <CAF-VNaq1UQQW7MZUQ5N7nmvF_FFboXr4yn8CHaMzUGL6qndQXA@mail.gmail.com>
 <51BACA0D.2000907@meduna.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Cc: Stanislav Meduna <stano@meduna.org>, linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:60437 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3FNNCn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Jun 2013 09:02:43 -0400
In-Reply-To: <51BACA0D.2000907@meduna.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 09:45:17AM +0200, Stanislav Meduna wrote:
> On 14.06.2013 07:18, Lars Segerlund wrote:
>
> >  I have an application which should be realtime but apparently
> > generates page faults from a realtime context, I am trying to find a
> > way to get a stacktrace when this occurs, does anybody have any ideas
> > ?
>
[..]
>
> Basic questions:
>
> - do you call mlockall(MCL_CURRENT | MCL_FUTURE) _before_ your
>   threads are started?
>
> - do the faulting threads allocate memory?
>
> - do the faulting threads call kernel functions that might allocate memory?

Throwing in an additional question here that recently bit us:

  - does your application make use of fork(), popen(), daemon(), or any
    other call which under-the-hood invokes clone() with CLONE_VM not set?

  Josh

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuxSnAAoJEEef0niEbw+lRc4P/3CHkN1qb/Mgbl87Bwl18ZP/
sjTlBTlnctWwZWdHEnt5JlA7DAos7zOdAUuqBFy95G56PQO4ZYaid7tu7graxFxo
IuC38Xm9fQp37YjXGLP8oGJUy0xD/Mo6EwltdCCJoypNs/tKwJe4yUAjYw+3FYaQ
5sQL9X0deuNAOc8GhPIxOV4966hKQZmmbSwMuvgaUXHJI4lrvprqqYPNkb0VZBH6
cHPbE889qMdXo3BvSy2P/Ix85JrujJpiZCmY35T2hsrEoZjB+qdLXniU5izxe0P8
uPDoAJEtBIXNm17DtohJxz9Rr96Nq3a+KgPZUocyNO1AyPMkE2knr/pxbk/tXs9j
qYRwKMbpA9b514MMs1yRa2rq5s4epm6Tpp9tzl/iVsFpbDUCw48ZrP4FBlpnrKbd
wN/R5glDo8eDPEu0VGts5vrFUzaF3ZA9uO+HkmKg8OK0DWptgY3hB1Q1xZojVhfZ
nfhd7ZT73qIpHhQ3m3scYBFQS2K1hE0VzrDdfBbycaQTGti/s/GtkpYCmc+Vs0OO
FZUdPV10HegLIcckvIGVn2lCa+MZmCev+tqsTLUm0YLxjPQKvLya28vLU3giGctw
R/XoeYdVrw4syTOhu3qFgvVG27byCvDFlS2+yrqKytQosb/If5fI5tKIMRC1CV5y
w1jvuqftFLq3Jh3zQE89
=8F4I
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
