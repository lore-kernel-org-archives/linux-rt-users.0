From: Juergen Beisert <jbe@pengutronix.de>
Subject: 2.6.24.3-rt3 failure on ARM
Date: Mon, 17 Mar 2008 12:09:46 +0100
Message-ID: <200803171209.47365.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52932 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252AbYCQLJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Mar 2008 07:09:54 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1JbDDw-0008SQ-6P
	for linux-rt-users@vger.kernel.org; Mon, 17 Mar 2008 12:09:53 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

using 2.6.24.3-rt3 for ARM gives me this additional error:

[...]
  CC      kernel/softirq.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
kernel/sysctl.c:356: error: 'prof_pid' undeclared here (not in a functi=
on)
make[2]: *** [kernel/sysctl.o] Error 1
make[1]: *** [kernel] Error 2

Would the patch below a correct fix?

Index: kernel/sysctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- kernel/sysctl.c.orig
+++ kernel/sysctl.c
@@ -56,6 +56,8 @@
 #include <asm/stacktrace.h>
 #endif
=20
+#include "linux/profile.h"
+
 static int deprecated_sysctl_warning(struct __sysctl_args *args);
=20
 #if defined(CONFIG_SYSCTL)


Juergen

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
