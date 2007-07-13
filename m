From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: v2.6.22.1-rt3 - Early INT13 boot crash
Date: Fri, 13 Jul 2007 19:18:29 +0200
Message-ID: <4697B3E5.1050907@osadl.org>
References: <1184325752.12353.312.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:43323 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760633AbXGMS07 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:26:59 -0400
In-Reply-To: <1184325752.12353.312.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

> we are pleased to announce the v2.6.22.1-rt3 kernel
Thanks a lot!

Using the .config file from the previous stable version (2.6.21.6-rt21), 
the new version runs okay on an x86_64 system. On an i386 system, 
however, the system is crashing at an early boot stage displaying an 
INT13 reg dump at the window bottom.

After disabling paravirtualization support (CONFIG_PARAVIRT), the new 
version is working fine on i386 as well.

Just in case someone out there is experiencing the same problem.

	--cbe
