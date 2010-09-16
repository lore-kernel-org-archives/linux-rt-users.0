From: Gautam Thaker <gautam.h.thaker@lmco.com>
Subject: "yum install ...." based instruction on building a RT kernel.
Date: Thu, 16 Sep 2010 18:54:04 -0400
Message-ID: <4C92A00C.6050401@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "Gautam H. Thaker - LM ATL" <gautam.h.thaker@lmco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailfo02.lmco.com ([192.35.35.12]:40655 "EHLO mailfo02.lmco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab0IQCwy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 22:52:54 -0400
Received: from mailgw3a.lmco.com (mailgw3a.lmco.com [192.35.35.7])
	by mailfo02.lmco.com (8.14.3/8.14.3) with ESMTP id o8GMs9hr006162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 23:54:09 +0100
Received: from emss04g01.ems.lmco.com (relay4.ems.lmco.com [166.17.13.122])by mailgw3a.lmco.com  (LM-6) with ESMTP id o8GMs9FJ024694for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 18:54:09 -0400 (EDT)
Received: from CONVERSION2-DAEMON.lmco.com by lmco.com (PMDF V6.4 #31806)
 id <0L8V00C013M9JD@lmco.com> for linux-rt-users@vger.kernel.org; Thu, 16 Sep 2010 22:54:09 +0000 (GMT)
Received: from enterprise.atl.lmco.com ([166.17.240.20]) by lmco.com (PMDF V6.4 #31806)
 with ESMTP id <0L8V0092U3M40J@lmco.com> for linux-rt-users@vger.kernel.org; Thu, 16 Sep 2010 22:54:04 +0000 (GMT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

The above page provides the instruction in  a step by step manner, but I 
distinctly recall that Ingo Molnar used to have some place a set of 
instruction that were "yum" based and it seemed like it was just  a couple of 
commands to build a new RT kernel. Are these still available anywhere?


There is the link below, but it appears to be > 3 years old and itself points 
to some broken links.

http://wiki.bestpractical.com/view/RPMInstall

It would be nice to have something like "yum install rt ..." to get the latest 
version of RT kernel build.

Gautam
