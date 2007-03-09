From: Darren Hart <dvhltc@us.ibm.com>
Subject: IBM RT Test Cases
Date: Fri, 9 Mar 2007 00:02:49 -0800
Message-ID: <200703090002.49644.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41022 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993106AbXCIICv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Mar 2007 03:02:51 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2982o2a027583
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Mar 2007 03:02:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2982oXi257372
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Mar 2007 03:02:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2982oq7018402
	for <linux-rt-users@vger.kernel.org>; Fri, 9 Mar 2007 03:02:50 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

It has been a while since I've updated our RT test cases.  I've added a couple 
convenience "libraries" for simulating RT noise (libjvmsim) and doing some 
basic statistical analysis of results (libstats.h).  There are some minor 
improvements to the test cases as well as a couple additional tests.

I understand that the packaging of these tests is sub-par and collecting their 
results into a meaningful report is still painful.  It is something we are 
working to improve, but please don't let that stop you from sending in a 
patch for your own personal itch.

You can find the tests here:

http://kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
