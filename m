From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [patch 3/3] Enable setting of IRQ-thread priorities from kernel cmdline. (repost:CC to LKML)
Date: Thu, 20 Dec 2007 14:18:16 +0100
Message-ID: <200712201418.17378.jbe@pengutronix.de>
References: <20071219194551.315868746@bohmer.net> <3efb10970712200425x4b0ffadcpd2ffa3223eda7b3d@mail.gmail.com> <1985e0f60712200445o4f854cdep6eebf1726737229b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>,
	"Remy Bohmer" <linux@bohmer.net>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>,
	"Ingo Molnar" <mingo@elte.hu>, "Darren Hart" <dvhltc@us.ibm.com>,
	"Sven-Thorsten Dietrich" <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56740 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155AbXLTNTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 08:19:40 -0500
In-Reply-To: <1985e0f60712200445o4f854cdep6eebf1726737229b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 20 December 2007 13:45, Jaswinder Singh wrote:
> On 12/20/07, Remy Bohmer <linux@bohmer.net> wrote:
> > So, Is this a serious requirement? Should this be possible?
>
> I have noticed this problem:
> root@192.168.1.253:~# cat /proc/loadavgrt
> 1.00 1.00 1.00 0/52 1158
> root@192.168.1.253:~# cat /proc/loadavg
> 0.00 0.00 0.02 1/52 1159
> root@192.168.1.253:~#
>
> So I am curious, if possible, user can switch softirq-threads or IRQs
> RT tasks to non-RT tasks for slow hardware or least important hardwar=
e
> for NON-RT tasks. So this will improve RT behaviour.
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Why?

IMHO: Simply decrease the RT priority of less important IRQs or increas=
e all=20
other more important IRQs. IRQs are always more important than other=20
processes in a system, also in non RT systems.

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
