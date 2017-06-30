From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2 2/2] rt: Increase/decrease the nr of migratory tasks
 when enabling/disabling migration
Date: Fri, 30 Jun 2017 11:41:03 +0200
Message-ID: <20170630094103.m6edefhowr5ykbqb@gmail.com>
References: <cover.1498482127.git.bristot@redhat.com>
 <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
 <20170630073055.yp7x55zavoxlaxfl@gmail.com>
 <2ca2100a-334b-05af-8328-025ea9cb182f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36291 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdF3JlR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2017 05:41:17 -0400
Content-Disposition: inline
In-Reply-To: <2ca2100a-334b-05af-8328-025ea9cb182f@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> The first one is not -rt specific, though.

Ok, then all is good, and I've applied the debug patch to the upstream sched/core 
tree.

Thanks,

	Ingo
