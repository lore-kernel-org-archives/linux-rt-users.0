From: Al Dorrington <albert.dorrington@lmco.com>
Subject: Fedora 10 as basis for RT?
Date: Thu, 9 Apr 2009 13:49:29 +0000 (UTC)
Message-ID: <loom.20090409T134400-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759884AbZDIOAG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 10:00:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LrunS-0001CB-TY
	for linux-rt-users@vger.kernel.org; Thu, 09 Apr 2009 14:00:03 +0000
Received: from proxy3a.external.lmco.com ([192.35.35.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Apr 2009 14:00:02 +0000
Received: from albert.dorrington by proxy3a.external.lmco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Apr 2009 14:00:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am working on a proof of concept project where we are going to try moving an
application that runs on VxWorks to Linux. I believe with what I've read on this
mailing list, and the RTwiki site that Linux is definitely up to the task with
these kernel patches.

However, I am not really sure which distribution of Linux we should use as the
base, nor am I sure if it would be better to stick with the 'i386' distribution
or go with the x86_64 variant.

I am considering Fedora 10, either i386 or x86_64. 

Does anyone have any comments or recommendations for which might be better to
use, or if we would be better off using another distribution?

Thanks!
- Al Dorrington

