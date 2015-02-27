From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 0/2] mce patches rebased on simple work queue
Date: Fri, 27 Feb 2015 15:20:36 +0100
Message-ID: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:53468 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754486AbbB0OUs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Feb 2015 09:20:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Here is rebased version of mce patches using the simple work
'framework'. The patch from Steven was straight forward to port. I am
not really sure if my version on Paul's patch is not too
crazy. Feedback is more than welcome.

I tested this with mce-inject and some additional explicit calls to
mce_work_irq() at various early boot phases. It didn't explode for
me. Unfortunalty, qemu's monitor mce command didn't do anything except
crashing the machine. I guess I just use the wrong paremeters.

cheers,
daniel

Paul Gortmaker (1):
  mce: don't try to wake thread before it exists.

Steven Rostedt (1):
  x86/mce: Defer mce wakeups to threads for PREEMPT_RT

 arch/x86/kernel/cpu/mcheck/mce.c | 98 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 12 deletions(-)

-- 
2.1.0

