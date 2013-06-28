From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] list_bl.h: make list head locking RT safe
Date: Fri, 28 Jun 2013 13:23:44 +0200
Message-ID: <51CD7240.1040703@linutronix.de>
References: <51C472FF.1050409@linutronix.de> <1371841645-27604-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45682 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab3F1LX5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jun 2013 07:23:57 -0400
In-Reply-To: <1371841645-27604-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/21/2013 09:07 PM, Paul Gortmaker wrote:
> As per changes in include/linux/jbd_common.h for avoiding the
> bit_spin_locks on RT ("fs: jbd/jbd2: Make state lock and journal
> head lock rt safe") we do the same thing here.

applied.

Sebastian
