From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Date: Tue, 9 Oct 2018 12:56:22 +0200
Message-ID: <20181009105621.plqufigiauieir7z@linutronix.de>
References: <cover.1538089179.git.julia@ni.com>
 <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
 <20181005181035.GA19828@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Julia Cartwright <julia@ni.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005181035.GA19828@andrea>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-10-05 20:10:35 [+0200], Andrea Parri wrote:
> 
> Clearly not my topic..., but out of curiosity:  What do you mean by
> "well-bounded" and "minimal"?  Can you maybe point me to some doc.?

it means that the lock is not held for an arbitrary amount of time like
by processing a list with thousand items. Well-bounded would mean not
process more than one or five (or so) at a time.

>   Andrea

Sebastian
