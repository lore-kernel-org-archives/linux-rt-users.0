From: Rolf Wojtech <rolf.wojtech@fos4x.de>
Subject: Re: [PATCH-rt] rtmutex/rt: don't BUG for -EDEADLK when =?utf-8?b?ZGV0ZWN0X2RlYWRsb2Nr?= is off
Date: Thu, 18 Dec 2014 13:31:06 +0000 (UTC)
Message-ID: <loom.20141218T142837-957@post.gmane.org>
References: <1413418164-9405-1-git-send-email-paul.gortmaker@windriver.com> <loom.20141218T134759-778@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34637 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbaLRNbT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 08:31:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Y1bAj-0002QT-K7
	for linux-rt-users@vger.kernel.org; Thu, 18 Dec 2014 14:31:17 +0100
Received: from pd907f7af.dip0.t-ipconnect.de ([217.7.247.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:31:17 +0100
Received: from rolf.wojtech by pd907f7af.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:31:17 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

See also http://permalink.gmane.org/gmane.linux.rt.user/12681 by Juerg 
Haefliger (rtmutex.c:997 is the BUG_ON line in 3.14.25-rt22).
Same problem, more details, better explanation and a way to reproduce. We'll 
try to reproduce this using his method.

