From: Oguz Yarimtepe <oguzyarimtepe@gmail.com>
Subject: PF_RING compilation error at rt kernel
Date: Thu, 11 Oct 2012 19:31:57 +0300
Message-ID: <20121011193157.16c940c8643f04ac04bb63d3@gmail.com>
Reply-To: linux-rt-users@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:45555 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614Ab2JKQcJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 12:32:09 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so378112eaa.19
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Oct 2012 09:32:08 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I installed PREEMPTIVE kernel to my Debian squeeze base system by follo=
wing the instructions http://www.pengutronix.de/software/linux-rt/debia=
n_en.html adress. My current kernel is 2.6.33.7.2-rt30-1-686 after i in=
stalled linux-image-2.6-rt-osadl-${ARCH}.

I checked out PF_RING from ntop site and tried make command after i ins=
talled flex, bison and build-essential package. Below is the error mess=
age i got:

$ make
make -C /lib/modules/2.6.33.7.2-rt30-1-686/build SUBDIRS=3D/home/oguz/P=
=46_RING/kernel EXTRA_CFLAGS=3D'-I/home/oguz/PF_RING/kernel -DSVN_REV=3D=
"\"5743\""' modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.33.7.2-rt30-1-6=
86'
  CC [M]  /home/oguz/PF_RING/kernel/pf_ring.o
/home/oguz/PF_RING/kernel/pf_ring.c: In function =E2=80=98init_ring_rea=
ders=E2=80=99:
/home/oguz/PF_RING/kernel/pf_ring.c:257: error: expected expression bef=
ore =E2=80=98{=E2=80=99 token
/home/oguz/PF_RING/kernel/pf_ring.c: In function =E2=80=98init_lockless=
_list=E2=80=99:
/home/oguz/PF_RING/kernel/pf_ring.c:466: error: expected expression bef=
ore =E2=80=98{=E2=80=99 token
make[4]: *** [/home/oguz/PF_RING/kernel/pf_ring.o] Error 1
make[3]: *** [_module_/home/oguz/PF_RING/kernel] Error 2
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.33.7.2-rt30-1-68=
6'
make: *** [all] Error 2

What can be the reason for it?=20

Cheers.

--=20
Oguz Yarimtepe <oguzyarimtepe@gmail.com>
http://about.me/oguzy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
