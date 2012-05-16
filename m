From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] compile fix for brcm80211 on v3.2.17
Date: Wed, 16 May 2012 01:56:50 +0100
Message-ID: <1337129810.4107.2.camel@deadeye>
References: <20120515140413.04c19fad@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5EchnRu6vO1WvTTfNg+A"
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120515140413.04c19fad@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-5EchnRu6vO1WvTTfNg+A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-15 at 14:04 -0500, Clark Williams wrote:
> Ben,
>=20
> Found this while building v3.2.17-rt28:
>=20
> diff --git a/drivers/net/wireless/brcm80211/brcmsmac/main.c b/drivers/net=
/wireless/brcm80211/brcmsmac/main.c
> index f98becc..833cbef 100644
> --- a/drivers/net/wireless/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/brcm80211/brcmsmac/main.c
> @@ -7879,7 +7879,7 @@ brcms_c_recvctl(struct brcms_c_info *wlc, struct d1=
1rxhdr *rxh,
>         if (wlc->hw->suspended_fifos) {
>                 hdr =3D (struct ieee80211_hdr *)p->data;
>                 if (ieee80211_is_beacon(hdr->frame_control))
> -                       brcms_b_mute(wlc->hw, false);
> +                       brcms_b_mute(wlc->hw, false, 0);
>         }
> =20
>         memcpy(IEEE80211_SKB_RXCB(p), &rx_status, sizeof(rx_status));
>=20
> Not sure if that's completely correct but I found another call site for
> brcms_b_mute() that also passed 0 flags.=20

Thanks, but this fix is already in the queue for 3.2.18.

Ben.

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-5EchnRu6vO1WvTTfNg+A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT7L7Uue/yOyVhhEJAQpLpw/8D84pdUObQTpJdPetZzBoDqPLMlCDmSss
Y4IsqsTcgfMmKeQbnOC9qpLdSIAfzrpUaM0qo2QxulYRFXoQU5057vWWQWHfUGlk
J5rtsYSfA6ArEJcLj887OQ8GjO8RosGQJqm8o6iAm1eKs2XE4W+JXubiwsD1iSqU
qWwo/UeKHZbadJ2Az9PyPeT19wXWmLFGzNUmX7Oh/blRDfUsJxogWWmH9h1WMOSL
DKSrRdtZS3NNqn5I393eGE95AwP+j8JwN9XST4O3yWuXI1ypAqdwSvu9PwtLpT5K
auf7DBK4o06e7sVV8U9zH3R0/xEp+4CtLNkk2AQCiGHFZ/qT2qJbqpQRuKGYcbhM
bChYdiVJ0VzY6nQQKynIF+mnCFzrkyjk41HWwdze3qsLgFK5LJYEbXVUVCiNoC3h
SXSTP6JqwySCB9iuVNESSFJoQXAf6NDt4k6bK7kJp9pw46OGgnVOBxG1qgaGf9ld
NW9E5chpGIVx1/EBMskL7WYJuNilHDdAKGOiATMa50VM48cwlr0hdobl8kV527rX
GjxJsc8JTzgZFI8VT+QcGoF5pTiwmWkMkOVnT01Rx3yVEOQMjtDmf9UilNhY4f0w
B4CO1KVBcJ7ggFlCSuXC/0Rqkf4qZh1AnUsgQhs7Itc5Z5poS8ByelkTsJUruOTD
RgIkrAVUf0Y=
=9w9O
-----END PGP SIGNATURE-----

--=-5EchnRu6vO1WvTTfNg+A--
