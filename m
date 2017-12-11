From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/9] Revert "fs: jbd2: pull your plug when waiting
 for space"
Date: Mon, 11 Dec 2017 10:53:06 -0500
Message-ID: <20171211105306.52cdf62f@vmware.local.home>
References: <20171202013658.149533964@goodmis.org>
        <20171202013711.424595897@goodmis.org>
        <20171204084545.GB2255@linutronix.de>
        <20171208131524.2099b1fd@vmware.local.home>
        <20171211153709.sa2tdk6xro6ccaxy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbdLKPxL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 10:53:11 -0500
In-Reply-To: <20171211153709.sa2tdk6xro6ccaxy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 11 Dec 2017 16:37:09 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
 
> > Now it does appear I'm missing that for 4.4. I wonder why I didn't pull
> > it in there. Perhaps it wasn't needed, which means this isn't needed
> > either.  
> 
> I strongly suggest to include "locking/rt-mutex: fix deadlock in device
> mapper / block-IO". We had a workaround in the jbd/ext3 code which then
> moved into jbd2/ext4 after people complained about the same problem. I
> wasn't sure about the root-cause back then but now with explanation we
> have in the fix patch I'm sure this is one of the bugs we have since day
> one.

Yep. Not sure why I didn't include it in 4.4. I added it to my queue,
and started testing it, which is one of the reasons I haven't posted it
yet. Also, my internet connectivity has be really poor while traveling
this time.

-- Steve
