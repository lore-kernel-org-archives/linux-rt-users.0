From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [btrfs/rt] lockdep false positive
Date: Sun, 22 Jan 2017 19:25:20 +0100
Message-ID: <1485109520.4467.82.camel@gmail.com>
References: <1485074793.4467.49.camel@gmail.com>
         <1485107114.4467.73.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32924 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdAVSZX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Jan 2017 13:25:23 -0500
In-Reply-To: <1485107114.4467.73.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 
> +> 	> 	> /*
> +> 	> 	>  * Allow read-after-read or read-after-write recursion of the
> +> 	> 	>  * same lock class for RT rwlocks.
> +> 	> 	>  */
> +> 	> 	> if (read == 3 && (prev->read == 3 || prev->read == 0))

Pff, shoulda left it reader vs reader.. but it's gotta be wrong anyway.
