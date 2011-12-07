From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: reboot fails on preempt rt 3.0.12-rt29
Date: Wed, 7 Dec 2011 23:42:33 +0100
Message-ID: <201112072342.33752.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:32924 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757080Ab1LGWmp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Dec 2011 17:42:45 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

As you might now i am running a slightly patched rt 3.0.12-rt29 on arm pcm43 
platform. Strangely the upstart 1.3 reboot command gives me very seldom the 
error: 
"reboot: Unable to execute shutdown: Bad address"

Since the string "Bad address" is nowhere to find within the upstart or libnih 
sources i guess it is coming from the kernel sources or perror?

Reboot in turn calls shutdown -r via execv. When calling reboot another time 
it just works... The error seems so seldom that it didn't occur to me two 
times in a row for now.

Best regards
Tim

