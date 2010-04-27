From: John Kacur <jkacur@gmail.com>
Subject: 2.6.33.3-rt16 compile failure in fs/ecryptfs/inode.o
Date: Tue, 27 Apr 2010 22:05:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004272202250.3318@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2008694044-1272398755=:3318"
Cc: jstultz@gmail.com, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Nick Piggin <npiggin@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:4449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0D0UF6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Apr 2010 16:05:58 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2008694044-1272398755=:3318
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


make O=/bld/2.6.33.3-rt16/ fs/ecryptfs/inode.o
  Using /home/jkacur/jk-2.6 as source for kernel
  GEN     /bld/2.6.33.3-rt16/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    /home/jkacur/jk-2.6/scripts/checksyscalls.sh
  CC [M]  fs/ecryptfs/inode.o
/home/jkacur/jk-2.6/fs/ecryptfs/inode.c: In function 
¡ecryptfs_lookup_and_interpose_lower¢:
/home/jkacur/jk-2.6/fs/ecryptfs/inode.c:266: error: wrong type argument to 
unary exclamation mark
make[2]: *** [fs/ecryptfs/inode.o] Error 1
make[1]: *** [fs/ecryptfs/inode.o] Error 2
make: *** [sub-make] Error 2

The above comes from: 
commit 5c0eb5cec064ce26ffcd0cdd684c9b6dd7c9074e
Author: Nick Piggin <npiggin@suse.de>
Date:   Fri Jan 29 15:38:21 2010 -0800

    fs-dcache-scale-d_count

--8323328-2008694044-1272398755=:3318--
