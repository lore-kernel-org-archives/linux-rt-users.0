From: Grammostola Rosea <rosea.grammostola@gmail.com>
Subject: irqreturn.h:14: error
Date: Thu, 23 Apr 2009 15:35:22 +0200
Message-ID: <49F06E9A.4070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:53157 "EHLO
	smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758136AbZDWNkv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 09:40:51 -0400
Received: from [212.54.42.140] (helo=smtp9.tb.mail.iss.as9143.net)
	by smtpq4.tb.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1LwzAY-0008Ak-Nl
	for linux-rt-users@vger.kernel.org; Thu, 23 Apr 2009 15:40:50 +0200
Received: from cc305009-a.groni1.gr.home.nl ([82.73.157.254] helo=[192.168.1.104])
	by smtp9.tb.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1LwzAY-0001qq-3r
	for linux-rt-users@vger.kernel.org; Thu, 23 Apr 2009 15:40:50 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I get an error when building an RT kernel.

Help would be nice :)

\r


CC [M] drivers/staging/at76_usb/at76_usb.o
CC [M] drivers/staging/comedi/comedi_fops.o
In file included from drivers/staging/comedi/comedidev.h:40,
from drivers/staging/comedi/comedi_fops.c:45:
drivers/staging/comedi/interrupt.h:27: error: conflicting types for=20
=91irqreturn_t=92
include/linux/: previous declaration of =91irqreturn_t=92 was here
In file included from drivers/staging/comedi/comedidev.h:40,
from drivers/staging/comedi/comedi_fops.c:45:
drivers/staging/comedi/interrupt.h:30:1: warning: "IRQ_RETVAL" redefine=
d
In file included from include/linux/interrupt.h:10,
from drivers/staging/comedi/interrupt.h:22,
from drivers/staging/comedi/comedidev.h:40,
from drivers/staging/comedi/comedi_fops.c:45:
include/linux/irqreturn.h:15:1: warning: this is the location of the=20
previous definition
make[4]: *** [drivers/staging/comedi/comedi_fops.o] Fout 1
make[3]: *** [drivers/staging/comedi] Fout 2
make[2]: *** [drivers/staging] Fout 2
make[1]: *** [drivers] Fout 2
make[1]: Map '/home/d/debian_pakketbouw/kernel/linux-2.6.29.1' wordt=20
verlaten
make: *** [debian/stamp/build/kernel] Fout 2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
