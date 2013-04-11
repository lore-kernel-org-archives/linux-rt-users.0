From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] hackbench: init child's struct before using it
Date: Thu, 11 Apr 2013 12:08:00 -0500
Message-ID: <20130411120800.06d750b2@riff.lan>
References: <1365693605-22704-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/tMdF4iLYCUKwNLGcccgUVGx"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org,
	David Sommerseth <davids@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab3DKRIL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Apr 2013 13:08:11 -0400
In-Reply-To: <1365693605-22704-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/tMdF4iLYCUKwNLGcccgUVGx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Applied to my work branch for the next release. I've CC'd John Kacur
who has been doing the heavy lifting on rt-tests recently.

Clark

On Thu, 11 Apr 2013 17:20:05 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Commit ad27df7 ("Reimplement better child tracking and improve error
> handling") changed the way of reporting pid/error after creating a
> child. It will return an union which is a mix pid_t, pthread_t and a
> signed long long for errors.
> Now on 32bit x86 both pid_t and pthread_t are four byte in size and are
> stored in the first 4 bytes. Now if the most significant bit of the long
> long variable happens to be set by chance (because nobody really
> initializes the variable here) then error variable will be negative. On
> little endian machines the assignment of pid or threadid won't reset the
> sign bit and you see this:
>=20
> | Running in process mode with 10 groups using 40 file descriptors each (=
=3D=3D 400 tasks)
> | Each sender will pass 100 messages of 100 bytes
> | 0 children started.  Expected 40
> | sending SIGTERM to all child processes
> | signaling 0 worker threads to terminate
> | Creating workers (error: Success)
>=20
> A machine with proper endian handlig (that is big endian) would reset
> the sign bit during the assignment of pid and I would not have to make
> this patch :)
>=20
> While here, I make create_worker() since it is not used outside of this
> file.
>=20
> Cc: David Sommerseth <davids@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/hackbench/hackbench.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 8baeb23..c21b4db 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -189,13 +189,14 @@ static void *receiver(struct receiver_context* ctx)
>  	return NULL;
>  }
> =20
> -childinfo_t create_worker(void *ctx, void *(*func)(void *))
> +static childinfo_t create_worker(void *ctx, void *(*func)(void *))
>  {
>  	pthread_attr_t attr;
>  	int err;
>  	childinfo_t child;
>  	pid_t childpid;
> =20
> +	memset(&child, 0, sizeof(child));
>  	switch (process_mode) {
>  	case PROCESS_MODE: /* process mode */
>  		/* Fork the sender/receiver child. */
> --=20
> 1.7.10.4
>=20

--Sig_/tMdF4iLYCUKwNLGcccgUVGx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFm7fMACgkQHyuj/+TTEp1AnwCg2wEDkd5obSpOO/1nNcZqOUbX
Pb0An2WxiE1uoNByvvV8wdPYM80oqw3P
=MatM
-----END PGP SIGNATURE-----

--Sig_/tMdF4iLYCUKwNLGcccgUVGx--
