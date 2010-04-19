From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: 2.6.33.2-rt13 make fails
Date: Sun, 18 Apr 2010 18:55:50 -0700
Message-ID: <2BCC0D05-C0B2-4414-8E2D-4EA2330D899B@gmail.com>
References: <225987.20129.qm@web111305.mail.gq1.yahoo.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Norval Watson <norv2001@yahoo.com.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63475 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0DSB4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Apr 2010 21:56:01 -0400
Received: by pwj9 with SMTP id 9so3010256pwj.19
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Apr 2010 18:56:00 -0700 (PDT)
In-Reply-To: <225987.20129.qm@web111305.mail.gq1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Do you need this staging driver that fails?

Sven-Thorsten Dietrich
+1 (415) 480-4180

On Apr 18, 2010, at 18:29, Norval Watson <norv2001@yahoo.com.au> wrote:

> Hi,
> I just tried to build 2.6.33.2-rt13 kernel on a debian sid 32-bit =20
> install.
> make failed thus:
>
> <snip>
> CC [M]  drivers/staging/comedi/drivers/quatech_daqp_cs.o
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:70: error: field =E2=
=80=98e=20
> os=E2=80=99 has incomplete type
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_=20
> interrupt=E2=80=99:
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:291: error: =20
> implicit declaration of function =E2=80=98up=E2=80=99
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_=20
> ai_insn_read=E2=80=99:
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:405: error: =20
> implicit declaration of function =E2=80=98sema_init=E2=80=99
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:418: error: =20
> implicit declaration of function =E2=80=98down_interruptible=E2=80=99
> drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_=20
> cs_attach=E2=80=99:
> drivers/staging/comedi/drivers/quatech_daqp_cs.c:1045: warning: =20
> assignment from incompatible pointer type
> make[5]: *** [drivers/staging/comedi/drivers/quatech_daqp_cs.o] =20
> Error 1
> make[4]: *** [drivers/staging/comedi/drivers] Error 2
> make[3]: *** [drivers/staging/comedi] Error 2
> make[2]: *** [drivers/staging] Error 2
> make[2]: *** Waiting for unfinished jobs....
>  CC [M]  drivers/net/wireless/p54/fwio.o
>  CC [M]  drivers/net/wireless/rt2x00/rt2x00dev.o
>
> <lots more wireless drivers here>
>
>  LD [M]  drivers/net/wireless/wl12xx/wl1271.o
>  LD [M]  drivers/net/wireless/wl12xx/wl1251.o
>  LD [M]  drivers/net/bnx2x.o
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/home/norv/KERNEL_2.6.33.2-rt13/=20
> linux-2.6.33.2-rt13'
> make: *** [debian/stamp/build/kernel] Error 2
>
> Does anybody have any ideas what I might be doing wrong?
> Thanks for all the rt development :)
> cya
> Norv
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-=20
> users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
