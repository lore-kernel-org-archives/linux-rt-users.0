From: Lee Howard <faxguy@howardsilvan.com>
Subject: yum repository for kernel-rt ?
Date: Sun, 23 Dec 2007 05:50:53 -0800
Message-ID: <476E67BD.9080601@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:38127 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbXLWN6l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Dec 2007 08:58:41 -0500
Received: from bilbo.x101.com (localhost.localdomain [127.0.0.1])
	by mail.howardsilvan.com (Postfix) with ESMTP id 63D4AC00B4
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Dec 2007 05:50:54 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello.

Is there a yum repository for kernel-rt?

Or should I get it from planetccrma-core?
http://ccrma.stanford.edu/planetccrma/software/installtwosix.html

I'm using Fedora 7 and I really would like to prioritize one particular 
PCI device that I have (which unfortunately sits on IRQ 20, the very 
last) so that it has priority over sata_nv, libata, eth0, and eth1.  Am 
I correct in believing that kernel-rt will allow me to do that?

Thanks,

Lee.
