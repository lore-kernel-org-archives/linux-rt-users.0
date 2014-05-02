From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/2] rwsem-rt: Do not allow readers to nest
Date: Fri, 2 May 2014 11:04:47 +0200
Message-ID: <20140502090447.GA9178@linutronix.de>
References: <20140409024700.702797305@goodmis.org>
 <20140409025231.998774075@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38149 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBJEv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 05:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20140409025231.998774075@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2014-04-08 22:47:01 [-0400]:

>From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
>The readers of mainline rwsems are not allowed to nest, the rwsems in the
>PREEMPT_RT kernel should not nest either.
>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Applied

Sebastian
