From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 20:39:39 +0200
Message-ID: <200801142039.42463.caglar@pardus.org.tr>
References: <1200250801.9190.7.camel@localhost.localdomain> <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com> <1200299260.4665.17.camel@homer.simson.net>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:41145 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751469AbYANQke (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 11:40:34 -0500
In-Reply-To: <1200299260.4665.17.camel@homer.simson.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi;

14 Oca 2008 Pts tarihinde, Mike Galbraith =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> btw, CONFIG_INTEL_IOATDMA compile booboo
>=20
>   CC      drivers/dma/ioat_dma.o
> drivers/dma/ioat_dma.c: In function =E2=80=98ioat1_tx_submit=E2=80=99=
:
> drivers/dma/ioat_dma.c:300: error: too few arguments to function =E2=80=
=98__list_splice=E2=80=99
> make[2]: *** [drivers/dma/ioat_dma.o] Error 1

=46ollowing seems solves this issue;

Index: linux-2.6.23/drivers/dma/ioat_dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/drivers/dma/ioat_dma.c
+++ linux-2.6.23/drivers/dma/ioat_dma.c
@@ -260,7 +260,7 @@ static dma_cookie_t ioat1_tx_submit(stru
 	/* write address into NextDescriptor field of last desc in chain */
 	to_ioat_desc(ioat_chan->used_desc.prev)->hw->next =3D
 							first->async_tx.phys;
-	__list_splice(&new_chain, ioat_chan->used_desc.prev);
+	list_splice(&new_chain, &ioat_chan->used_desc);
=20
 	ioat_chan->dmacount +=3D desc_count;
 	ioat_chan->pending +=3D desc_count;


Cheers
--=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in=
 house!
