From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4.0-rt] blk/blk-core.c: fix warning for non-rt builds
Date: Thu, 11 Jun 2015 10:44:36 +0200
Message-ID: <20150611084436.GA16115@linutronix.de>
References: <1433095569-11766-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55435 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbFKIol (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 04:44:41 -0400
Content-Disposition: inline
In-Reply-To: <1433095569-11766-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2015-05-31 14:06:09 [-0400]:

>To fix:
>  block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined
>
>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>---
>
>[please squash into block-mq-don-t-complete-requests-via-IPI.patch]
done, thanks.

Sebastian
