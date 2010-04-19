From: Norval Watson <norv2001@yahoo.com.au>
Subject: 2.6.33.2-rt13 make fails
Date: Sun, 18 Apr 2010 18:29:21 -0700 (PDT)
Message-ID: <225987.20129.qm@web111305.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web111305.mail.gq1.yahoo.com ([67.195.15.155]:36314 "HELO
	web111305.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754077Ab0DSBgE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Apr 2010 21:36:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I just tried to build 2.6.33.2-rt13 kernel on a debian sid 32-bit insta=
ll.
make failed thus:

<snip>
 CC [M]  drivers/staging/comedi/drivers/quatech_daqp_cs.o
drivers/staging/comedi/drivers/quatech_daqp_cs.c:70: error: field =E2=80=
=98eos=E2=80=99 has incomplete type
drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_interrupt=E2=80=99:
drivers/staging/comedi/drivers/quatech_daqp_cs.c:291: error: implicit d=
eclaration of function =E2=80=98up=E2=80=99
drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_ai_insn_read=E2=80=99:
drivers/staging/comedi/drivers/quatech_daqp_cs.c:405: error: implicit d=
eclaration of function =E2=80=98sema_init=E2=80=99
drivers/staging/comedi/drivers/quatech_daqp_cs.c:418: error: implicit d=
eclaration of function =E2=80=98down_interruptible=E2=80=99
drivers/staging/comedi/drivers/quatech_daqp_cs.c: In function =E2=80=98=
daqp_cs_attach=E2=80=99:
drivers/staging/comedi/drivers/quatech_daqp_cs.c:1045: warning: assignm=
ent from incompatible pointer type
make[5]: *** [drivers/staging/comedi/drivers/quatech_daqp_cs.o] Error 1
make[4]: *** [drivers/staging/comedi/drivers] Error 2
make[3]: *** [drivers/staging/comedi] Error 2
make[2]: *** [drivers/staging] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC [M]  drivers/net/wireless/p54/fwio.o
  CC [M]  drivers/net/wireless/rt2x00/rt2x00dev.o

<lots more wireless drivers here>

  LD [M]  drivers/net/wireless/wl12xx/wl1271.o
  LD [M]  drivers/net/wireless/wl12xx/wl1251.o
  LD [M]  drivers/net/bnx2x.o
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/norv/KERNEL_2.6.33.2-rt13/linux-2.6.3=
3.2-rt13'
make: *** [debian/stamp/build/kernel] Error 2

Does anybody have any ideas what I might be doing wrong?
Thanks for all the rt development :)
cya
Norv


     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
