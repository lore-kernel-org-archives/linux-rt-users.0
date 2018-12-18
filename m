From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.14.87-rt49
Date: Tue, 18 Dec 2018 23:08:36 +0100
Message-ID: <20181218220836.y5tfo6qyuf3674vj@linutronix.de>
References: <20181218154034.612d729d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218154034.612d729d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-18 15:40:34 [-0500], Steven Rostedt wrote:
> 
> Dear RT Folks,
> 
> I'm pleased to announce the 4.14.87-rt49 stable release.

This contains also commit
  e8499ab5b93ac ("x86/fpu: Disable bottom halves while loading FPU registers")

which means you need commit
  [PATCH] x86/fpu: Disable preemption around local_bh_disable()
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/x86-fpu-Disable-preemption-around-local_bh_disable.patch?h=linux-4.19.y-rt-patches

Sebastian
