From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: patch-2.6.24-rt1 : ARM doesn't select =?utf-8?b?SEFWRV9NQ09VTlQ=?=
Date: Fri, 15 Feb 2008 16:32:15 +0000 (UTC)
Message-ID: <loom.20080215T162755-464@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57170 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbYBOQfI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Feb 2008 11:35:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JQ3Wg-0002ZG-1d
	for linux-rt-users@vger.kernel.org; Fri, 15 Feb 2008 16:35:02 +0000
Received: from 6.177.115-78.rev.gaoland.net ([6.177.115-78.rev.gaoland.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2008 16:35:02 +0000
Received: from matthieu.castet by 6.177.115-78.rev.gaoland.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2008 16:35:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

patch-2.6.24-rt1 seems broken for arm :
- ARM doesn't select HAVE_MCOUNT
- mcount doesn't compile due to "mov     r2, =mcount_trace_function"


Matthieu
