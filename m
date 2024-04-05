Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA2364A4
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304371; cv=none; b=X/pg31s6texP5pJxwaYwLgDF2XEhwxUwFZzzduh9qYnbkoMpqXM9sI9Pnuv/fY9LxKYaglW2WyjjTOOLgfmZH4e0/qzkv9E5fjgFVlUsMrTbJHY6vETmHw+FCvj4qQLHEaG0TtQP+qFoej0jd4M/DVxf0kDrvZlMlkozkaS6bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304371; c=relaxed/simple;
	bh=XIhNac1lm+3a/cGdiIx9NtWoNRuBCVxDgCy9haarjhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT0vNyZwYuPYsuVVCNRmjFFNcSwwL/3ejnoLTfXyHrqbq1LEYGZ+l3I0G1m7xLZ4UWRPnwK5eXZi2wSqGAb/e1dYYElZjNYnHXLjYlWzaoaCDGjwIMmOP0sB7zP+RNHoyFFkVvNXoFBZeBh5qyGybCC2o+HcY12W4hvhwoJfPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rseaM-0000R3-RH; Fri, 05 Apr 2024 10:06:06 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rseaM-00AXEp-C2; Fri, 05 Apr 2024 10:06:06 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0891E2B26EF;
	Fri,  5 Apr 2024 08:06:06 +0000 (UTC)
Date: Fri, 5 Apr 2024 10:06:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v2 1/2] serial: imx: Introduce timeout when waiting
 on transmitter empty
Message-ID: <20240405-lapdog-poison-a8b812f9d588-mkl@pengutronix.de>
References: <cover.1712303358.git.esben@geanix.com>
 <7bfab9fb4313e64d8998a78e49411bdc7f9bd7c7.1712303358.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2p2xuoxcgd6fpl5e"
Content-Disposition: inline
In-Reply-To: <7bfab9fb4313e64d8998a78e49411bdc7f9bd7c7.1712303358.git.esben@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org


--2p2xuoxcgd6fpl5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.04.2024 09:56:37, Esben Haabendal wrote:
> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
> deadlock.
>
> In case of the timeout, there is not much we can do, so we simply ignore
> the transmitter state and optimistically try to continue.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>

For the next round you should consult "scripts/get_maintainer.pl
drivers/tty/serial/imx.c" and add these people/lists on Cc.

> ---
>  drivers/tty/serial/imx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 54b760d845c0..f7e4f38f08f3 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/dma-mapping.h>
> =20
>  #include <asm/irq.h>
> @@ -1995,7 +1996,7 @@ imx_uart_console_write(struct console *co, const ch=
ar *s, unsigned int count)
>  	struct imx_port *sport =3D imx_uart_ports[co->index];
>  	struct imx_port_ucrs old_ucr;
>  	unsigned long flags;
> -	unsigned int ucr1;
> +	unsigned int ucr1, usr2;
>  	int locked =3D 1;
> =20
>  	if (sport->port.sysrq)
> @@ -2026,8 +2027,8 @@ imx_uart_console_write(struct console *co, const ch=
ar *s, unsigned int count)
>  	 *	Finally, wait for transmitter to become empty
>  	 *	and restore UCR1/2/3
>  	 */
> -	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
> -
> +	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
> +				 0, 1000000, false, sport, USR2);

You can make use of USEC_PER_SEC here.

After fixing this, feel free to add my:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

>  	imx_uart_ucrs_restore(sport, &old_ucr);
> =20
>  	if (locked)
> --=20
> 2.44.0
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2p2xuoxcgd6fpl5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYPsOoACgkQKDiiPnot
vG9c/Qf6AyJv7Z+r1p1SzLTaRh2hTnFvxH1Z1WuDdzhz9wPe1MQYyaQzg0so5AoY
n3L3La8IFYCR9n7dQxi+JyHJSTEOnxd2ArsYVlvnfXxxVg45ocPyYg1TLVqO4PYC
9wKETbX1AEusMWbJUaTOFYaQm7oZODW0sdHvHwADm9SLRld4b9ci3llpVNmnMUF2
qe+lPbQYdzt7HmdBPCmg7U3Qlx0R+FBPQ+4H8EOBxd08MJLXoQa/oyAeawSB8rSe
+pC83cIX12GuXd24a9FMLHKuGIbNDwja1/L92fZKtNML4QBkESbOPSKyto8JnWCQ
nXwj/lCy4iys/Kt5NDeZNq7S27kaVw==
=H01w
-----END PGP SIGNATURE-----

--2p2xuoxcgd6fpl5e--
