From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/9] Revert "fs: jbd2: pull your plug when waiting for
 space"
Date: Mon, 11 Dec 2017 16:37:09 +0100
Message-ID: <20171211153709.sa2tdk6xro6ccaxy@linutronix.de>
References: <20171202013658.149533964@goodmis.org>
 <20171202013711.424595897@goodmis.org>
 <20171204084545.GB2255@linutronix.de>
 <20171208131524.2099b1fd@vmware.local.home>
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
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171208131524.2099b1fd@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-08 13:15:24 [-0500], Steven Rostedt wrote:
> On Mon, 4 Dec 2017 09:45:45 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2017-12-01 20:36:59 [-0500], Steven Rostedt wrote:
> > > 4.4.102-rt117-rc1 stable review patch.
> > > If anyone has any objections, please let me know.  
> > 
> > Same comment as in the 4.9.65-rt57-rc2 review (that you might need
> > locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch).
> 
> Now it does appear I'm missing that for 4.4. I wonder why I didn't pull
> it in there. Perhaps it wasn't needed, which means this isn't needed
> either.

I strongly suggest to include "locking/rt-mutex: fix deadlock in device
mapper / block-IO". We had a workaround in the jbd/ext3 code which then
moved into jbd2/ext4 after people complained about the same problem. I
wasn't sure about the root-cause back then but now with explanation we
have in the fix patch I'm sure this is one of the bugs we have since day
one.

> Thanks!
> 
> -- Steve

Sebastian
