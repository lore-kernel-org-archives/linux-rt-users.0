From: Dragan Noveski <perodog@gmx.net>
Subject: 2.6.21.5-rt14 wont'compile here
Date: Sun, 17 Jun 2007 14:37:11 +0200
Message-ID: <46752AF7.10508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752203AbXFQMhq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Jun 2007 08:37:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi list,
since i am trying to compile 2.6.24/25 kernel with the rt-patches, no 
one version will compile here and i always get the same output.
this is how it looks like while trying to compile 2.6.21.4-rt13, but it 
looks the same for 2.6.21.5-rt14 :


.....
 GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o:(.data+0x5d8): undefined reference to 
`preempt_mark_thresh'
make: *** [.tmp_vmlinux1] Fehler 1



for me this looks related to:

http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00447.html

but i don't know how to fix it myself.

i would appreciate any help in  finding out more about this problem  or 
how to solve it.


cheers,
doc
