From: Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 4.4.162-rt175
Date: Tue, 30 Oct 2018 14:25:48 +0100
Message-ID: <892f6f12-d8a9-2570-edff-ba077344bc63@monom.org>
References: <20181029200501.BECE75007F3@mail.monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029200501.BECE75007F3@mail.monom.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 29/10/2018 21:04, Daniel Wagner wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 4.4.162-rt175 stable release.
> 
> This release is just an update to the new stable 4.4.120 version
> and no RT specific changes have been made.
> 
> This version still qspinlock enabled, because I wanted to update first
> to the last stable release and then resend the patch which drops back
> to ticket spinlocks.

I forgot to mention about the tagging/counting policy change. The
stable-rt maintainers have decided to use the same tagging/counting
strategy for all the stable-rt trees. If there is no merge conflict the
latest stable release is merged and tagged. All intermediates merge
commit and tag is not done anymore unless there is a conflict. The
conflict will be resolved and a merge commit with tag will be applied.

Thanks,
Daniel
