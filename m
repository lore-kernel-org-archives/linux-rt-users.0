From: Norval Watson <norv2001@yahoo.com.au>
Subject: Re: 2.6.33.2-rt13 make fails
Date: Sun, 18 Apr 2010 21:44:47 -0700 (PDT)
Message-ID: <42724.21336.qm@web111301.mail.gq1.yahoo.com>
References: <225987.20129.qm@web111305.mail.gq1.yahoo.com> <2BCC0D05-C0B2-4414-8E2D-4EA2330D899B@gmail.com> <997207.28586.qm@web111314.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web111301.mail.gq1.yahoo.com ([67.195.15.131]:45883 "HELO
	web111301.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750742Ab0DSEos convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 00:44:48 -0400
In-Reply-To: <997207.28586.qm@web111314.mail.gq1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


After disabling Staging under Device Drivers in the kernel config, the =
2.6.33.2-rt13 kernel compiles and seems to work OK. Thanks again,
Norv




----- Original Message ----
> From: Norval Watson <norv2001@yahoo.com.au>
> Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
> Sent: Mon, 19 April, 2010 12:16:58 PM
> Subject: Re: 2.6.33.2-rt13 make fails
>=20
>=20
After a bit of Googling I discovered that rt does not play well with=20
> staging drivers.
"The rt patch doesn't play nice with staging. I've compiled=20
> rt half a dozen times with staging off and never had problems."
So I am now=20
> trying to compile with no staging=20
> drivers.
Thanx!
Norv



----- Original Message ----
>=20
> From: Sven-Thorsten Dietrich <
> href=3D"mailto:thebigcorporation@gmail.com">thebigcorporation@gmail.c=
om>
>=20
> To: Norval Watson <
> href=3D"mailto:norv2001@yahoo.com.au">norv2001@yahoo.com.au>
> Cc:=20
> "
> href=3D"mailto:linux-rt-users@vger.kernel.org">linux-rt-users@vger.ke=
rnel.org"=20
> <
> href=3D"mailto:linux-rt-users@vger.kernel.org">linux-rt-users@vger.ke=
rnel.org>
>=20
> Sent: Mon, 19 April, 2010 11:55:50 AM
> Subject: Re: 2.6.33.2-rt13 make=20
> fails
>=20
> Do you need this staging driver that=20
> fails?

Sven-Thorsten Dietrich
+1=20
> (415) 480-4180

On Apr=20
> 18, 2010, at 18:29, Norval Watson <
> ymailto=3D"mailto:
> ymailto=3D"mailto:norv2001@yahoo.com.au"=20
> href=3D"mailto:norv2001@yahoo.com.au">norv2001@yahoo.com.au"=20
>=20
> href=3D"mailto:
> href=3D"mailto:norv2001@yahoo.com.au">norv2001@yahoo.com.au">
> ymailto=3D"mailto:norv2001@yahoo.com.au"=20
> href=3D"mailto:norv2001@yahoo.com.au">norv2001@yahoo.com.au>=20
>=20
> wrote:

> Hi,
> I just tried to build 2.6.33.2-rt13 kernel on a=20
>=20
> debian sid 32-bit install.
> make failed thus:
>=20
>=20
>=20
> <snip>
> CC [M] =20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.o
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:70: error: field =E2=
=80=98eos=E2=80=99 has=20
>=20
> incomplete type
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In=20
> function=20
> =E2=80=98daqp_interrupt=E2=80=99:
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:291: error: implicit=
=20
>=20
> declaration of function =E2=80=98up=E2=80=99
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function=20
>=20
> =E2=80=98daqp_ai_insn_read=E2=80=99:
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:405: error: implicit=
=20
>=20
> declaration of function =E2=80=98sema_init=E2=80=99
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:418: error: implicit=
=20
>=20
> declaration of function =E2=80=98down_interruptible=E2=80=99
>=20
>=20
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function=20
>=20
> =E2=80=98daqp_cs_attach=E2=80=99:
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:1045:=20
>=20
> warning: assignment from incompatible pointer type
> make[5]: ***=20
>=20
> [drivers/staging/comedi/drivers/quatech_daqp_cs.o] Error 1
>=20
> make[4]: ***=20
> [drivers/staging/comedi/drivers] Error 2
> make[3]:=20
> ***=20
> [drivers/staging/comedi] Error 2
> make[2]: ***=20
> [drivers/staging] Error=20
> 2
> make[2]: *** Waiting for unfinished=20
> jobs....
>  CC=20
> [M] =20
> drivers/net/wireless/p54/fwio.o
>  CC [M] =20
>=20
> drivers/net/wireless/rt2x00/rt2x00dev.o
>=20
> <lots more wireless=20
>=20
> drivers here>
>=20
>  LD [M] =20
>=20
> drivers/net/wireless/wl12xx/wl1271.o
>  LD [M] =20
>=20
> drivers/net/wireless/wl12xx/wl1251.o
>  LD [M] =20
>=20
> drivers/net/bnx2x.o
> make[1]: *** [drivers] Error 2
> make[1]:=20
>=20
> Leaving directory=20
> `/home/norv/KERNEL_2.6.33.2-rt13/linux-2.6.33.2-rt13'
>=20
> make: ***=20
> [debian/stamp/build/kernel] Error 2
>=20
> Does anybody have=20
>=20
> any ideas what I might be doing wrong?
> Thanks for all the rt development=20
>=20
> :)
> cya
> Norv
>=20
>=20
>=20
>=20
> --
> To=20
> unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users"=20
> in
> the body of a message to=20
>=20
> ymailto=3D"mailto:
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org"=20
>=20
> href=3D"mailto:
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org">
> ymailto=3D"mailto:majordomo@vger.kernel.org"=20
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org
>=20
>=20
> More majordomo info at =20
> href=3D"
> href=3D"http://vger.kernel.org/majordomo-info.html" target=3D_blank=20
> >http://vger.kernel.org/majordomo-info.html" target=3D_blank=20
> >
> href=3D"http://vger.kernel.org/majordomo-info.html" target=3D_blank=20
> >http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from=20
>=20
> this list: send the line "unsubscribe linux-rt-users" in
the body of=20
> a=20
> message to=20
> href=3D"mailto:
> ymailto=3D"mailto:majordomo@vger.kernel.org"=20
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org">
> ymailto=3D"mailto:majordomo@vger.kernel.org"=20
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org
More=20
>=20
> majordomo info at =20
> target=3D_blank >
> href=3D"http://vger.kernel.org/majordomo-info.html" target=3D_blank=20
> >http://vger.kernel.org/majordomo-info.html


     =20
>=20
--
To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
the body of a message to=20
> ymailto=3D"mailto:majordomo@vger.kernel.org"=20
> href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org
More=20
> majordomo info at =20
> target=3D_blank >http://vger.kernel.org/majordomo-info.html


     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
