From: John Ogness <john.ogness@linutronix.de>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 03 Feb 2012 11:54:51 +0100
Message-ID: <87ehuctcec.fsf@vostro.fn.ogness.net>
References: <4F292FE0.7090302@digi.com>
	<201202021338.44950.tim.sander@hbm.com> <4F2A8850.4080201@digi.com>
	<201202021525.05606.tim.sander@hbm.com>
	<1328206245.5882.113.camel@gandalf.stny.rr.com>
	<4F2BB25E.7090708@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, Tim Sander <tim.sander@hbm.com>,
	lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Hector Palacios <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41252 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab2BCKy5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 05:54:57 -0500
In-Reply-To: <4F2BB25E.7090708@digi.com> (Hector Palacios's message of "Fri,
	03 Feb 2012 11:09:34 +0100")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Unfortunately I don't have time to look into this right now. But this
problem really reminds of a problem in 2010 we had with the FEC driver
that was also related to early network traffic causing the kernel to
hang. The commit in git to fix it is:

03c698c93fc15d976738a853a7ccb6ea26396003

Perhaps this is the same problem in a different costume.

John Ogness
