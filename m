From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Thu, 22 Oct 2015 07:59:09 +0200
Message-ID: <20151022055909.GA7263@icarus.home.austad.us>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: linux-rt-users@vger.kernel.org, josh.cartwright@ni.com
To: Jonathan David <jonathan.david@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35342 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbJVF7O (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 01:59:14 -0400
Received: by wicll6 with SMTP id ll6so119702329wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2015 22:59:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 05:07:48PM -0500, Jonathan David wrote:
> There is a noticeable impact on determinism when a large number of
> writes are flushed. Writes to the hardware registers are sent across
> the PCI bus and take a significant amount of time to complete after
> a flush, which causes high priority tasks (including interrupts) to
> be delayed.

Do you see this in the entire system, or on the core where the write was=20
triggered?

> Adding a delay after long series of writes gives them time to
> complete, and for higher priority tasks to run unimpeded.

Aren't we running with threaded interrupts?

What happens to the thread(s) pushing data to the network?
What about xmit-buffer once it is full? Which thread will block on send or=
=20
have its sk_buff dropped?

I'm not sure if adding random delay and giving an unpredictable impact on=
=20
completely random threads is the best way to solve this..

Are you sure that there are no other ways of avoiding the latency-spikes=20
you see?

-H
(some more comments below)

> Signed-off-by: Jonathan David <jonathan.david@ni.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |  9 +++++++++
>  drivers/net/ethernet/intel/e1000/e1000.h      |  3 +++
>  drivers/net/ethernet/intel/e1000/e1000_main.c |  5 +++++
>  drivers/net/ethernet/intel/e1000e/82571.c     |  3 +++
>  drivers/net/ethernet/intel/e1000e/e1000.h     |  4 ++++
>  drivers/net/ethernet/intel/e1000e/mac.c       |  3 +++
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 18 +++++++++++++++++-
>  7 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/in=
tel/Kconfig
> index f4ff465..4c1fba2 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -85,6 +85,15 @@ config E1000E
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called e1000e.
> =20
> +config E1000_DELAY
> +	bool "Add delays to e1000x drivers"
> +	default n
> +	depends on (E1000E || E1000)
> +	---help---
> +	  Enable delays after large numbers of MMIO writes to registers.
> +	  The delays aid in preventing noticeable impact on real-time
> +	  performance when a connection is interrupted.
> +
>  config IGB
>  	tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
>  	depends on PCI
> diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ether=
net/intel/e1000/e1000.h
> index 6970710..ea405f3 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000/e1000.h
> @@ -223,6 +223,9 @@ struct e1000_rx_ring {
>  #define E1000_TX_DESC(R, i)		E1000_GET_DESC(R, i, e1000_tx_desc)
>  #define E1000_CONTEXT_DESC(R, i)	E1000_GET_DESC(R, i, e1000_context_desc)
> =20
> +/* Time to wait after writing large amount of data to registers */
> +#define E1000_WR_DELAY_RNG(val)         usleep_range(val*2, val*4)
> +

wait, so we delay for 'val' but get somewhere above *double* that?

Do we really want to add *random* delay to a network driver?

>  /* board specific private data structure */
> =20
>  struct e1000_adapter {
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/=
ethernet/intel/e1000/e1000_main.c
> index 983eb4e..eb57148 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -2331,6 +2331,11 @@ static void e1000_set_rx_mode(struct net_device *n=
etdev)
>  		 */
>  		E1000_WRITE_REG_ARRAY(hw, MTA, i, mcarray[i]);
>  	}
> +
> +#ifdef CONFIG_E1000_DELAY
> +	E1000_WR_DELAY_RNG(mta_reg_count);
> +#endif
> +
>  	E1000_WRITE_FLUSH();
> =20
>  	if (hw->mac_type =3D=3D e1000_82542_rev2_0)
> diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethe=
rnet/intel/e1000e/82571.c
> index 32e7775..3e381fe 100644
> --- a/drivers/net/ethernet/intel/e1000e/82571.c
> +++ b/drivers/net/ethernet/intel/e1000e/82571.c
> @@ -998,6 +998,9 @@ static s32 e1000_reset_hw_82571(struct e1000_hw *hw)
> =20
>  	e_dbg("Issuing a global reset to MAC\n");
>  	ew32(CTRL, ctrl | E1000_CTRL_RST);
> +#ifdef CONFIG_E1000_DELAY
> +	E1000_WR_DELAY();
> +#endif
> =20
>  	/* Must release MDIO ownership and mutex after MAC reset. */
>  	switch (hw->mac.type) {
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethe=
rnet/intel/e1000e/e1000.h
> index 0abc942..48db3df 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -89,6 +89,10 @@ struct e1000_info;
>  /* Time to wait before putting the device into D3 if there's no link (in=
 ms). */
>  #define LINK_TIMEOUT		100
> =20
> +/* Time to wait after writing large amount of data to registers */
> +#define E1000_WR_DELAY()		usleep_range(100, 150)
> +#define E1000_WR_DELAY_RNG(val)		usleep_range(val*2, val*4)
> +

Apart from the fact that 'adding random delay' is bad, why replicate this=
=20
in several headers? If you're going to add this, I'm sure others want part=
=20
of this as well.

>  /* Count for polling __E1000_RESET condition every 10-20msec.
>   * Experimentation has shown the reset can take approximately 210msec.
>   */
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethern=
et/intel/e1000e/mac.c
> index 30b74d5..d5ec122 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -353,6 +353,9 @@ void e1000e_update_mc_addr_list_generic(struct e1000_=
hw *hw,
>  	/* replace the entire MTA table */
>  	for (i =3D hw->mac.mta_reg_count - 1; i >=3D 0; i--)
>  		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +#ifdef CONFIG_E1000_DELAY
> +	E1000_WR_DELAY_RNG(hw->mac.mta_reg_count);
> +#endif
>  	e1e_flush();
>  }
> =20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 68913d1..18112ef 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3360,6 +3360,9 @@ static int e1000e_write_uc_addr_list(struct net_dev=
ice *netdev)
>  	struct e1000_hw *hw =3D &adapter->hw;
>  	unsigned int rar_entries;
>  	int count =3D 0;
> +#ifdef CONFIG_E1000_DELAY
> +	unsigned int rar_count;
> +#endif
> =20
>  	rar_entries =3D hw->mac.ops.rar_get_count(hw);
> =20
> @@ -3391,12 +3394,22 @@ static int e1000e_write_uc_addr_list(struct net_d=
evice *netdev)
>  			count++;
>  		}
>  	}
> -
> +=09
> +	/* preserve number of remaining RAR entries for delay
> +	 * function in order to prevent latency issues caused by
> +	 * MMIO writes */
> +#ifdef CONFIG_E1000_DELAY
> +	rar_count =3D rar_entries;
> +#endif
> +=09
>  	/* zero out the remaining RAR entries not used above */
>  	for (; rar_entries > 0; rar_entries--) {
>  		ew32(RAH(rar_entries), 0);
>  		ew32(RAL(rar_entries), 0);
>  	}
> +#ifdef CONFIG_E1000_DELAY
> +	E1000_WR_DELAY_RNG(rar_count);
> +#endif
>  	e1e_flush();
> =20
>  	return count;
> @@ -3476,6 +3489,9 @@ static void e1000e_setup_rss_hash(struct e1000_adap=
ter *adapter)
>  	/* Direct all traffic to queue 0 */
>  	for (i =3D 0; i < 32; i++)
>  		ew32(RETA(i), 0);
> +#ifdef CONFIG_E1000_DELAY
> +	E1000_WR_DELAY();
> +#endif
> =20
>  	/* Disable raw packet checksumming so that RSS hash is placed in
>  	 * descriptor on writeback.
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Henrik Austad

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlYoey0ACgkQ6k5VT6v45llVjQCeMfh2zKhGVN+r6MGNMlI5Wco2
o64AoKEcZYsVmOwRzYY1mSWUlgE1fHle
=p0lo
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
