From: Steve Rottinger <steve@pentek.com>
Subject: PREEMPT_RT + HIGHMEM = segfaults during boot on ppc32
Date: Thu, 02 Jul 2009 16:18:37 -0400
Message-ID: <4A4D161D.6080405@pentek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pentek.com ([12.35.250.145]:4378 "HELO mailhost.pentek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754630AbZGBUmx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 16:42:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm using 2.6.29.5-rt22 on a custom ppc32 (8641D) board.  About half the
time, the board will boot up correctly. The other half of the time, I'll
get segfaults in various parts of the init process.  I've also noticed
that if I remove CONFIG_HIGHMEM from my configuration, I am able to boot
consistently without running into this problem.  Is there anyone else
experiencing this, or does anyone have any suggestions?

Thanks in advance,

-Steve

