From: Tim Blechmann <tim@klingt.org>
Subject: Re: Nvidia patches for 2.6.33-rt?
Date: Tue, 02 Mar 2010 10:47:57 +0100
Message-ID: <hmimsd$jmt$1@dough.gmane.org>
References: <4ccf65461003020059h272bccfay1c9200906995a9e2@mail.gmail.com> <20100302101613.10143wu0pseylo3k@neverland.cauwe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45800 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab0CBJsL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Mar 2010 04:48:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1NmOi0-0007ET-Px
	for linux-rt-users@vger.kernel.org; Tue, 02 Mar 2010 10:48:08 +0100
Received: from 85-127-157-205.dynamic.xdsl-line.inode.at ([85.127.157.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Mar 2010 10:48:08 +0100
Received: from tim by 85-127-157-205.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Mar 2010 10:48:08 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I don't think the problem is rt-related, but generally to the vanilla
> version.

actually, it is ... atomic_spinlock_t was renamed to raw_spinlock_t, and 
apparently semaphore_init isn't there any more ... 

the first issue is trivial, for the second, i didn't follow the rt patches 
closely enough ...

tim

-- 
tim@klingt.org
http://tim.klingt.org

Your mind will answer most questions if you learn to relax and wait
for the answer.
  William S. Burroughs


