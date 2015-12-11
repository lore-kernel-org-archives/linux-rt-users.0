From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Triggering BUG on SIGSEGV signaling
Date: Fri, 11 Dec 2015 18:32:54 +0100
Message-ID: <20151211173254.GK6720@linutronix.de>
References: <2830783.CAkrTrFBlp@ws-stein>
 <68989327.QRdbeUK3if@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49140 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbLKRc4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 12:32:56 -0500
Content-Disposition: inline
In-Reply-To: <68989327.QRdbeUK3if@ws-stein>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexander Stein | 2015-11-26 13:10:04 [+0100]:

>For the records, it's the same bug which is fixed by https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-rt-devel/+/v4.1.3-rt3-patches/patches/ARM-enable-irq-in-translation-section-permission-fau.patch
>This also fixes my problem on the old kernel.

Steven has been a good boy and merged this patch and a few others into
the latest v3.10 based -RT kernel. However if prefer to use v3.10.47-rt50
you might run into other bugs as well which are fixed in the meantime.

>Best regards,
>Alexander

Sebastian
