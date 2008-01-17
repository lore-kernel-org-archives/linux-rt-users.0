From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt2
Date: Wed, 16 Jan 2008 21:20:55 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801162119360.19540@gandalf.stny.rr.com>
References: <1200336080.318.8.camel@localhost.localdomain>
 <Pine.LNX.4.58.0801152259200.19680@gandalf.stny.rr.com>
 <200801160912.37814.caglar@pardus.org.tr> <200801161211.25948.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: =?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur <caglar@pardus.org.tr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40738 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbYAQCV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 21:21:29 -0500
In-Reply-To: <200801161211.25948.caglar@pardus.org.tr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Thomas, can you look at this. He's getting APIC errors on bootup. I'm
wondering if this isn't another strange anomaly of this controller.

He also states that he doesn't get this with the non-rt kernel.

>
> -rt3 on top of 2.6.24-rc8 works fine without that sysfs problem (acpi warnings
> still there and full dmesg can be found from [1]), whatever causes this seems
> solved :)
>
> [1] http://cekirdek.pardus.org.tr/~caglar/dmesg.rt3

-- Steve
