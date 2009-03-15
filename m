From: James Cloos <cloos@jhcloos.com>
Subject: Wrong commit message for b5c0cf0d
Date: Sat, 14 Mar 2009 23:52:29 -0400
Message-ID: <m3sklffnmy.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:2095 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbZCOEDI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Mar 2009 00:03:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

After seeing the rc7-rt1 announce, I took a look at:

/pub/scm/linux/kernel/git/clrkwllms/rt-linux.git

First, the v2.6.29-rc7 tag is missing, so you can't do:

:; git log -p v2.6.29-rc7..rt-2.6.29-rc7-rt1

but you can go to Linus' tree and look at:

:; git log v2.6.29-rc6..v2.6.29-rc7 

to see that 9c1a774705 is the last commit
before v2.6.29-rc6.

So I was looking at:

:; git log -p 9c1a774705..rt-2.6.29-rc7-rt1

and noticed that the commit message for:

:; git show b5c0cf0d4e

does not resemble the patch.

