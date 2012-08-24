From: =?UTF-8?B?UmFsZiBSw7ZzY2g=?= <rtlinux@cantastic.org>
Subject: Memory leak in 3.4.x-rt ?
Date: Fri, 24 Aug 2012 14:38:11 +0200
Message-ID: <503775B3.4080504@cantastic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rs1.rw-gmbh.net ([213.239.201.58]:50230 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757771Ab2HXNPb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2012 09:15:31 -0400
Received: from p50992dee.dip0.t-ipconnect.de ([80.153.45.238] helo=[192.168.178.112])
	by rs1.rw-gmbh.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <rtlinux@cantastic.org>)
	id 1T4t9k-0005S5-FL
	for linux-rt-users@vger.kernel.org; Fri, 24 Aug 2012 14:38:32 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

we work on our TX4938 (Toshiba Mips, little endian mode) based embedded 
system (motion control)
running successfully a 3.2 RT patched kernel for month now.

I just give a try to a 3.4 RT patched kernel and detected a memory 
problem as you can see from the logs below:

3.2 with RT FULL PREEMPT is o.k
3.4 without RT FULL PREEMPT is .ok.
3.4 with RT FULL PREEMPT is not o.k.

Can anyone give me hint in which direction I could go to detect the 
problem or has anyone else the same problem?

Thanks and regards
Ralf


Linux MCU 3.2.27-rt40-00027-g8fd8396 #36 PREEMPT RT Mon Aug 20 16:21:04 
CEST 2012 mips GNU/Linux
[root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
MemFree:          216992 kB
MemFree:          216992 kB
MemFree:          216944 kB
MemFree:          216992 kB
MemFree:          216992 kB
MemFree:          216992 kB
MemFree:          216992 kB

uname -a
Linux MCU 3.4.9-rt17-11244-gb12622a #23 PREEMPT RT Fri Aug 24 12:15:49 
CEST 2012 mips GNU/Linux
[root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
MemFree:          204304 kB
MemFree:          204208 kB
MemFree:          204112 kB
MemFree:          204064 kB
MemFree:          203968 kB
MemFree:          203920 kB
MemFree:          203824 kB
MemFree:          203776 kB

uname -a
Linux MCU 3.4.9-rt17-11244-gb12622a #24 PREEMPT Fri Aug 24 14:15:04 CEST 
2012 mips GNU/Linux
[root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
MemFree:          222240 kB
MemFree:          222192 kB
MemFree:          222192 kB
MemFree:          222192 kB
MemFree:          222144 kB
MemFree:          222144 kB
MemFree:          222192 kB
MemFree:          222144 kB
MemFree:          222192 kB
MemFree:          222144 kB


