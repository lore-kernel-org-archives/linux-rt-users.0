From: Armin Steinhoff <armin@steinhoff.de>
Subject: RT scheduling / scheduling of RT groups
Date: Sat, 23 Oct 2010 15:18:19 +0200
Message-ID: <4CC2E09B.7020704@steinhoff.de>
References: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61825 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab0JWNOi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Oct 2010 09:14:38 -0400
In-Reply-To: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

AFAIK,  the RT scheduler (sched_rt.c) is part of the CFS.
  Is there a way to handle task running with SCHED_NORMAL and 
SCHED_OTHER also with the RT scheduler ?
( CFS deactivated )

There are scheduling groups. In which way (priorities? other 
attributes?)  are these groups defined ?
  How can sched_rt_period and sched_rt_runtime be set or read?

Cheers

--Armin




