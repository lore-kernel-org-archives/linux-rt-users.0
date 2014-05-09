From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ftrace: Simplify ring buffer resizing, make work with RT
Date: Fri, 9 May 2014 15:12:44 +0200
Message-ID: <20140509131244.GF29014@linutronix.de>
References: <1399579402-27034-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399579402-27034-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* minyard@acm.org | 2014-05-08 15:03:22 [-0500]:

>This isn't well tested, but fixes an obvious PREEMPT_RT problem and seems
>like a good simplification.  You can see the PREEMPT_RT bug if you enable
>ftrace and all the self tests; it will fail running selftests when it tries
>to resize the buffers.

I posted http://marc.info/?l=linux-rt-users&m=139962823022896&w=2 before
I noticed this one. You seem not to touch the second hunk.

Sebastian
