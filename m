From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] Cleanup of unnecessary do while 0 in api mappings
Date: Fri, 14 Feb 2014 12:04:32 +0100
Message-ID: <20140214110432.GB28438@linutronix.de>
References: <20140208113920.GA3861@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140208113920.GA3861@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-02-08 12:39:20 [+0100]:

>
>Cleanup of unnecessary do while 0 in api mappings
>
>With the migration pushdonw a few of the do{ }while(0)
>loops became obsolete but got left over - this patch 
>only removes this fallout.
>
>Patch applies on top of 3.12.9-rt13
>
>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

Applied.

Sebastian
