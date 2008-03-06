From: <H.Jesuiter@heyfra.de>
Subject: WG: missing prof_pid in sysctl.c
Date: Thu, 6 Mar 2008 10:42:22 +0100
Message-ID: <3F089A1DC8B9D848A53332D54893DEE00181F8A5@srvde090.weidmueller.com>
References: <3F089A1DC8B9D848A53332D54893DEE00181F89D@srvde090.weidmueller.com> <3F089A1DC8B9D848A53332D54893DEE00181F89E@srvde090.weidmueller.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.weidmueller.de ([217.244.7.241]:57108 "HELO
	mail2.weidmueller.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756195AbYCFMvg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Mar 2008 07:51:36 -0500
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

while trying to compile your current rt-Patch (rt3) for the current 
Linux Kernel version (2.6.24.3), i found a compile error on a missing
'prof_pid' in kernel/sysctl.c. After investigating in this little 
problem, i found, that the current rt-patch either misses
a) an '#include "profile.h"', or
b) an 'extern int prof_pid'
in 'kernel/sysctl.c'

Regards
Henry Jesuiter
