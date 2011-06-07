From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 7 Jun 2011 10:27:35 +0200 (CEST)
Message-ID: <17185480.5304.1307435255996.JavaMail.root@WARSBL214.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Monica Puig-Pey <puigpeym@unican.es>,
	Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>, hannes_bauer@aon.at
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout02.highway.telekom.at ([195.3.96.113]:44203 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752072Ab1FGI1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jun 2011 04:27:40 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Absolutly correct!

However, if you are running the system on an embedded platform, where t=
he _WHOLE_ system (including priorities) is preconfigured and never tou=
ched, starting a irq thread with the right prio from start is a more st=
raightforward method than having to invoke a script that changes it usi=
ng userspace chrt tool.

Regards JB
----- Urspr=C3=BCngliche Nachricht -----
Von: "Peter Zijlstra" <peterz@infradead.org>
Erhalten: 07.06.2011 00:36
An: hannes_bauer@aon.at

"Monica Puig-Pey" wrote:
>=20
> I need to change the priority from inside the driver, when creating t=
he=20
> kernel thread.

No you don't. How does you driver know about what priority is correct
wrt all the other running RT tasks on the system?

Determining the right priority in a fixed priority scheduling system is
a system wide problem, nobody but the administrator can possibly even
begin to solve it.

There's a reason all RT irq threads are started at 50, its plain
impossible to do better.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
