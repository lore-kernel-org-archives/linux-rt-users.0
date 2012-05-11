From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Fri, 11 May 2012 20:46:12 +0200
Message-ID: <201205112046.12453.tim01@vlsi.informatik.tu-darmstadt.de>
References: <joemui$6v0$1@dough.gmane.org> <CANqCtQ+HbGMUqJuZN-weX1CbK9ecTgfdenV4WgZiDQQ_ZAYSUA@mail.gmail.com> <joj5q6$e3h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:35541 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756373Ab2EKS4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 May 2012 14:56:00 -0400
In-Reply-To: <joj5q6$e3h$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> > No, the kernel does not use the FIQ at all. It is free for you to u=
se
> > as you want. Communication with the FIQ handler can be done using a
> > queue based on atomic instructions.
Well i think there is some FIQ infrastructure in the kernel and even an=
 FIQ=20
switch. But the only thing it does is reserving the infrastructure. Not=
 more=20
not less. I have been toying around with the FIQ interrupt. On our HW (=
i.mx35)=20
we still have about 30=B5s interrupt jitter i would like to reduce. But=
 the=20
Memory for the FIQ was to small and i didn't manage to jump to some c h=
andler=20
code within the driver. Does anybody know has some examples how to do t=
hat.

=46urther since the FIQ is an own mode i thought the only thing one cou=
ld use is=20
memory accesses? But when working within the TCM or FIQ memory the jitt=
er was=20
very good (it was about 5ns if i can trust my memory).

Best regards
Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
