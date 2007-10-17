From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 9/9] RT: Only dirty a cacheline if the priority is actually
	changing
Date: Wed, 17 Oct 2007 14:51:13 -0400
Message-ID: <20071017185113.11272.50568.stgit@novell1.haskins.net>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:51822
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757668AbXJQTFI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 15:05:08 -0400
In-Reply-To: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We can avoid dirtying a rq related cacheline with a simple check, so why not.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 0 files changed, 0 insertions(+), 0 deletions(-)
