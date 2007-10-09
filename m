From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/5] RT: scheduler fixes and rt_overload enhancements
Date: Tue, 09 Oct 2007 10:25:44 -0400
Message-ID: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
	ghaskins@novell.com, pmorreale@novell.com, sdietrich@novell.com
To: mingo@elte.hu, linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:45522
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752122AbXJIOis (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 10:38:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,

The first two patches are from Mike and Steven on LKML, which the rest of my
series is dependent on.  Patch #4 is a resend from earlier.

Series Summary:

1) Send IPI on overload regardless of whether prev is an RT task
2) Set the NEEDS_RESCHED flag on reception of RESCHED_IPI
3) Fix a mistargeted IPI on overload
4) Track which CPUS are in overload for efficiency
5) Track which CPUs are eligible for rebalancing for efficiency

These have been built and boot-tested on a 4-core Intel system.

Regards,
-Greg
