From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/2] VFCIPI support v2
Date: Mon, 30 Jul 2007 17:15:34 -0400
Message-ID: <20070730211350.5162.99143.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:50651
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S938872AbXG3VPr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 17:15:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The following series Virtual Function-Call IPI support.  Changes from v1:

1) Support for platforms other than x86_64
2) Support for priority-inheritance.

Built/tested on x86_64 four-way SMP machine.  Other platforms untested.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
