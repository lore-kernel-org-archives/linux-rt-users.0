From: Alessio Igor Bogani <abogani@texware.it>
Subject: Two questions about high resolution timers
Date: Thu, 21 Jun 2007 17:06:14 +0200
Message-ID: <1182438374.4726.19.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:34981 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbXFUPGR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jun 2007 11:06:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id DBD2B608176
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jun 2007 17:06:15 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uMuoYvIujI0T for <linux-rt-users@vger.kernel.org>;
	Thu, 21 Jun 2007 17:06:15 +0200 (CEST)
Received: from [192.168.100.121] (adsl203-157-083.mclink.it [213.203.157.83])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id 2D8D0608174
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jun 2007 17:06:15 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi to all,

Sorry for my poor english.

1) What are reliable clocksources?

2) I have a mainboard with a 500 Mhz cpu which works perfectly with RT.
I suppose that the max resolution is 2 ns for the high resolution timers
but a "cat /proc/timer_list" reported:

cpu: 0
 clock 0:
  .index:      0
  .resolution: 1 nsecs <----

active timers:
 clock 1:
  .index:      1
  .resolution: 1 nsecs <----

How it is possible that this mainboard have 1 nsecs resolution?

Excuse me if it are stupid questions. 

Thanks in advance!

Ciao,
Alessio
