From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Changes the getcmdpath method to use only python calls
 to find the paths
Date: Thu, 29 Nov 2012 15:44:16 -0600
Message-ID: <20121129154416.5cfec3a9@redhat.com>
References: <1353540131-18978-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8WxHxunr2wy3bDPI8dY1bzO"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org, dsommers@redhat.com
To: =?UTF-8?B?UmFwaGHDq2w=?= Beamonte <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972Ab2K2VoT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2012 16:44:19 -0500
In-Reply-To: <1353540131-18978-1-git-send-email-raphael.beamonte@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/8WxHxunr2wy3bDPI8dY1bzO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2012 18:22:11 -0500
Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com> wrote:

> In my previous patches, I introduced a getcmdpath method which intended
> to replace the direct calls to binary from clear paths, using the which
> binary to locate the place of the searched one. This behavior was in
> fact not the finest as the method itself used the full path to the which
> binary. In this patch, I corrected the getcmdpath command to use only
> python calls (os.path.isfile and os.access) to identify in the PATH
> environment variable the place where the binary is.
>=20
> Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> ---
>  rteval/rteval.py |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/rteval/rteval.py b/rteval/rteval.py
> index beba49f..5843d78 100644
> --- a/rteval/rteval.py
> +++ b/rteval/rteval.py
> @@ -68,10 +68,16 @@ from cputopology import CPUtopology
> =20
>  pathSave=3D{}
>  def getcmdpath(which):
> +    """
> +    getcmdpath is a method which allows finding an executable in the PATH
> +    directories to call it from full path
> +    """
>      if not pathSave.has_key(which):
> -        cmd =3D '/usr/bin/which %s' % which
> -        c =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.PI=
PE)
> -        pathSave[which] =3D c.stdout.read().strip()
> +        for path in os.environ['PATH'].split(':'):
> +            cmdfile =3D os.path.join(path, which)
> +            if os.path.isfile(cmdfile) and os.access(cmdfile, os.X_OK):
> +                pathSave[which] =3D cmdfile
> +                break
>          if not pathSave[which]:
>              raise RuntimeError, "Command '%s' is unknown on this system"=
 % which
>      return pathSave[which]
> --=20


Applied to my rteval-1.0 branch. I haven't pushed it out yet since I'm
still looking at some other issues. Will go out with the next push.

Clark

--Sig_/8WxHxunr2wy3bDPI8dY1bzO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlC31zAACgkQHyuj/+TTEp0+rwCgjnaQIFolhtNaCQzwx1OQIauS
hlgAoLf95wyvLCB1FdeoQs3nxdUtsa4I
=meIt
-----END PGP SIGNATURE-----

--Sig_/8WxHxunr2wy3bDPI8dY1bzO--
