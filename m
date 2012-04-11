From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.4-rc2-rt1
Date: Wed, 11 Apr 2012 11:25:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204111124560.2542@ionos>
References: <alpine.LFD.2.02.1204101642050.2542@ionos> <4F84C690.1010509@am.sony.com> <4F84C779.4080208@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F84C779.4080208@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 10 Apr 2012, Frank Rowand wrote:
> [    0.253845]        CPU0                    CPU1
> [    0.253845]        ----                    ----
> [    0.253845]   lock(wakeupgen_lock.lock.wait_lock);

wakeupgen_lock wants to be raw. I'll fix it for -rt2

Thanks,

	tglx
