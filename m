From: Clark Williams <williams@redhat.com>
Subject: Re: Where can I get the latest cyclictest or the version 0.72
Date: Tue, 6 Dec 2011 10:08:13 -0600
Message-ID: <20111206100813.5aa8b287@redhat.com>
References: <CAEQjb-TXX8bUULQVWOAQZjAxj7DVrA2ehs039qEH5zSe2BSfLA@mail.gmail.com>
	<1323096173.30977.77.camel@frodo>
	<20111205085950.751ffea3@redhat.com>
	<CAEQjb-S6Ezy=d4k6p93uUcj+Osovc0kE6POmbYfjyS=dAARc8w@mail.gmail.com>
	<20111205103609.1ad7b373@redhat.com>
	<CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/5.GGEyoiJt24cIK13Grc..."; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bei Guan <gbtju85@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab1LFQIV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Dec 2011 11:08:21 -0500
In-Reply-To: <CAEQjb-TVaBZHbRBodLsBBPjJAMCd1xw9c_iLA-wX4ZmhRuacgQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/5.GGEyoiJt24cIK13Grc...
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Dec 2011 21:05:32 -0500
Bei Guan <gbtju85@gmail.com> wrote:

> 2011/12/5 Clark Williams <williams@redhat.com>
>=20
> > Bei,
> >
> > That's a git tree. You'll need to compile the images from there.
> >
> > What distro are you using? Debian delivers rt-tests as a .deb, so you
> > could just apt-get it from there. I don't think Fedora delivers
> > rt-tests as an RPM.
> >
> I have two distros, Fedora and Ubuntu. Under the Fedora, I just use "make
> install" and it seems to work well. Now I can use the command cyclictest =
in
> Fedora.
>=20
> But, under the Ubuntu, you mean I can use apt-get. Is the following right?
> apt-get install github.com/clrkwllms/rt-tests.git
>  (But it doesn't work. Please correct me.)

No you don't need to specify the git repository; there should be a
package already set up in the stable debian: apt-get install rt-tests

>=20
>=20
> Another question, how to get the histogram graphic using the cyclictest. I
> use the following command but I cannot get it.
>=20
> [root@localhost ~]# cyclictest -h -s -p 80 -n -i 10000 -l 1000
> WARNING: High resolution timers not available
> policy: fifo: loadavg: 0.13 0.10 0.09 4/229 5283
>=20
> T: 0 ( 5283) P:80 I:10000 C:   1000 Min:  14420 Act:14496 Avg:14712 Max:
> 24567
> WARNING: unable to open events/enable
>=20

The histogram option (-h) takes an argument, which is the max value
to record in microseconds. So, -h100 would generate a 100 element
histogram (1 microsecond per line). Since it doesn't look like you're
running on an RT kernel (no hrtimers available), you'll have a wide
variance in response times, so you'll need a big histogram range to
catch everything.=20

Try this:

# cyclictest -t -p80 -m -i 10000 -l 1000 -h 10000

Then be ready for 10000 lines of output when you control-C out of
cyclictest.=20

Clark



--Sig_/5.GGEyoiJt24cIK13Grc...
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk7ePe0ACgkQHyuj/+TTEp0nYwCeJ/V8p/j5jPODa2rP71Neo+/z
/3gAoMOki0Gp1nU5Y9+pSnN+yhS37kpK
=FggX
-----END PGP SIGNATURE-----

--Sig_/5.GGEyoiJt24cIK13Grc...--
