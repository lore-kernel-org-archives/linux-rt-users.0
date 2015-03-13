From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 00/39] Linux 3.14.34-rt32-rc1
Date: Fri, 13 Mar 2015 12:33:13 +0100
Message-ID: <20150313113313.GD5592@linutronix.de>
References: <20150312191307.081068717@goodmis.org>
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
In-Reply-To: <20150312191307.081068717@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2015-03-12 15:13:07 [-0400]:

>Please scream at me if I messed something up. Please test the patches too.

There is also "[PATCH v3.14-rt] netpoll: guard the access to dev->npinfo
with rcu_read_lock/unlock" which I did not apply because the code is
gone in v3.18. I stopped looking at it after I noticed that the code is
gone.

Sebastian
