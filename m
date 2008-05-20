From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/5] RT: adaptive-lock enhancements
Date: Tue, 20 May 2008 10:49:10 -0400
Message-ID: <20080520143954.15992.85900.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com, ghaskins@novell.com
To: mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 66-189-124-104.dhcp.oxfr.ma.charter.com ([66.189.124.104]:57718
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757154AbYETPVk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 11:21:40 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo, Steven, Thomas,
  The following series are the scraps from adaptive-locks-v3 that have not yet
  been pulled into RT.  This series applies to 25.4-rt2.

  For the most part, this is the difference between adaptive-v3 and whats in
  the upstream tree, with the following exceptions:

  1) I have fixed an issue in the "optimize-wakeup" patch that went out in v3.
     There was a hunk left-over from when we applied adaptive to both spinlocks
     and mutexes.  We have since dropped mutexes, so that patch needed to be
     refactored to be correct.

  2) I have (for now) dropped the timeout feature.  It needs to be re-worked to
     apply to the current version of adaptive-locks that are in the tree.

  I also moved what was patch 6/8 in v3 to be first, because I believe it has
  the most potential of all the other patches to improve performance.

  I have performed some baseline analysis of these patches compared to
  25.4-rt2, which you can find here:

    ftp://ftp.novell.com/dev/ghaskins/25.4-rt2-adaptive-enhancements.pdf

  I only did hackbench runs for this round of testing, but you can see there is
  a small, but net-positive gain in the results.  I think the results are more
  profound for other benchmarks, but I didnt have the time to re-run them all
  yet.

  As always, comments/questions welcome.

  Regards,
   -Greg
