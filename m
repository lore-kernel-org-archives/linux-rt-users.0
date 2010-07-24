From: Roman Beslik <rabeslik@gmail.com>
Subject: RT patch, error at boot and random freezes
Date: Sat, 24 Jul 2010 08:11:41 +0300
Message-ID: <4C4A760D.3010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0GXFKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Jul 2010 01:10:33 -0400
Received: by bwz1 with SMTP id 1so1973623bwz.19
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2010 22:10:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Hello.

RT patch version: patch-2.6.33.6-rt26.bz2
platform: x86_64
original discussion: https://bbs.archlinux.org/viewtopic.php?pid=797214

1. When booting, the kernel reports this error: (screenshot 220 kB 
<http://www.beroal.in.ua/prg/linux/kernel26-rt-ice/kernel26-rt-ice-2.6.33-11-fail.jpg>)
http://www.beroal.in.ua/prg/linux/kernel26-rt-ice/kernel26-rt-ice-2.6.33-11-fail.jpg
I did not see this error with a previous version of RT patch. I use the 
standard file "config*". Error is gone when "CONFIG_FTRACE=n" is set in 
"config*".

2. I experience random freezes. They occur approximately every day. OS 
is not freezed completely: Ctrl+Alt+F* works and the cursor blinks, but 
I can type nothing into "tty". Sometimes Ctrl+Alt+F* works only several 
times than OS freezes completely. Sometimes temporary (1-10 seconds) 
freezes occur and foreshadow an everlasting freeze. I run several 
application with real time CPU and I/O priorities and "mlockall". I can 
not associate any change in operation of those programs with freezes.

Though I accustomed to these issues, it would be nice to solve them.
