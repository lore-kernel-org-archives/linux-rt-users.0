From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.9.146-rt125
Date: Fri, 21 Dec 2018 12:09:56 +0100
Message-ID: <20181221110956.quje2nriylyq54xg@linutronix.de>
References: <20181221043607.GC15714@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221043607.GC15714@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-21 04:36:08 [+0000], Julia Cartwright wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 4.9.146-rt125 stable release.

Thank you Julia.

> Apologies for an update to the 4.9-rt tree being way overdue.
> 
> This release is just an update to the new stable 4.9.146 version
> and no RT specific changes have been made.

Except that 4.9.115-rt94 has been also released in the meantime which
did contain some RT specific changes (for people which skipped the rc1
release).

Regarding the spin_lock backports for lockup on x86 as reported by
Daniel: The backports are part of the stable tree 4.9.147 and 4.14.90
which is currently out for review.

Sebastian
