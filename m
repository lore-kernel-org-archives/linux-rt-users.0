From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: profile_tick not called anymore?
Date: Mon, 26 Mar 2007 15:57:59 +0200
Message-ID: <20070326155759.5dc54703@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:33938 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbXCZOBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2007 10:01:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


  Hi all,

  I see that the calls to profile_tick() have been commented out in the
different timer handlers. Why is this so?

  The only remaining place calling profile_tick() (well, in fact
__profile_tick()) is the NMI watchdog ticker, but I don't enable it
on my box.

  For info, I run the 2.6.21-rc5-rt3 kernel with high res timers turned=
 on,
NO_HZ turned off on a dual xeon box.


  S=E9bastien.
