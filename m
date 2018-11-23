From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Date: Fri, 23 Nov 2018 12:06:11 +0100
Message-ID: <20181123110611.s2gmd237j7docrxt@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <20181123110226.GA5125@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zhe.he@windriver.com, catalin.marinas@arm.com, tglx@linutronix.de,
        rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        boqun.feng@gmail.com
To: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123110226.GA5125@andrea>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-23 12:02:55 [+0100], Andrea Parri wrote:
> > is this an RT-only problem? Because mainline should not allow read->read
> > locking or read->write locking for reader-writer locks. If this only
> > happens on v4.18 and not on v4.19 then something must have fixed it.
> 
> Probably misunderstanding, but I'd say that read->read locking is "the
> norm"...?
> 
> If you don't use qrwlock, readers are also "recursive", in part.,
> 
>   P0			P1
>   read_lock(l)
> 			write_lock(l)
>   read_lock(l)
> 
> won't block P0 on the second read_lock().  (qrwlock somehow complicate
> the analysis; IIUC, they are recursive if and only if in_interrupt().).

ehm, peterz, is that true? My memory on that is that all readers will
block if there is a writer pending.

>   Andrea

Sebastian
