From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Strange results from Locking API testsuite on ARM
Date: Fri, 24 Jan 2014 14:39:13 +0100
Message-ID: <20140124133913.GD10264@linutronix.de>
References: <52E161B7.6000002@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Rolf Peukert <rolf.peukert@imms.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54896 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbaAXNjP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jan 2014 08:39:15 -0500
Content-Disposition: inline
In-Reply-To: <52E161B7.6000002@imms.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Rolf Peukert | 2014-01-23 19:38:47 [+0100]:

>Hello,
Hi Rolf,

>
>If I configure the kernel for "Basic RT" or less, all 218 testcases
>pass. If I configure "Full RT", but don't select "prove locking

Yes. I think in basic mode we use the "vanila" locking.

>correctness", the result is the usual "135 out of 218 testcases failed,
>as expected."
>
>This phenomenon happens with the previous kernel too (at least, haven't
>checked older versions yet).
>
>I'm not sure, is the testsuite meant to work in full RT at all?
>Did I miss some important kernel config options?

No you are fine. From a quick look on the v3.12 x86 output we disabled
the failed tests from your second part of the output.
The first few with the rlock fail because it works a little different on
-RT and thus leading to the errors. So the testsuite was never updated
to match the behavior on -RT in v3.2 and it still does not match 100% on
current v3.12.

My current output is:
| ------------------------
| | Locking API testsuite:
| ----------------------------------------------------------------------------
|                                  | spin |wlock |rlock |mutex | wsem | rsem |
|   --------------------------------------------------------------------------
|                      A-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|                  A-B-B-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|              A-B-B-C-C-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|              A-B-C-A-B-C deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
|                     double unlock:  ok  |  ok  |FAILED|  ok  |  ok  |FAILED|
|                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
|                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
|   --------------------------------------------------------------------------
|               recursive read-lock:             |  ok  |             |FAILED|
|            recursive read-lock #2:             |FAILED|             |  ok  |
|             mixed read-write-lock:             |  ok  |             |  ok  |
|             mixed write-read-lock:             |  ok  |             |  ok  |
|   --------------------------------------------------------------------------
|      hard-irqs-on + irq-safe-A/12:  ok  |
|      hard-irqs-on + irq-safe-A/21:  ok  |
|          hard-safe-A + irqs-on/12:  ok  |
|          hard-safe-A + irqs-on/21:  ok  |
|     hard-safe-A + unsafe-B #1/123:  ok  |
|     hard-safe-A + unsafe-B #1/132:  ok  |
|     hard-safe-A + unsafe-B #1/213:  ok  |
|     hard-safe-A + unsafe-B #1/231:  ok  |
|     hard-safe-A + unsafe-B #1/312:  ok  |
|     hard-safe-A + unsafe-B #1/321:  ok  |
|     hard-safe-A + unsafe-B #2/123:  ok  |
|     hard-safe-A + unsafe-B #2/132:  ok  |
|     hard-safe-A + unsafe-B #2/213:  ok  |
|     hard-safe-A + unsafe-B #2/231:  ok  |
|     hard-safe-A + unsafe-B #2/312:  ok  |
|     hard-safe-A + unsafe-B #2/321:  ok  |
|   --------------------------------------------------------------------------
|   | Wound/wait tests |
|   ---------------------
|                   ww api failures:  ok  |  ok  |  ok  |
|                ww contexts mixing:  ok  |  ok  |
|              finishing ww context:  ok  |  ok  |  ok  |  ok  |
|                locking mismatches:  ok  |  ok  |  ok  |
|                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
|            spinlock nest unlocked:  ok  |
|   -----------------------------------------------------
|                                  |block | try  |context|
|   -----------------------------------------------------
|                           context:  ok  |  ok  |  ok  |
|                               try:  ok  |  ok  |  ok  |
|                             block:  ok  |  ok  |  ok  |
|                          spinlock:  ok  |  ok  |  ok  |
| -----------------------------------------------------------------
| BUG:  11 unexpected failures (out of 119) - debugging disabled! |
| -----------------------------------------------------------------

and all fails here are due to -RT specific changes (which I verified
while I added the Wound/wait part).

>Thanks,
>Rolf

Sebastian
