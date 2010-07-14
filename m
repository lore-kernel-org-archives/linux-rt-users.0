From: Andy Pont <andy.pont@sdcsystems.com>
Subject: =?utf-8?b?dHNjX3N5bmMuYw==?=
Date: Wed, 14 Jul 2010 14:40:52 +0000 (UTC)
Message-ID: <loom.20100714T163347-616@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58477 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab0GNOlI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jul 2010 10:41:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1OZ38z-0001X0-MP
	for linux-rt-users@vger.kernel.org; Wed, 14 Jul 2010 16:41:05 +0200
Received: from 87.112.161.187 ([87.112.161.187])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Jul 2010 16:41:05 +0200
Received: from andy.pont by 87.112.161.187 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Jul 2010 16:41:05 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello!

I am trying to apply patch-2.6.31.12-rt21 to my kernel which is 2.6.31-12 but 
has some other third party patches applied to it.  

Mostly the patch has applied OK, with a couple of minor tweaks however there 
is one file that won't patch.  For some reason my kernel doesn't have a file 
arch/x86/kernel/tsc_sync.c!

What is this file used for and what risks am I opening myself up to if i just 
skip past it?

Thanks,

A.

