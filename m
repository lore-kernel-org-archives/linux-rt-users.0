From: Gautam Thaker <gautam.h.thaker@lmco.com>
Subject: 2.6.26.6-rt11  nanosleep() does have accurate behavior
Date: Fri, 07 Nov 2008 10:56:02 -0500
Message-ID: <49146512.4020107@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "Gautam H. Thaker - LM ATL" <gautam.h.thaker@lmco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailgw1a.lmco.com ([192.31.106.7]:44189 "EHLO mailgw1a.lmco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbYKGQDD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 11:03:03 -0500
Received: from emss07g01.ems.lmco.com (relay5.ems.lmco.com [166.29.2.16])by mailgw1a.lmco.com  (LM-6) with ESMTP id mA7Fu79Z017585for <linux-rt-users@vger.kernel.org>; Fri, 7 Nov 2008 08:56:07 -0700 (MST)
Received: from CONVERSION2-DAEMON.lmco.com by lmco.com (PMDF V6.3-x14 #31428)
 id <0K9Z0050109JWX@lmco.com> for linux-rt-users@vger.kernel.org; Fri, 07 Nov 2008 08:56:07 -0700 (MST)
Received: from enterprise.atl.lmco.com ([166.17.240.20]) by lmco.com (PMDF V6.3-x14 #31428)
 with ESMTP id <0K9Z00GEH09EFE@lmco.com> for linux-rt-users@vger.kernel.org; Fri, 07 Nov 2008 08:56:02 -0700 (MST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I recently started to study how nanosleep() behaves under 2.6.26.6-rt11 compiled in in FULL PREEMPT, uniprocessor mode. 
  I find that between 2.6.20-rt8 and this new kernel something has changed and nanosleep() is back to its old behavior 
or sleeping for next higher number of msec rather than carefully following the "y=x" line.

I don't follow the RT world closely enough, but is this a regression or an expected change in behavior? The link below 
show the results very clearly.

http://www.atl.external.lmco.com/projects/QoS/documents/nanosleep_1.png

Gautam
