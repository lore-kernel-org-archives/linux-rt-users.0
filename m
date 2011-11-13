From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.2-rc1-rt1
Date: Sun, 13 Nov 2011 23:57:50 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111132213220.2694@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45086 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab1KMW5w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Nov 2011 17:57:52 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.2-rc1-rt1 release.

It's a straight forward port of the 3.0-rt patch queue, which reduced
the patch size by more than 25% from 807k to 580k. The diffstat change
is:

 429 files changed, 10118 insertions(+), 3000 deletions(-)
 318 files changed,  8871 insertions(+), 1858 deletions(-)

Thanks to all who helped polishing patches and bringing them mainline!


The test results on my reference machine are in the 3.0-rt ballpark
and I have not seen any frightening explosions so far.


3.2-rc1-rt is not against 3.2-rc1 - it's against the post rc1
commit 52e4c2a05256cb83cda12f3c2137ab1533344edb.

   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=52e4c2a05256cb83cda12f3c2137ab1533344edb


For non git users conveniance I uploaded a delta patch against
3.2-rc1:

   https://tglx.de/~tglx/rt/3.2/base/patch-3.2-rc1-52e4c2a05-rt1.patch.gz

to get the base kernel on which the RT patch applies.


The RT patch against 3.2-rc1-52e4c2a05 can be found here:

   https://tglx.de/~tglx/rt/3.2/patch-3.2-rc1-52e4c2a05-rt1.patch.gz


The split quilt queue is available at:

   https://tglx.de/~tglx/rt/3.2/patches-3.2-rc1-52e4c2a05-rt1.tar.gz


Enjoy,

	tglx
