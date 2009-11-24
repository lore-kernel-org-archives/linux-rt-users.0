From: Tim Blechmann <tim@klingt.org>
Subject: rt_prio branch hint
Date: Tue, 24 Nov 2009 19:50:06 +0100
Message-ID: <heh9sv$car$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41855 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933842AbZKXSu2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Nov 2009 13:50:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1ND0TB-0004zb-Aq
	for linux-rt-users@vger.kernel.org; Tue, 24 Nov 2009 19:50:33 +0100
Received: from 85-127-90-95.dynamic.xdsl-line.inode.at ([85.127.90.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2009 19:50:33 +0100
Received: from tim by 85-127-90-95.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2009 19:50:33 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi all,

not, sure, if it is an issue with the rt kernel, but the branch hint in
rt_prio appears to go to the wrong direction, when profiling on my machine:

static inline int rt_prio(int prio)
{
	if (unlikely(prio < MAX_RT_PRIO))
		return 1;
	return 0;
}

would be nice, if someone with more insight in the scheduler could have
a look at this ...

thanks, tim

- -- 
tim@klingt.org
http://tim.klingt.org

Cheat your landlord if you can and must, but do not try to shortchange
the Muse. It cannot be done. You can't fake quality any more than you
can fake a good meal.
  William S. Burroughs

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksMKtwACgkQdL+4qsZfVssrgQCgm5jeHz7I4beM4SS6nKZK6ODb
eZMAniFSN8k4tPStymprqr7V5Ypnpt+L
=/W9/
-----END PGP SIGNATURE-----

