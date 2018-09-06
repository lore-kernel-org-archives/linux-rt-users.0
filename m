From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 08/22] Revert "x86: UV: raw_spinlock conversion"
Date: Thu, 6 Sep 2018 09:35:49 +0200
Message-ID: <20180906073549.zu6gdlwor4fwjngs@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
 <20180905122835.654334475@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180905122835.654334475@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-05 08:28:02 [-0400], Steven Rostedt wrote:
> 4.14.63-rt41-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit 2a9c45d8f89112458364285cbe2b0729561953f1 ]
> 
> Drop the Ultraviolet patch. UV looks broken upstream for PREEMPT, too.
> Mike is the only person I know that has such a thing and he isn't going
> to fix this upstream (from 1526977462.6491.1.camel@gmx.de):

I don't think that we need to propagate that revert for stable. I
reverted it in the devel tree because nobody wanted this upstream and I
couldn't test it. For that reason I didn't see the point for having it
in the RT tree.
However, if you want to revert it for stable, be my guest. It probably
will have no impact and if it will people might step forward and fix it
properly / upstream.

Sebastian
