From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/9] Revert "fs: jbd2: pull your plug when waiting
 for space"
Date: Fri, 8 Dec 2017 13:15:24 -0500
Message-ID: <20171208131524.2099b1fd@vmware.local.home>
References: <20171202013658.149533964@goodmis.org>
        <20171202013711.424595897@goodmis.org>
        <20171204084545.GB2255@linutronix.de>
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
In-Reply-To: <20171204084545.GB2255@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 4 Dec 2017 09:45:45 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-12-01 20:36:59 [-0500], Steven Rostedt wrote:
> > 4.4.102-rt117-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> Same comment as in the 4.9.65-rt57-rc2 review (that you might need
> locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch).

Now it does appear I'm missing that for 4.4. I wonder why I didn't pull
it in there. Perhaps it wasn't needed, which means this isn't needed
either.

Thanks!

-- Steve
