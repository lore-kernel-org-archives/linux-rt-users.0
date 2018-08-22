From: Mike Galbraith <efault@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
Date: Wed, 22 Aug 2018 15:38:25 +0200
Message-ID: <1534945105.8087.8.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de>
         <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2018-08-21 at 16:34 +0100, Marc Zyngier wrote:
> Could you give that patchlet[1] a go? It solves a similar issue for me
> on a different platform.
> 
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html

Yup, all better.

	-Mike
