From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] kernel/res_counter.c: Change lock of struct
 res_counter to raw_spinlock_t
Date: Wed, 18 Feb 2015 12:05:52 +0100
Message-ID: <20150218110552.GE28763@linutronix.de>
References: <1420745917-50747-1-git-send-email-tmac@hp.com>
 <1422644389-33074-1-git-send-email-tmac@hp.com>
 <20150213191909.GA8299@windriver.com>
 <54DE6AD5.9070000@hp.com>
 <20150213213016.GC7102@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150213213016.GC7102@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Paul Gortmaker | 2015-02-13 16:30:17 [-0500]:

there is the thread "[v3.10-rt / v3.12-rt] scheduling while atomic in
cgroup code" where I applied Mike's patch. This should fix the problem
reported and be part of the next release.
Could please double check (either by grabing the patch or waiting for
the next release).

Sebastian
