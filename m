From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 16/39] locking/rt-mutex: avoid a NULL pointer
 dereference on deadlock
Date: Fri, 13 Mar 2015 11:40:47 +0100
Message-ID: <20150313104047.GA5592@linutronix.de>
References: <20150312191307.081068717@goodmis.org>
 <20150312191409.707856750@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150312191409.707856750@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2015-03-12 15:13:23 [-0400]:

>3.14.34-rt32-rc1 stable review patch.
>If anyone has any objections, please let me know.

If you take this, could you take 9d3e2d02f54160725d97f4ab1e1e8de493fbf33a
("locking/rtmutex: Set state back to running on error") it sits on my
queue and is upstream already.

Sebastian
