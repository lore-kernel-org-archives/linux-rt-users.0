From: cinetic bellini <cinetic19@yahoo.de>
Subject: Cyclictest on non apic plattforms
Date: Tue, 5 Dec 2006 20:02:23 +0000 (GMT)
Message-ID: <20061205200223.48889.qmail@web28012.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web28012.mail.ukl.yahoo.com ([217.146.182.117]:31790 "HELO
	web28012.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030881AbWLEUC3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 15:02:29 -0500
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi 

I uses the the RT patch on different x86 platforms (rt cyclictest).  On Pentium 4  systems I got perfect results: around 50us jitter. 
On older platforms like  P3 oder P1 I got a much worse jitter: bigger than 1000us. I think they use an older timer unit like the 8254.

It's possible to get a high resolution posix timer even on older x86 systems?

Thank you in advice,
cinetic







		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
