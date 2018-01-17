From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 07/13] Revert "fs: jbd2: pull your plug when waiting
 for space"
Date: Wed, 17 Jan 2018 16:46:44 +0100
Message-ID: <20180117154643.v2bmmor4yix3eum2@linutronix.de>
References: <20180117151404.093229667@goodmis.org>
 <20180117151431.571543864@goodmis.org>
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
In-Reply-To: <20180117151431.571543864@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-01-17 10:14:11 [-0500], Steven Rostedt wrote:
> 3.18.91-rt98-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This reverts commit "fs: jbd2: pull your plug when waiting for space".
> This was a duct-tape fix which shouldn't be needed since commit
> "locking/rt-mutex: fix deadlock in device mapper / block-IO".
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

you could also revert 3b5cf23e6b87 ("fs, jbd: pull your plug when
waiting for space") which is the same thing but for ext3/jbd.

The code was removed at some point so I did not revert in my tree.

Sebastian
