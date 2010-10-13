From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: real time interrupts
Date: Wed, 13 Oct 2010 13:40:35 +0530
Message-ID: <AANLkTi=PK8LSBTAQexeFbehTtPi8QUqsmP-1hkcX5Bve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64102 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0JMIKf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Oct 2010 04:10:35 -0400
Received: by iwn7 with SMTP id 7so390610iwn.19
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Oct 2010 01:10:35 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I  am using 2.6.18 kernel with rt-linux patch. In my userspace program
, I registered for signals  65,64,63,62 ( timer  ) . In my signal
handler , i have a call to localtime(). local_time() seems to be
invoking an io call.

program seems to be frozen , when all interrupts comes together. i
could see from the core ( grenerated forcifully using ABRT signal )
that all signal handler acquire some lock and suddently some other
inteerupt comes....this leads to deadlock


#15 <signal handler called>
#16 0x0070a886 in _IO_vfscanf_internal () from /lib/libc.so.6
#17 0x007170c1 in vsscanf () from /lib/libc.so.6
#18 0x00711dae in sscanf () from /lib/libc.so.6
#19 0x0073ff9f in __tzset_parse_tz () from /lib/libc.so.6
#20 0x00740f8f in __tzfile_compute () from /lib/libc.so.6
#21 0x00740845 in __tz_convert () from /lib/libc.so.6
#22 0x0073ecff in localtime () from /lib/libc.so.6

How to get away from this ?
