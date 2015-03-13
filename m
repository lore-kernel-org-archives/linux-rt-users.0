From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 00/39] Linux 3.14.34-rt32-rc1
Date: Fri, 13 Mar 2015 12:01:21 +0100
Message-ID: <20150313110121.GC5592@linutronix.de>
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

Could you add Mike's "3.14.23-rt20 - fs,btrfs: fix rt deadlock on
extent_buffer->loc" [0] and that is the upper chunk (ctree.c only). As I
mentioned in the thread, the code is gone in v3.18 and I didn't apply
it.

[0] https://lkml.org/lkml/2014/11/2/34

Sebastian
