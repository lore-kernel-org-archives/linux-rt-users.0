From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Tue, 5 Jan 2016 22:42:53 +0100
Message-ID: <20160105214253.GA27414@pengutronix.de>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
 <20160104133903.GG92593@unpythonic.net>
 <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
 <20160104162507.GE28361@pengutronix.de>
 <20160105211556.GA7561@icarus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Khem Raj <raj.khem@gmail.com>, Jeff Epler <jepler@unpythonic.net>,
	williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33809 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbcAEVnD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 16:43:03 -0500
Content-Disposition: inline
In-Reply-To: <20160105211556.GA7561@icarus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Henrik,

On Tue, Jan 05, 2016 at 10:15:56PM +0100, Henrik Austad wrote:
> On Mon, Jan 04, 2016 at 05:25:07PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 04, 2016 at 08:20:01AM -0800, Khem Raj wrote:
> > >=20
> > > > On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> =
wrote:
> > > >=20
> > > > I believe the patch does not have the desired effect, because m=
ake(1)
> > > > always sets CC automatically:
> > > >=20
> > > > $ cat raj.mk
> > > > CROSS_COMPILE=3Dx86_64-linux-gnu-
> > > > CC?=3D$(CROSS_COMPILE)gcc
> > > > .PHONY: default
> > > > default:
> > > > 	@echo CC=3D$(CC)
> > > > $ make -f raj.mk
> > > > CC=3Dcc
> > > >=20
> > > > With your patch, those who specify CROSS_COMPILE, or for whom g=
cc and cc
> > > > are different, will get different (worse) behavior.
> > >=20
> > > Right. I think if CC was used as such with out constructing out o=
f CROSS_COMPILE
> > > in Makefile then my issue would be fixed too. However this would =
mean that cross compiling users
> > > now have to pass CC =3D <cross-compiler> themselves instead of CR=
OSS_COMPILE prefix. Is that
> > > acceptable ?
> >=20
> > You could play with something like:
> >=20
> > ifeq($(origin CC),default)
> > CC=3D$(CROSS_COMPILE)gcc
> > endif
> >=20
> > but not sure I'd like the result. If you asked me, I'd drop all tha=
t
> > CROSS_COMPILE stuff.
>=20
> Why? Isn't this the normal way of triggering cross-compile? AFIAK, th=
at's=20
> how the kernel does it, and that seems like a pretty sane way.

No, the normal thing to trigger a cross-compile is

	./configure --build=3Damd64 --host=3Dmips-elf

:-)

=46or plain make project with no special support for cross compiling
(which is the norm today), the right incarnation is:

	make CC=3Darm-v5te-linux-gnueabi-gcc

and IMHO that's good enough. (Sometimes you also have to pass CXX, in
rare cases even more.)

> And yes, I compile rt-tests to several architectures, so I'm quite fo=
nd of=20
> the CROSS_COMPILE switch. In fact, I might get cross if you cross it =
out :)

I don't care much, because if I cross compile rt-tests someone else
already found out for me how to do it, I only have to enable it in my
config :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
