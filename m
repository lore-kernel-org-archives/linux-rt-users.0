From: Monica Puig-Pey <puigpeym@unican.es>
Subject: I/O operations priority in RTOS
Date: Sat, 4 Jun 2011 14:03:46 +0200
Message-ID: <4DEA1F22.6000603@unican.es>
References: <4DEA1BA9.7020303@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver1.unican.es ([130.206.5.100]:55683 "EHLO
	ccserver1.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1FDMDS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2011 08:03:18 -0400
In-Reply-To: <4DEA1BA9.7020303@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
I'm studying how to develop drivers in a real time OS and how do they=20
work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
I would like to know the priority when executing open(), read(), write(=
)=20
and close() operations.
In my example the thread which is using the driver runs with 10 RTPRIO,=
=20
but I don't know what happens in kernel context with the priority when=20
running the I/O operations.
Thank you for your help, I don't know where to learn about this.

M=F3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
