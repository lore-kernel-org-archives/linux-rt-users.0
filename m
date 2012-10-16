From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: Don't reference non-standard realtime group
Date: Tue, 16 Oct 2012 13:26:40 -0500
Message-ID: <20121016182640.GC6023@beefymiracle.amer.corp.natinst.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120902194911.GT28643@pengutronix.de>
 <alpine.LFD.2.02.1210160107520.6335@tycho>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:45347 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab2JPUM2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 16:12:28 -0400
In-Reply-To: <alpine.LFD.2.02.1210160107520.6335@tycho>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2012 at 01:13:35AM +0200, John Kacur wrote:
> On Sun, 2 Sep 2012, Uwe Kleine-K=F6nig wrote:
>
> > On Wed, Jul 13, 2011 at 10:48:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > > There is no dedicated realtime group in most distributions. So make t=
he
> > > error message a bit more understandable for people not running Redhat
> > > MRG.
>
> I thought we rejected this (via irc) the first time you sent it. The idea
> of a realtime group is pretty generic, but sure, it isn't there by default
> if you don't create it. However, the worse thing about this patch is that
> your message is in no way clearer than the original. It's longer though.

FWIW, our systems also lack a 'realtime' group, so the existing error
message can lead to a WTF for our users.  At least mentioning
RLIMIT_RTPRIO provides a googlable keyword for those newbie users who
may not know what it means.

It looks like Debian's been carrying Uwe's patch for about a year now.
A downstream distribution patching a specific message into a generic one
seems like an inversion to me.  Shouldn't upstream contain the most
generic message, and downstream distributors patch to make them more
specific?

  Josh

> Sorry, I don't like it, maybe Clark will overrule me if he's bored, or
> cares enough, but I'm not putting it in.
>
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Closes: http://bugs.debian.org/619938
> > ping?!
> >
> > > ---
> > >  src/lib/rt-utils.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > --- a/src/lib/rt-utils.c
> > > +++ b/src/lib/rt-utils.c
> > > @@ -72,7 +72,8 @@
> > >  	param.sched_priority =3D 1;
> > >  	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
> > >  		fprintf(stderr, "Unable to change scheduling policy!\n");
> > > -		fprintf(stderr, "either run as root or join realtime group\n");
> > > +		fprintf(stderr, "Probably missing capabilities, either run as "
> > > +				"root or increase RLIMIT_RTPRIO limits.\n");
> > >  		return 1;
> > >  	}

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQfabgAAoJEEef0niEbw+l8S8P/2OGQz+BwQn0iOm5x/7u1m62
MTl9lONAeGyuTsMkqlzwzt+Eb+oxZ07dI6PqrvKh1eXU91w1KrEvvQJ0WpebFKsw
Uzus+N6dMGusBrrF66gUCbBmCzj8O2TWpuWAXGmhUCP6m5C0tkJRfvb9N0rsfRP0
gzh8TjhI6tJtCkdy8bPMnvl9p5uTFwzZ812LWLQMUwvHblI8IFx9iA6tsu0nZv2q
/GC6tRafO7grKgc+KB55reZH7FTFpAyaAZRxv5XAQFUddIYK86sgAPCnyTn0Npaf
PmWIG3s1nphmC89Gub0DQge58+7vnwp49zLx19R5LKThM7r9+RNebJR15eHEs/6R
X6fPSuQip6teICr1O346QChV3E+Nerk2PpAe8IuAU7JVZcS1mWxse7GieKNW5r84
8oRZoAkuUdXvxypHRy4Okr9c/JriAFbf5lMQiMPqzUF5HsZWOtAXpxRMy4mIIM85
Hwvm5RpkfBJZrQdHPdOM8nsi6qBOnLwFYrTtMMsKhO7JhdAxaQUf5cxklYVP8FdU
jo7FMPnxgWW5/aHFOA90fLEL45z3xPi1RkkLCT9F3mYOtqYEbV/GrDpZyxBUmYip
le0crXrQr1qaZuVZW7Fqvj81fqnmNOOXzdR/yHYYONJ//5JE8xm71hUm0yfvaLHk
owu8FRoQZ/acLt3a7+wX
=qkIN
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
