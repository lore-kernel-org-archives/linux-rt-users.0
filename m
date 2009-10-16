From: <hollunder@gmx.at>
Subject: fork() blocking rt-threads?
Date: Fri, 16 Oct 2009 16:25:21 +0200
Message-ID: <20091016162521.457c18ee@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbZJPO0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2009 10:26:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I'm a Linux audio user and following the rt kernel development closely
(only as a user).
I've experienced something that might be relevant for all of us.

When loading the plug-in 'lv2fil' in one of our most relevant
Linux audio applications, ardour, and opening the ui, fork() was used.
This usually blocks the rt thread long enough to wreak havoc to the
underlying rt audio server jack.

What's relevant here is the ill effect of fork() and that tests
showed that vfork() works a lot better.
One ticket associated with this is:
http://nedko.arnaudov.name/soft/lv2fil/trac/ticket/9

Ardour also uses some gtk function (to open a page in the
default webbrowser) that uses fork() and causes the same problem.

Again, it seems the problem stems from the fork() implementation and is
present at least in 2.6.21.x through 2.6.31.x(-rt).
I'm quite sure this doesn't only affect us audio people.

I hope this information is of help and someone will look into it.

Best regards,
Philipp =C3=9Cberbacher
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
