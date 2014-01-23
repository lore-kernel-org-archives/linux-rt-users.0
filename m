From: Rolf Peukert <rolf.peukert@imms.de>
Subject: Strange results from Locking API testsuite on ARM
Date: Thu, 23 Jan 2014 19:38:47 +0100
Message-ID: <52E161B7.6000002@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from infosrv.imms.de ([194.95.250.51]:43469 "EHLO infosrv.imms.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbaAWSiy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jan 2014 13:38:54 -0500
Received: from infosrv.imms.de (infosrv.imms.de [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71D849004D
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2014 19:38:52 +0100 (CET)
Received: from iimail.ii.imms.de (iimail.imms.de [194.95.133.35])
	by infosrv.imms.de (Postfix) with ESMTP id 2CF929004C
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2014 19:38:52 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

on our ARM-Cortex-A8-based board (using a TI AM3505 Sitara CPU) running
3.2.54-rt77, the Locking API testsuite displays 87 unexpected failures.

The pattern in the output looks interesting, but I'm not sure what it means:

> [    0.000000] | Locking API testsuite:
> [    0.000000] ----------------------------------------------------------------------------
> [    0.000000]                                  | spin |wlock |rlock |mutex | wsem | rsem |
> [    0.000000]   --------------------------------------------------------------------------
> [    0.000000]                      A-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]                  A-B-B-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]              A-B-B-C-C-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]              A-B-C-A-B-C deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
> [    0.000000]                     double unlock:  ok  |  ok  |FAILED|  ok  |  ok  |FAILED|
> [    0.000000]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.000000]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.000000]   --------------------------------------------------------------------------
> [    0.000000]               recursive read-lock:             |  ok  |             |FAILED|
> [    0.000000]            recursive read-lock #2:             |FAILED|             |  ok  |
> [    0.000000]             mixed read-write-lock:             |  ok  |             |  ok  |
> [    0.000000]             mixed write-read-lock:             |  ok  |             |  ok  |
> [    0.000000]   --------------------------------------------------------------------------
> [    0.000000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |FAILED|
> [    0.000000]      soft-irqs-on + irq-safe-A/12:FAILED|FAILED|  ok  |
> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |FAILED|
> [    0.000000]      soft-irqs-on + irq-safe-A/21:FAILED|FAILED|  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/12:  ok  |  ok  |FAILED|
> [    0.000000]          soft-safe-A + irqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/21:  ok  |  ok  |FAILED|
> [    0.000000]          soft-safe-A + irqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/123:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/132:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/213:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/231:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/312:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #1/321:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/123:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/132:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/213:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/231:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/312:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |FAILED|
> [    0.000000]     soft-safe-A + unsafe-B #2/321:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/123:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/123:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/132:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/132:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/213:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/213:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/231:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/231:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/312:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/312:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq lock-inversion/321:  ok  |  ok  |FAILED|
> [    0.000000]       soft-irq lock-inversion/321:FAILED|FAILED|  ok  |
> [    0.000000]       hard-irq read-recursion/123:FAILED|
> [    0.000000]       soft-irq read-recursion/123:  ok  |
> [    0.000000]       hard-irq read-recursion/132:FAILED|
> [    0.000000]       soft-irq read-recursion/132:  ok  |
> [    0.000000]       hard-irq read-recursion/213:FAILED|
> [    0.000000]       soft-irq read-recursion/213:  ok  |
> [    0.000000]       hard-irq read-recursion/231:FAILED|
> [    0.000000]       soft-irq read-recursion/231:  ok  |
> [    0.000000]       hard-irq read-recursion/312:FAILED|
> [    0.000000]       soft-irq read-recursion/312:  ok  |
> [    0.000000]       hard-irq read-recursion/321:FAILED|
> [    0.000000]       soft-irq read-recursion/321:  ok  |
> [    0.000000] -----------------------------------------------------------------
> [    0.000000] BUG:  87 unexpected failures (out of 218) - debugging disabled! |

Apparently the RT capabilites are not affected.

Here is a link to the full startup log, http://pastebin.com/bBmLwebD
and the kernel configuration used, http://pastebin.com/nYHyBjqT

If I configure the kernel for "Basic RT" or less, all 218 testcases
pass. If I configure "Full RT", but don't select "prove locking
correctness", the result is the usual "135 out of 218 testcases failed,
as expected."

This phenomenon happens with the previous kernel too (at least, haven't
checked older versions yet).

I'm not sure, is the testsuite meant to work in full RT at all?
Did I miss some important kernel config options?

Thanks,
Rolf
