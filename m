From: Michael Mueller <ss7box@gmail.com>
Subject: new to linux RT
Date: Fri, 5 Mar 2010 15:17:57 -0500
Message-ID: <615761851003051217u733c4717wd04679de318f5153@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62356 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0CEUYg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Mar 2010 15:24:36 -0500
Received: by gyd10 with SMTP id 10so685gyd.19
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Mar 2010 12:24:35 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am new to linux RT.  Not so new to rtos.  Have compiled/loaded/run
kernels from kernel.org with success in past.

I am trying to find a kernel and RT patch combination that are
compatible.  Not so much success.  Latest attempt is with
linux-2.6.31.12 where I am getting:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x3c5e): In function `con_init':
: undefined reference to `.L1446'
make: *** [.tmp_vmlinux1] Error 1

this is using the default .config

i've had this problem in other kernels as well

I was successful building 2.6.27.5 but there is not a rt patch for this release

Linux g115 2.6.27.45 #2 Tue Feb 16 11:56:21 EST 2010 i686 i686 i386 GNU/Linux

my gcc is:

Reading specs from /usr/lib/gcc/i386-redhat-linux/3.4.6/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-java-awt=gtk
--host=i386-redhat-linux
Thread model: posix
gcc version 3.4.6 20060404 (Red Hat 3.4.6-11)

any ideas, pointers, corrections, admonishments, chastisements,
thoughts, etc. would be appreciated

thanks
-- 
Mike Mueller
Xygnada Technology, Inc.
Raleigh, NC, USA
http://www.ss7box.com
ss7box@gmail.com
MSN IM: ss7box@hotmail.com
Google IM: ss7box@gmail.com
Yahoo IM: ss7box
Skype: ss7box
