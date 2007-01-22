From: Alessio Igor Bogani <abogani@texware.it>
Subject: compilation error
Date: Mon, 22 Jan 2007 11:29:24 +0100
Message-ID: <1169461764.26596.10.camel@godzilla.tecnorama.it>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:49977 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbXAVK3i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jan 2007 05:29:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 4F5F56080C7
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2007 11:29:33 +0100 (CET)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SRKHnR79EDeb for <linux-rt-users@vger.kernel.org>;
	Mon, 22 Jan 2007 11:29:25 +0100 (CET)
Received: from [192.168.100.121] (adsl203-157-083.mclink.it [213.203.157.83])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id E56556080B8
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2007 11:29:24 +0100 (CET)
To: linux-rt-users@vger.kernel.org
In-Reply-To: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I have this error trying to compile a minimal 2.6.20-rc5-rt7 i386
kernel:

[...]
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `init_intel':
intel.c:(.init.text+0x3c01): undefined reference to `paravirt_enabled'
make: *** [.tmp_vmlinux1] Error 1

With this trivial patch i can compile kernel successfully:

--- intel.c.orig	2007-01-22 11:03:06.000000000 +0100
+++ intel.c	2007-01-22 11:03:36.000000000 +0100
@@ -6,6 +6,7 @@
 #include <linux/smp.h>
 #include <linux/thread_info.h>
 #include <linux/module.h>
+#include <linux/paravirt.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>


But i don't know if it is the best way to resolve this problem.

Ciao,
Alessio
