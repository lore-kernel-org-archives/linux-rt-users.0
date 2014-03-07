From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FlexCAN on i.MX28 interrupt flooding retrying send
Date: Fri, 07 Mar 2014 09:46:11 +0100
Message-ID: <53198753.8000900@pengutronix.de>
References: <53197E8A.5050409@meduna.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nqrWS7OjgRE4PMS5lb7OxfumiIbJTxuRA"
To: Stanislav Meduna <stano@meduna.org>, wg@grandegger.com,
	linux-can@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <53197E8A.5050409@meduna.org>
Sender: linux-can-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nqrWS7OjgRE4PMS5lb7OxfumiIbJTxuRA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 09:08 AM, Stanislav Meduna wrote:
> Hi,
>=20
> I am using a FlexCAN CAN controller on a Freescale i.MX28 platform [1].=

> If a packet is being sent when the bus is disconnected, I am getting
> an interrupt flooed that basically kills the machine.
>=20
> This is _not_ the same problem as [2] - my kernel already has
> the fix.
>=20
> The first interrupt comes with ESR 0x00028652, i.e.
>=20
> TXWRN_INT
> BIT1_ERR
> STF_ERR
> TX_WRN
> TXRX
> FLT_CONF error passive
> ERR_INT
>=20
> The next ones come the same without the acked TXWRN_INT.
> Reading the ESR again immediately after acking gives
> 0x00000250, i.e.
>=20
> TX_WRN
> TXRX
> FLT_CONF error passive
>=20
> so everything ackable has actually been acked.
>=20
> I think that the problem is that the FlexCAN tries to retransmit
> the frame indefinitely. Each retry senses the bus in the invalid
> state (BIT1_ERR) and immediately fires a new ERR_INT. To verify
> this I aborted the transmitted frame in the error state in the
> interrupt handler
>=20
> #define FLEXCAN_ESR_ERR_TRANSMIT \
> 	(FLEXCAN_ESR_BIT1_ERR | FLEXCAN_ESR_BIT0_ERR | FLEXCAN_ESR_ACK_ERR)
>=20
> if (reg_esr & FLEXCAN_ESR_ERR_TRANSMIT) {
>=20
> 	/* In case of a transmission error the packet is retried and
> 	 * if the error persists, we will get another interrupt right
> 	 * away. Abort the transmission - a lost packet is better than
> 	 * an irq storm.
> 	 */
> 	if(printk_ratelimit())
> 		netdev_err(dev, "Aborted transmission, ESR %08x\n", reg_esr);
>=20
> 	can_get_echo_skb(dev, 0);
> 	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
> 		&regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> 	netif_wake_queue(dev);
> }
>=20
> and the problem disappeared as expected. However, the correct
> way is probably to retry during some reasonable (configurable?)
> time interval.
>=20
> What puzzles me is that I did not found any other instance
> of this problem in the relevant mailing lists, only the original [2].
>=20
> I am using the 3.4.77 kernel with the realtime patches, but the
> code in the latest mainline looks the same in this respect.
> Maybe the realtime patches change some bevaviour, but I don't
> think they affect the core problem. I am not really an expert
> in the network devices, NAPI etc - maybe in that case the error
> interrupt should be disabled and re-enabled only if the
> error condition goes away? - I don't know...

Your kernel is missing the patch:

e358784 can: flexcan: fix mx28 detection by rearanging OF match table

With this patch the CAN core properly detected as an mx28, so that bus
errors stay disabled (unless you enable them). If you need bus errors to
detect not connected CAN busses, you need another patchset berr_limit,
which is not yet mainline. I can repost it here, if you need it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nqrWS7OjgRE4PMS5lb7OxfumiIbJTxuRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMZh1MACgkQjTAFq1RaXHPF1gCeMkWJUuGKI3IVpxm1Ti1J5r69
8UMAn1x15oSn2tZkXqbu9Ma9byYMEFjz
=U52+
-----END PGP SIGNATURE-----

--nqrWS7OjgRE4PMS5lb7OxfumiIbJTxuRA--
