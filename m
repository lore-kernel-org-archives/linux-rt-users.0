From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/5] RT: Misc. fixups for ARM/OMAP against 2.6.25.4-rt3
Date: Tue, 20 May 2008 15:42:56 -0700
Message-ID: <483353F0.6090902@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-omap@vger.kernel.org
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:61644 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935337AbYETWm6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 18:42:58 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

What follows are a series of minor fixes to get -rt3 building/booting on 
  ARM.  The first 3 are ready do be included into the -rt patch, while 
the last 4th one (cmpxchg duplication) needs a little investigating. 
The 5th one needs to go upstream via the OMAP tree.

This was build/boot tested on the TI OMAP3430 SDP platform

Kevin
