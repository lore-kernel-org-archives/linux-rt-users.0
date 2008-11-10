From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: 2.6.27.5 RT patch status (26rt11)
Date: Mon, 10 Nov 2008 18:47:40 -0500
Message-ID: <20081110234740.GB18819@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:27212 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750759AbYKJXrm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Nov 2008 18:47:42 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've updated from the 2.6.27-rc8 patch series based on 26rt9 to be
based on 2.6.27.5 kernel.org and 26rt11 preempt_rt.

I've done a successful boot to X11 on basic old P4 and it survived a
make -j20 of kernel.org git.  There is still work to be done in order to
stabilize more complex hardware (e.g. SMP etc) -- but I see this still
being the baseline for that 2.6.27.x based work.

The trees are where they were before, with the individual patches at:

git://opensource1.windriver.com/people/paulg/rt/patches

and the fully patched 2.6.27.5 git tree can be had from here:

git://opensource1.windriver.com/people/paulg/rt/linux-2.6

Note the patched tree is on the branch v2.6.27.5-26rt11 and that
master is just kernel.org master.

The patched trees are just the result of applying all the patches with
guilt, and so for those interested in the details of what changed in the
patches, looking at the patch repo is probably the most educational, i.e:

	git whatchanged v2.6.27-rc8-26rt9..v2.6.27.5-26rt11

There are gitweb links too:

http://opensource1.windriver.com/gitweb/gitweb.cgi?p=people/paulg/rt/patches

http://opensource1.windriver.com/gitweb/gitweb.cgi?p=people/paulg/rt/linux-2.6

Both the patches repo and the pre-patched trees have some itermediary
branches as well, (rt9, rt10, 2.6.27.0, etc.)

Paul.
