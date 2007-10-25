From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/3] RT: balance rt tasks enhancements v6
Date: Thu, 25 Oct 2007 10:46:18 -0400
Message-ID: <20071025144456.19876.94333.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Gregory Haskins <ghaskins@novell.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:45103
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754662AbXJYPBI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 11:01:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a mini-release of my series, rebased on -rt2.  I have more changes
downstream which are not quite ready for primetime, but I need to work on some
other unrelated issues right now and I wanted to get what works out there. 

Changes since v5

*) Rebased to rt2 - Many of the functions of the original series are now
 included in base -rt so they are dropped out
