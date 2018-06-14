From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.4.137-rt154
Date: Thu, 14 Jun 2018 16:02:31 -0400
Message-ID: <20180614160231.6310d752@gandalf.local.home>
References: <20180614191001.6882950047A@mail.monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614191001.6882950047A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jun 2018 21:02:51 +0200
Daniel Wagner <wagi@monom.org> wrote:

> I am not sure if I am hunting a ghost. During testing on the CI
> testfarm, a spike of around 400us popped up on a x86_64 box
> (*). Fortunately, I have the same CPU for testing at home and I
> tried very hard to reproduce it. Even Steven was helping out for
> setting up the test correctly. But so far I haven't seen it again.

I believe it was a ghost. I just scared it away when I came over ;-)

-- Steve
