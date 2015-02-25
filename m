From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-3.18.7-rt1]sunrpc: make svc_xprt_do_enqueue() use
 get_cpu_light()
Date: Wed, 25 Feb 2015 15:14:39 +0100
Message-ID: <20150225141439.GC6823@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <1424271928.6903.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424271928.6903.3.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-02-18 16:05:28 [+0100]:

>[   37.667792] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>[   37.720307] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:915
>[   37.720307] in_atomic(): 1, irqs_disabled(): 0, pid: 3194, name: rpc.nfsd
>[   37.720318] Preemption disabled at:[<ffffffffa06bf0bb>] svc_xprt_received+0x4b/0xc0 [sunrpc]

applied

Sebastian
