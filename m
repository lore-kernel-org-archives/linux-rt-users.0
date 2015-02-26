From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PTRACE_TRACEME doesn't work: function not implemented
Date: Thu, 26 Feb 2015 15:20:26 +0100
Message-ID: <20150226142026.GF12992@linutronix.de>
References: <542023C9.5020105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49168 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbbBZOU1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 09:20:27 -0500
Content-Disposition: inline
In-Reply-To: <542023C9.5020105@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* DIXLOR | 2014-09-22 17:27:37 [+0400]:

>kernel 3.14 + patch-3.14.12-rt9.patch.gz
>
># strace  anything
>
>strace: test_ptrace_setoptions_for_all: PTRACE_TRACEME strace:
>test_ptrace_setoptions_for_all: PTRACE_TRACEME doesn't work: function
>not implemented

I think you need give some more informations what you attempt to do
because this somehow looks like a missing syscall.

Sebastian
