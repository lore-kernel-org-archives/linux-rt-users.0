From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: sst: use ; instead of , at the of a C
 statement
Date: Fri, 12 Jun 2015 11:37:06 +0100
Message-ID: <20150612103706.GG1921@sirena.org.uk>
References: <20150519213923.GA26363@linutronix.de>
 <55623BC2.80307@localhost>
 <20150611122227.GF16115@linutronix.de>
 <55798759.8000607@gmail.com>
 <20150611131434.GI16115@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Cc: Mats Karrman <mats.dev.list@gmail.com>,
	Vinod Koul <vinod.koul@intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150611131434.GI16115@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2015 at 03:14:34PM +0200, Sebastian Andrzej Siewior wrote:
> This was spotted by Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> while he tried to compile a -RT kernel with this driver enabled.
> "make C=2" would also warn about this. This is is based on his patch.

Applied, thanks.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerZSAAoJECTWi3JdVIfQU64H/jnKxhOl9v1Hah/atkah0/1P
aZISqGw8kt5+gSxO9R430LJRYRSd2liq2cWPzYXi/rOk/R56AQUNQizyWThcZQ1X
P8VOn7uEA/pLhwINtuz+AXnz/+v19p9fB1lB4M7XzxphzX7R9Fgnu4OJO8a5akfl
QLfootn6omflZaV0ImrxOEIYzlg/KXFnwFMiwUc25xVTlpw7P1OI+G2KpU051e47
0K17nU4Cp1Y5jHsjcoUMZ8ulY7A9KdIVEMFf89mJThDv9/ZpdgOe4BbLFw7MSKyy
IozxaP6xODZwb1nzeCYsI8U8f56jpKvS2Xcgg/OtuVirCLe22DkGbTg+06+NOZs=
=X15Y
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
