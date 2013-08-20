From: Joe Korty <joe.korty@ccur.com>
Subject: irq remapping bug in 3.6.11.7
Date: Tue, 20 Aug 2013 13:40:59 -0400
Message-ID: <20130820174059.GA6268@tsunami.ccur.com>
References: <20130820171514.GA16405@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:20360 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752082Ab3HTRlD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Aug 2013 13:41:03 -0400
Content-Disposition: inline
In-Reply-To: <20130820171514.GA16405@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,
I get these warnings from 3.6.11.7:

  In file included from arch/x86/kernel/early-quirks.c:21:
  arch/x86/include/asm/irq_remapping.h:50: warning: 'struct msi_msg' declared inside parameter list
  arch/x86/include/asm/irq_remapping.h:50: warning: its scope is only this definition or declaration, which is probably not what you want

The bug is due to the following mainline patch being missing from
3.6.7.11, which 3.6.11.7 requires for proper operation:

  commit 35d3d814cbd46a85bed97cd74ba97fbbb51e0ccd
  "iommu: Fix compile warnings with forward declarations"

Regards,
Joe
