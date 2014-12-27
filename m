From: Valdis.Kletnieks@vt.edu
Subject: Re: Help needed to implement parameter in SCHED_DEADLINE policy
Date: Sat, 27 Dec 2014 15:19:47 -0500
Message-ID: <45259.1419711587@turing-police.cc.vt.edu>
References: <CAD2dHrTBZd6a_QdEqh4xhVj1c-e4bzAKF5uC4N6B+UEh-zgxvg@mail.gmail.com>
	<20141226221424.GA8000@sisyphus.home.austad.us>
	<CAD2dHrTRVYp+5u+B=EAcryP6s5BFCvOyzs6ntDgMQkNTpDQDPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2185233373370688081=="
Cc: Henrik Austad <henrik@austad.us>, linux-rt-users@vger.kernel.org,
	kernelnewbies@kernelnewbies.org
To: Chanchal Paul <paulchanchal.ece@gmail.com>
Return-path: <kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org>
In-Reply-To: Your message of "Sun, 28 Dec 2014 00:09:36 +0530."
	<CAD2dHrTRVYp+5u+B=EAcryP6s5BFCvOyzs6ntDgMQkNTpDQDPg@mail.gmail.com>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org
Errors-To: kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org
List-Id: linux-rt-users.vger.kernel.org

--===============2185233373370688081==
Content-Type: multipart/signed; boundary="==_Exmh_1419711587_1876P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1419711587_1876P
Content-Type: text/plain; charset=us-ascii

On Sun, 28 Dec 2014 00:09:36 +0530, Chanchal Paul said:
> their DEADLINE. I dont want to disturb that order. If a scheduler
> picks up a task which is computationally intensive and lets it run
> then due to its thermal characteristic it may heat up processor so
> much that eventually a hardware DTM or a frequency scaling occurs and
> the system slows down as a effect.

This is properly the domain of CPU governors, not schedulers. Modern Intel
chipsets with the Turbo feature will dynamically up-throttle to whatever the
cooling budget allows, and if you have an older chipset that doesn't do that,
you're better off creating a custom governor that doesn't allow selection of
the highest CPU frequenc(y|ies) that exceed the current cooling budget

Note that this gets tricky on multi-core sockets, as activity on other
cores affects the cooling budget for the core you're scheduling onto.

And if your hardware is throwing actual thermal shutdown events, you have
bigger problems that scheduler hacks won't help.



--==_Exmh_1419711587_1876P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVJ8UYwdmEQWDXROgAQJ/RBAAlb3j460aI0pm91Wc5k5ePnSDfPstmU90
AJ0+2qJHqvvdFAbliw5/2xQGXYPiX1pKDMpFoFkGkF9NK1eO4ZULu7km+DKF0O4B
xeLlg8vNqpRQAEawmVHSnSkvJQ63DTwjfNjgRxGKxEf2eXVhVUXHQeW5/vm9NyBQ
VWPnyIIMf4bdnMu2TqtfYT6uThInLsJmuavBDKQaZJP/yRcifMJZeTAuT6BhPuws
iuaBMtHUj9kCLj5U+fcG8oKaSB6vO655LHATprWyr6u2Xrgp8XfmTNZdR0beNpMv
JPfE5a+c+k75lE0T9PMzzl9Yco1orl9n1tswdgJPOkC+hyxJKkKwx9yHCwIzSeZc
ABHFEsZDyLF2bxYl4Z5SPXM1vayzt9Y5J28R9BBFTCx9WE+i7Nwts0NPZLv0yUWv
tKbBV+4FHMkmxxx8nXzjNerHOpN03BlvbLkcXLb147fvVYSPJyZF86R54WI9ZSKX
fKF5rryu9+VnvTfRizSFhfPU/VdVmfEArOF+pVt9lb0aZbFbSt/PYYxASoLTKpSr
FarkYUXQpQ3trGyeUwgsSTJKfeFBcF3hgLy8DJGG2fDC1y7WPVeKR1BQ9co5Y2mE
5Q+ERV6p5oQGeO3NpkifagT6dA/xsdYJ3+GAbIlHokIWop1rTbyTFq5idzYiOlus
s6KVNSKtD/w=
=IxA/
-----END PGP SIGNATURE-----

--==_Exmh_1419711587_1876P--


--===============2185233373370688081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============2185233373370688081==--
