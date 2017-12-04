From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/9] Revert "fs: jbd2: pull your plug when waiting for
 space"
Date: Mon, 4 Dec 2017 09:45:45 +0100
Message-ID: <20171204084545.GB2255@linutronix.de>
References: <20171202013658.149533964@goodmis.org>
 <20171202013711.424595897@goodmis.org>
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
In-Reply-To: <20171202013711.424595897@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-01 20:36:59 [-0500], Steven Rostedt wrote:
> 4.4.102-rt117-rc1 stable review patch.
> If anyone has any objections, please let me know.

Same comment as in the 4.9.65-rt57-rc2 review (that you might need
locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch).

Sebastian
