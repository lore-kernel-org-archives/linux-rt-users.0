From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Wed, 13 May 2015 10:12:36 +0200
Message-ID: <20150513081236.GA21106@linutronix.de>
References: <55245FC8.9090509@osadl.org>
 <5526AE86.7030708@linutronix.de>
 <20150410123634.GA3057@linutronix.de>
 <20150511201506.29a5c3e2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59494 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306AbbEMIMm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 May 2015 04:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20150511201506.29a5c3e2@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-05-11 20:15:06 [-0400]:

>I'm backporting this to the stable releases, and I'm a bit worried
>about the above comment. The new Scheduler IPI code uses work queues and
>requires it to be done in a hard irq.

The IPI part is only done for the high-prio which is only used by NOHZ.
Everyone else gets in via softiq as we did it before.

>-- Steve

Sebastian
