From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 11/20] ARM: imx: always use TWD on IMX6Q
Date: Tue, 12 Jul 2016 22:04:29 +0200
Message-ID: <20160712200429.GA4302@linutronix.de>
References: <20160712142405.634544943@goodmis.org>
 <20160712142419.367116752@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160712142419.367116752@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2016-07-12 10:24:16 [-0400]:

>4.1.27-rt31-rc1 stable review patch.
>If anyone has any objections, please let me know.

I don't recommend to cherry-pick this. The symbol it selects
(HAVE_ARM_TWD) has "depends on SMP" in v4.1. In v4.4 there should be
AM43xx which is UP and also uses the TWD so the change is simple here.

Sebastian
