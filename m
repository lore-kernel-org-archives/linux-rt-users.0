From: Julia Cartwright <julia@ni.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Tue, 27 Jun 2017 09:27:57 -0500
Message-ID: <20170627142757.GA1463@jcartwri.amer.corp.natinst.com>
References: <2B18E8E1DDAE074A82D1060396451DAE263CBBD6@CNMAILEX04.lenovo.com>
 <20170626102418.310bb1ce@gandalf.local.home>
 <20170626145436.npgsaz4eyvnh2j2k@linutronix.de>
 <20170626155555.GB8190@jcartwri.amer.corp.natinst.com>
 <2B18E8E1DDAE074A82D1060396451DAE263CC234@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Feng Feng24 Liu <liufeng24@lenovo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2B18E8E1DDAE074A82D1060396451DAE263CC234@CNMAILEX04.lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2017 at 05:47:41AM +0000, Feng Feng24 Liu wrote:
> Hi, Julia
> 	Thanks for your kindly hit. I will try this patch
> 	The problem is accidental. I will try to reproduce it.
> 	BTW, could you help to give the link about the emails which
> 	discuss about " nsfs: mark dentry with DCACHE_RCUACCESS ". I
> 	cannot find them(just patch email)

Conversation upstream started with a syzkaller-found problem here:

   https://marc.info/?l=linux-netdev&m=149183505630266&w=2

Hopefully that helps,
   Julia

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAllSa2kACgkQjNrC4UVN
dG+MUQf/b5Ds0I3B4ibikDFliEabVJIsRFTSvUpbr9nMeSokcgoZb8HdMLcD5vfI
jXsoIhBMtn3dF5G2t6YmJjlWIAswpjHOwjcJPuLD29LA4fZrgUoB1xHTZTlC8TsC
Kd//WNdR2Zehb+7klsxiba8cNM+05lMTxfodvDalERok2P2pW35WiTuM3lAgYVNl
g1CKVSPFLpwrwdwo64yJBdH4QsDaIAi+C1wd9qLvwp7dw2GJyCi1OOWXBD8M1sxY
FcOdHQC0hP+A8AZvrqfKJ3/3G8MbEnwihiPAt1FMD9lH828U/Ge35g7vUqG94uHD
3Q3633wbHSL7P8wsX+QOrsSJbR78jw==
=jOSh
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
