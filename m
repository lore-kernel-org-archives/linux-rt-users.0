From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 02/15] Revert "fs: jbd2: pull your plug when waiting
 for space"
Date: Fri, 8 Dec 2017 13:13:17 -0500
Message-ID: <20171208131317.0b771bd4@vmware.local.home>
References: <20171202000149.842718953@goodmis.org>
        <20171202000427.022777641@goodmis.org>
        <20171204083752.GA2255@linutronix.de>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204083752.GA2255@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 4 Dec 2017 09:37:53 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-12-01 19:01:51 [-0500], Steven Rostedt wrote:
> > 4.9.65-rt57-rc2 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> I don't see that you pulled in
> locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch
> |Subject: [PATCH] locking/rt-mutex: fix deadlock in device mapper / block-IO
> 
> which is needed before this can go in.
> 

That's because I pulled it into v4.9.61-rt52.

See http://lkml.kernel.org/r/20171123052630.205871591@goodmis.org

-- Steve
