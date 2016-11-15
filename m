From: Christoph Lameter <cl@linux.com>
Subject: (unknown)
Date: Tue, 15 Nov 2016 14:29:16 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611151428190.28591@east.gentwo.org>
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:44758 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751937AbcKOU3P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2016 15:29:15 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> > There is a deadlock, Peter!!!
>
> Describe please? Also, have you tried disabling RT_RUNTIME_SHARE ?
>


The description was given earlier in the the thread and the drawbacks of
using RT_RUNTIME_SHARE as well.

