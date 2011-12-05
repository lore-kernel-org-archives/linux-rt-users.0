From: Clark Williams <williams@redhat.com>
Subject: Re: Where can I get the latest cyclictest or the version 0.72
Date: Mon, 5 Dec 2011 10:36:09 -0600
Message-ID: <20111205103609.1ad7b373@redhat.com>
References: <CAEQjb-TXX8bUULQVWOAQZjAxj7DVrA2ehs039qEH5zSe2BSfLA@mail.gmail.com>
	<1323096173.30977.77.camel@frodo>
	<20111205085950.751ffea3@redhat.com>
	<CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/szsafC0rA_g+5MVRBUM0CRu"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bei Guan <gbtju85@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57630 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499Ab1LEQgN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 11:36:13 -0500
In-Reply-To: <CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/szsafC0rA_g+5MVRBUM0CRu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Bei,=20

That's a git tree. You'll need to compile the images from there.=20

What distro are you using? Debian delivers rt-tests as a .deb, so you
could just apt-get it from there. I don't think Fedora delivers
rt-tests as an RPM.

Clark

On Mon, 5 Dec 2011 23:30:44 +0800
Bei Guan <gbtju85@gmail.com> wrote:

> Thank all of you very much.
>=20
> Hi Clark,
>=20
> How to install this new version? Could you give me
> some instructions? Thanks.
>=20
>=20
> Best Wishes,
> Bei Guan
>=20
>=20
>=20
>=20
> 2011/12/5 Clark Williams <williams@redhat.com>
>=20
> > On Mon, 05 Dec 2011 09:42:53 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Mon, 2011-12-05 at 21:32 +0800, Bei Guan wrote:
> > > > Hi,
> > > >
> > > >
> > > > I am very sorry to disturb you, but I find the mails I delivered
> > > > to linux-rt-users mailing list are all failed. So maybe you can help
> > > > me out of my question or forward my question to a correct man. Thank
> > > > you very much.
> > > >
> > > >
> > > > Where can I get the latest cyclictest or the version 0.72? I try the
> > > > following links, but it seems not available now.
> > > > http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/
> > > >
> > >
> > >
> > > Clark,
> > >
> > > Can you answer this.
> > >
> > > Thanks,
> > >
> > > -- Steve
> > >
> > >
> > >
> >
> > Currently (until I get my kernel.org account set back up) I'm keeping
> > it on github:
> >
> >        git://github.com/clrkwllms/rt-tests.git
> >
> > No tarballs available, just the git tree.
> >
> > Hopefully I'll get my k.o. account back up this week and will be back
> > to the old spot.
> >
> > Clark
> >
>=20
>=20
>=20
> --=20
> Best Regards,
> Bei Guan

--Sig_/szsafC0rA_g+5MVRBUM0CRu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk7c8vkACgkQHyuj/+TTEp2EQgCff2K6xdes236FG8jj4cvIVguF
Fv4AoOJ3gsr8PHusdQG3wiTND2MDzq7Y
=61eH
-----END PGP SIGNATURE-----

--Sig_/szsafC0rA_g+5MVRBUM0CRu--
