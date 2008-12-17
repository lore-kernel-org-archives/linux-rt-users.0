From: "Audiodef" <damien@audiodef.com>
Subject: rt-sources 2.6.26.6-rt11 fails to make
Date: Wed, 17 Dec 2008 15:04:02 -0700
Message-ID: <20081217150402.cafa8173a4e6358765f4d9836504dcb0.e8d81f4a79.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpoutwbe05.prod.mesa1.secureserver.net ([208.109.78.207]:51543
	"HELO smtpoutwbe05.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751860AbYLQWKn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Dec 2008 17:10:43 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everyone,

I'm trying to set up a Gentoo Linux box with the goal of eventually
getting rid of Windoze completely (I currently have 1 remaining Windoze
workstation because of my Mackie Onyx (w/ Firewire) mixers). So I tried
to compile rt-sources 2.6.26.6-r11 and this is what happened:

 CHK include/linux/version.h
 CHK include/linux/utsrelease.h
 CC arch/x86/kernel/asm-offsets.s
In file included from include/linux/notifier.h:14,
 from include/linux/memory_hotplug.h:6,
 from include/linux/mmzone.h:560,
 from include/linux/gfp.h:4,
 from include/linux/slab.h:12,
 from include/linux/percpu.h:5,
 from include/linux/rcupdate.h:39,
 from include/linux/tracepoint.h:18,
 from include/linux/module.h:19,
 from include/linux/crypto.h:21,
 from arch/x86/kernel/asm-offsets_32.c:7,
 from arch/x86/kernel/asm-offsets.c:2:
include/linux/rwsem.h:150: error: redefinition of 'rwsem_is_locked'
include/asm/rwsem.h:261: error: previous definition of 'rwsem_is_locked'
was here
include/linux/rwsem.h: In function 'rwsem_is_locked':
include/linux/rwsem.h:151: error: implicit declaration of function
'compat_rwsem_is_locked'
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2 

I can compile 2.6.16, but it's too old for the udev I have. I have
similar problems trying to compile other later rt-sources versions. I've
posted about it at
http://forums.gentoo.org/viewtopic-t-718166-highlight-.html. I'd
appreciate any tips or advice as to how I can get the latest rt-sources
compiled. 

