From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 2/2] rt: Increase/decrease the nr of migratory tasks
 when  enabling/disabling migration
Date: Mon, 7 Aug 2017 17:46:57 +0200
Message-ID: <20170807154657.dixtykrdqwp7nhkq@linutronix.de>
References: <cover.1498482127.git.bristot@redhat.com>
 <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-26 17:07:15 [+0200], Daniel Bristot de Oliveira wrote:
> There is a problem in the migrate_disable()/enable() implementation
> regarding the number of migratory tasks in the rt/dl RQs. The problem
> is the following:
…
> This patch fixes this problem by decreasing/increasing the
> rt/dl_nr_migratory in the migrate disable/enable operations.
> 
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Reported-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

Applied.

Sebastian
