From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: 2.6.27-rc8 RT patch status
Date: Fri, 3 Oct 2008 16:54:05 -0400
Message-ID: <7d1d9c250810031354i11857b00y8146e73a0c94653a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:59208 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYJCUyH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 16:54:07 -0400
Received: by rn-out-0910.google.com with SMTP id k40so605297rnd.17
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Oct 2008 13:54:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've updated the 27-rc8 patch series based on 26rt9 to include some
fixes for x86_64 compiles, and ARM compiles, plus the fix for the
sporadic boot failures I saw on x86.  I expect to incorporate Greg's
patches etc. at some point; probably when I incorporate whatever
changes come along with 26rt10.

I've done a successful boot on an ixp465  with an e100 as NFS root,
and on a sbc8548 with e1000 as NFS root, so both ARM and powerpc
core arch support are reasonably sane.   I've found that x86_64 boots
to a shell OK, but under any additional loading, it gets angry at the
world and falls over, so it will need some more attention.

The trees are where they were before, with the individual patches at:

git://opensource1.windriver.com/people/paulg/rt/patches

and the fully patched 2.6.27-rc8 git tree can be had from here:

git://opensource1.windriver.com/people/paulg/rt/linux-2.6

Note the patched tree is on the branch v2.6.27-rc8-26rt9.1 and that master
is just kernel.org master.   There are gitweb links too, if anyone likes those:

http://opensource1.windriver.com/gitweb/gitweb.cgi?p=people/paulg/rt/patches

http://opensource1.windriver.com/gitweb/gitweb.cgi?p=people/paulg/rt/linux-2.6

Paul.
