From: John Ogness <john.ogness@linutronix.de>
Subject: ARM pad issue with 3.0.[0-4]
Date: Tue, 13 Sep 2011 16:03:55 +0200
Message-ID: <87fwk0tu7o.fsf@vostro.fn.ogness.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37814 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1IMOEA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Sep 2011 10:04:00 -0400
Received: from localhost ([127.0.0.1] helo=vostro.fn.ogness.net)
	by Galois.linutronix.de with esmtp (Exim 4.72)
	(envelope-from <john.ogness@linutronix.de>)
	id 1R3Tah-0000YF-HE
	for linux-rt-users@vger.kernel.org; Tue, 13 Sep 2011 16:03:59 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

There is currently a bug in Linux 3.0 where the ARM pad control values
will be set to 0 instead of being left as they were when NO_PAD_CTRL is
used. This bug was fixed with commit:

425933b30b0ccfac58065bca6c853ea627443cdf

Greg has queued the patch for the next stable release (3.0.5).

I wanted to mention this here because ARM boards may be suffering from
stability problems due to mangled pad control values rather than
PREEMPT_RT issues.

John Ogness
