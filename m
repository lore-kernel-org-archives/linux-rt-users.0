From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/4] more RT balancing enhancements v6b
Date: Fri, 30 Nov 2007 11:46:44 -0500
Message-ID: <20071130163638.30588.47845.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: LKML
	<"linux-kernel@vger.kernel.org>, linux-rt-users"@vger.kernel.org>,
	mingo@elte.hu
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:43061
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935406AbXK3RII (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Nov 2007 12:08:08 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

These patches apply to the end of the rt-balance-patches v6 annouced here:

http://lkml.org/lkml/2007/11/20/613

These replace the v6a patches annouced here:

http://lkml.org/lkml/2007/11/21/226

Changes since v6a:

*) made features tunable via config options
*) fixed a bug related to setting a CPU to INVALID
*) vec->mask weight optimization
*) minor tweaks and improvements

Comments welcome!

Regards,
-Greg 
-- 
Signature
