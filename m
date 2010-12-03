From: steve conrad <lemuel_houyhnhnm@yahoo.com.mx>
Subject: rt breaks b43
Date: Fri, 3 Dec 2010 14:23:58 -0800 (PST)
Message-ID: <434093.33345.qm@web112913.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nm17-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.58]:31802 "HELO
	nm17-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752362Ab0LCWYA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Dec 2010 17:24:00 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Can't get my b43 wireless card working with 2.6.33.7-rt29 kernel.

Driver loads and appears with iwconfig. I can adjust txpower, but I can't make the card come up. 'iwlist wlan0 scanning' just produces a 'network is down error message'.

I've tried using the kernel on OpenSuse-11.3 and Ubuntu 10.10 with the same results.

Looks like the patch only really affects the net/wireless/*80211* part of the source rather than the b43 driver itself.

Anyone else experiencing similar difficulties? 


      
