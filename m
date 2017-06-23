From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch-rt v2] rtmutex: Fix lock stealing logic
Date: Fri, 23 Jun 2017 12:07:38 +0200
Message-ID: <1498212458.5248.0.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497805317.6229.3.camel@gmx.de> <1498203434.3988.5.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498203434.3988.5.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-06-23 at 09:37 +0200, Mike Galbraith wrote:
> V2 changes:
>   - beautification (ymmv)
>   - enable lock stealing when waiter is queued

(V3 s/steal/claim)
