From: Darren Hart <dvhltc@us.ibm.com>
Subject: PREEMPT_RT test.kernel.org testing
Date: Wed, 27 Jun 2007 12:43:07 -0700
Message-ID: <200706271243.07523.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Andy Whitcroft <apw@mrs.uk.ibm.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58097 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763152AbXF0TpI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2007 15:45:08 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5RJj7F2008851
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2007 15:45:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5RJiwu3246710
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2007 13:45:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5RJiui7031134
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2007 13:44:56 -0600
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo,

I am working to get some real-time micro-benchmarks tested on each -rt kernel 
release via the test.kernel.org system.  It would facilitate testing and 
simplify the mirroring script if you would make all the patches available in 
the same directory.  I will write the initial script to mirror:

http://people.redhat.com/mingo/realtime-preempt/older/

Would you be willing to just copy the latest -rt patch to both the top level 
and the /older directory, since it ends up there anyway?

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
