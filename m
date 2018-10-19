From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/kasan: make quarantine_lock a raw_spinlock_t
Date: Fri, 19 Oct 2018 12:58:51 +0200
Message-ID: <20181019105851.GG3121@hirez.programming.kicks-ass.net>
References: <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
 <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
 <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de>
 <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
 <20181010214945.5owshc3mlrh74z4b@linutronix.de>
 <20181012165655.f067886428a394dc7fbae7af@linux-foundation.org>
 <20181013135058.GC4931@worktop.programming.kicks-ass.net>
 <20181015163529.30ed9b0ac18e20dd975f4253@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181015163529.30ed9b0ac18e20dd975f4253@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 15, 2018 at 04:35:29PM -0700, Andrew Morton wrote:
> On Sat, 13 Oct 2018 15:50:58 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The whole raw_spinlock_t is for RT, no other reason.
> 
> Oh.  I never realised that.
> 
> Is this documented anywhere?  Do there exist guidelines which tell
> non-rt developers and reviewers when it should be used?

I'm afraid not; I'll put it on the todo list ... I've also been working
on some lockdep validation for the lock order stuff.
