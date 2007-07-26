From: Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH 2/3] proc-interrupts-missing-vectors
Date: Thu, 26 Jul 2007 10:19:04 -0400
Message-ID: <20070726141904.GA28334@tsunami.ccur.com>
References: <20070725205816.GA9032@tsunami.ccur.com> <20070726075144.GB18994@elte.hu>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from users.ccur.com ([66.10.65.2]:56169 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759953AbXGZOTx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 10:19:53 -0400
Content-Disposition: inline
In-Reply-To: <20070726075144.GB18994@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 26, 2007 at 09:51:44AM +0200, Ingo Molnar wrote:

> we cannot really change the format of /proc/interrupts, tools might rely 
> on it - i undid previous -rt changes to the format. An acceptable 
> approach would be to introduce a new /proc/irq_debug file and put all 
> this (and other) information into it.

Well, changes that are additions (that is, those that don't
change the position of existing fields or just add new
lines) are noticibly less invasive than ones that rearrange
fields or insert new fields between existing ones.

In any case, we've been using this patch for 4-5 yrs
without ill effect.

Joe
