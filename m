From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.9-rt4
Date: Mon, 29 Apr 2013 21:37:58 +0200
Message-ID: <20130429193758.GA7979@linutronix.de>
References: <20130426222001.GH20927@linutronix.de>
 <517C46D6.7030601@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <517C46D6.7030601@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Carsten Emde | 2013-04-27 23:44:54 [+0200]:

>Hi Sebastian,
Hi Carsten,

>This patch is needed to prevent the compiler error
>drivers/gpu/drm/i915/i915_gem_execbuffer.c:1072:27:
>error: 'seqno' undeclared (first use in this function)

thanks, I folded it into the patch that broke it.

Sebastian
