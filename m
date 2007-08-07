From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH] Workaround for rq->lock deadlock
Date: Tue, 07 Aug 2007 13:46:16 -0400
Message-ID: <1186508776.21381.192.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com, mingo@elte.hu
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:33409 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbXHGRsI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 13:48:08 -0400
In-Reply-To: 20070807173827.3210.85330.stgit@lsg
References: 20070807173827.3210.85330.stgit@lsg
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-08-07 at 11:43 -0600, Gregory Haskins wrote:
> The following patch converts double_lock_balance to a full DP alogorithm to
> work around a deadlock in the scheduler when running on an 8-way SMP system.

To LKML:  This is an RT specific patch.  I forgot to change the subject
line.  Sorry for the confusion.

-Greg
