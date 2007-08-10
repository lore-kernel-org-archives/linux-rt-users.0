From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/2] RT: Enhance PREEMPT_TRACE with deeper stacks
Date: Fri, 10 Aug 2007 08:14:08 -0600
Message-ID: <20070810140745.12966.8464.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ghaskins@novell.com
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:16735 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762958AbXHJOOJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 10:14:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This series changes the PREEMPT-TRACE behavior for reporting critical
sections.  The previous code reported 2 frames per section.  The new code uses
the save_stack_trace facility to save an arbitrary number of frames (currently
set to 5 via a #define)

For what its worth, these patches assisted me with debugging some issues in
-rt.  The second patch is really a workaround for where X86_64 frame-pointers
apparently are not working under certain circumstances.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
