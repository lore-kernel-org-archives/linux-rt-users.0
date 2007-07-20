From: Darren Hart <dvhltc@us.ibm.com>
Subject: [announce] IBM RT Test Cases v.0.3
Date: Fri, 20 Jul 2007 15:40:58 -0700
Message-ID: <200707201540.58269.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:39721 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758788AbXGTWk7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2007 18:40:59 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6KMexwu012774
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2007 18:40:59 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6KMex7u204512
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2007 16:40:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6KMewko027950
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2007 16:40:58 -0600
Received: from wecm-9-67-14-197.wecm.ibm.com (wecm-9-67-14-197.wecm.ibm.com [9.67.14.197])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l6KMewLg027938
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2007 16:40:58 -0600
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I am pleased to announce the release of rt-tests v.0.3.  This release 
incorporates a new autotools based build system, updated run scripts, and 
numerous test fixes and updates.  In particular we focused on improving the 
consistency of the tests in terms of criteria and result formatting.  Some 
tests still need to have criteria defined.

Please download the tarball, give the updated documentation a cursory glance 
and give them a go on your -rt system.  Please post your experience here as 
well as any questions or problems you may run into.

http://kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
