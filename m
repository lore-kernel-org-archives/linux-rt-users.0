From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23-rt3
Date: Wed, 24 Oct 2007 17:30:45 -0400
Message-ID: <1193261445.20679.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:64956 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbXJXXCQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 19:02:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23-rt3 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23-rt2

  - Workqueue PI (Peter Zijlstra with help from Daniel Walker)

  - some schedstat updates (Steven Rostedt)

to build a 2.6.23-rt3 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rt3.bz2

The broken out patches are also available.

-- Steve
