From: "dalampu@tin.it" <dalampu@tin.it>
Subject: patch 2.6.26.5 rt9 for ppc
Date: Thu, 25 Sep 2008 10:06:32 +0100 (GMT+01:00)
Message-ID: <11c98c274c0.dalampu@tin.it>
Reply-To: "dalampu@tin.it" <dalampu@tin.it>
Mime-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2web.tin.it ([212.216.176.236]:41775 "EHLO smtp2web.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbYIYJGe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Sep 2008 05:06:34 -0400
Received: from pswm9.cp.tin.it (192.168.70.30) by smtp2web.tin.it (8.0.022)
        id 488999AC0360F13A for linux-rt-users@vger.kernel.org; Thu, 25 Sep 2008 11:06:32 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

HI, I'm trying to install a real time kernel
into my powerpc system 
(freescale powerpc 860).

 Everything goes ok with kernel 2.6.26.5, but
 after patching with 2.6.26.5-rt9, after booting and after
 an 
apparently random time interval, it crashes with
 the message kernel :
 
panic, aiee killing interrupt handler.

 Sometimes after booting, it
 
appears ok, with shell prompt,
 but if i make some filesystem 
operations
 like "ls" the problem
 appears. Is yet known this problem 
or there's no
 feedback about ppc or powerpc systems with this rt 
patches ?
 Is there a patch about this problem ?
 I tried with another 
rt patches (like 2.6.26
 rt1, starting with a2.6.26 kernel),
 but the 
problem remains.
 Waiting an answer, i would thank you for your time
 
and for your effort to make linux a realtime os.

 Regards
 Lampugnani 
Davide
