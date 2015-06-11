From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4.0-rt] powerpc: ps3/device-init.c - adapt to completions
 using swait vs wait
Date: Thu, 11 Jun 2015 10:53:21 +0200
Message-ID: <20150611085321.GB16115@linutronix.de>
References: <1433097882-1556-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55490 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbFKIxX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 04:53:23 -0400
Content-Disposition: inline
In-Reply-To: <1433097882-1556-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2015-05-31 14:44:42 [-0400]:

>To fix:
>
>  cc1: warnings being treated as errors
>  arch/powerpc/platforms/ps3/device-init.c: In function 'ps3_notification_read_write':
>  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'prepare_to_wait_event' from incompatible pointer type
>  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'abort_exclusive_wait' from incompatible pointer type
>  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'finish_wait' from incompatible pointer type
>  arch/powerpc/platforms/ps3/device-init.o] Error 1
>  make[3]: *** Waiting for unfinished jobs....
>
>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Applied, thanks.

Sebastian
