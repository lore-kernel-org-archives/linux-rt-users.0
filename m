From: Henrik Austad <henrikau@orakel.ntnu.no>
Subject: Re: Real time linux on my project
Date: Tue, 15 Jul 2008 20:15:15 +0200
Message-ID: <200807152015.20262.henrikau@orakel.ntnu.no>
References: <1216144243.8742.19.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart243257777.ix0rthS9yK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Luis <lquirosr@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail43.e.nsc.no ([193.213.115.43]:48993 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbYGOXOc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jul 2008 19:14:32 -0400
In-Reply-To: <1216144243.8742.19.camel@luis-desktop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--nextPart243257777.ix0rthS9yK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 July 2008 19:50:43 Luis wrote:
> Hi everyone,
>
> I am working on a project (for a NGO on Costa Rica) on which I will be
> developing a fully autonomous flying aerial photography platform. I will
> be using a powerful stealth computer on board which will be running
> (hopefully) a CONFIG_PREEMPT_RT modified Ubuntu for all the actions
> taking place (Control, sampling, communications, etc). I'm really new to
> real time. I will be sharing all the code and all the development will
> be open source so if anyone has recommendations, questions, things I
> should read, I'm open to hear from you. I will be controlling a small
> buy yet powerful gas helicopter and using a USB-DUX for the DAQ needs.

What is a stealth computer?

I'll give a few hints to the *coding*, not the rt-patch series itself:

=46or a general guide to the coding, I'd say have a look at=20
http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application

Also, look into=20
=2D mutex/semaphores
=2D threads
=2D message queues
have a look at https://computing.llnl.gov/tutorials/pthreads/=20

If your system becomes very large (and you have very formal requirements)=20
perhaps you should look into using Ada?

Good luck with the project - share some photos/videos of the aircraft in=20
action! :-)

=2D-=20
mvh Henrik Austad

--nextPart243257777.ix0rthS9yK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIfOk46k5VT6v45lkRAt+FAJ9+HZuhYtvGuoa3tRWzEQa3eLPCFQCfSqd0
gdBsWyc5XUTZIVB/iBfsosc=
=iTGE
-----END PGP SIGNATURE-----

--nextPart243257777.ix0rthS9yK--
