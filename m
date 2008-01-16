From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: 2.6.24-rc7-rt2
Date: Wed, 16 Jan 2008 09:12:27 +0200
Message-ID: <200801160912.37814.caglar@pardus.org.tr>
References: <1200336080.318.8.camel@localhost.localdomain> <200801150237.44029.caglar@pardus.org.tr> <Pine.LNX.4.58.0801152259200.19680@gandalf.stny.rr.com>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6635555.bE6CEP7T5s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:37464 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753582AbYAPHM7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 02:12:59 -0500
In-Reply-To: <Pine.LNX.4.58.0801152259200.19680@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--nextPart6635555.bE6CEP7T5s
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

16 Oca 2008 =C3=87ar tarihinde, Steven Rostedt =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> On Tue, 15 Jan 2008, [utf-8] S.=C3=83^Ga=C3=84^_lar Onur wrote:
> > 2.6.24-rc7-rt2 (-rt2 patchset on top of Linus's current git commit
> > 031f2dcd7075e218e74dd7f942ad015cf82dffab) starts to complain like
> > following (full dmesg can be found @ [1]) when try to login from console
> > (the other acpi related errors also existed in 2.6.24-rc5-rt1) and FYI,
> > plain 2.6.24-rc7 (again commit 031f2dcd7075e218e74dd7f942ad015cf82dffab)
> > has no issues.
>
> Do you get the same issues if you add to -rc7 and not git.

I'll try after trying -rt3.

> > [...]
> > sysfs: duplicate filename 'vcs1' can not be created
> > WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> > Pid: 1298, comm: mingetty Not tainted 2.6.24-rc7-rt2-99 #1
> > [...]
> >
> > And because of mcount-add-basic-support-for-gcc-profiler-instrum.patch,
> > closed source nvidia-new module cannot be used with this release (mcount
> > is exported GPL only), i know this is not supported but i used it with
> > that [2] patch up until now without a single problem.
>
> Ah, sorry about that. I'll try to fix that later on. You should still be
> able to use NVidia by turning off function trace.

Wonderfull news :) [and yes turning off function trace works]

> > Please don't misunderstand this, i really do not want to start a
> > discussion for this, i just want to ask the possibility of converting
> > this into EXPORT_SYMBOL cause i thought some of the possible -rt users
> > may need this closed source module explicitly because of its 3D
> > performance.
> >
> > If anything else needed for sysfs warnings please just say it...
> >
> > [1] http://cekirdek.pardus.org.tr/~caglar/dmesg.rt
> > [2]
> > http://svn.pardus.org.tr/pardus/devel/kernel/drivers/nvidia-new/files/r=
t.
> >patch
>
> Thanks for the report. I'll see what I can do for the next release. But
> for now this will have to wait till after -rt3.

Thanks...

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart6635555.bE6CEP7T5s
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBHja5ly7E6i0LKo6YRAvGlAKCOJMdPmAMmEDsn9c/tkUYGnrtMEACgwfYo
4K8HDcKVaYWh1EnjyCmLeW8=
=q50W
-----END PGP SIGNATURE-----

--nextPart6635555.bE6CEP7T5s--
