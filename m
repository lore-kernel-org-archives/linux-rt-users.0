From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 0/2] [ANNOUNCE] 3.2.28-rt43-rc1 stable review
Date: Sun, 16 Sep 2012 17:13:21 -0700
Message-ID: <50566B21.3090907@am.sony.com>
References: <20120913185721.264108744@goodmis.org>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120913185721.264108744@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/13/12 11:57, Steven Rostedt wrote:
> 
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 3.2.28-rt43-rc1.

Tested on:

  - ARM mpcore
  - ARM panda

For configurations:

  - SMP CONFIG_PREEMPT_NONE
  - UP  CONFIG_PREEMPT_NONE
  - SMP CONFIG_PREEMPT_RT_FULL
  - UP  CONFIG_PREEMPT_RT_FULL

Tests:

  - build
  - boot
  - magic SYSRQ prints on serial console

As expected, panda SMP CONFIG_PREEMPT_RT_FULL still has the
lock warning on boot.  (tglx is looking into this.)

-Frank
