From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/2] Convert message queue timeouts to hrtimer
Date: Fri, 02 Apr 2010 22:40:18 +0200
Message-ID: <20100402204018.575140584@osadl.org>
Cc: Arjan van de Veen <arjan@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pradyumna Sampath <pradysam@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:44742 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab0DBUsa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Apr 2010 16:48:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The message queue system calls that may timeout, mq_timedsend() and
mq_timedreceive(), still use the old jiffie-based timer interface.
Convert them to hrtimer.

The first patch provides the hrtimer infrastructure, the second patch
does the actual conversion to hrtimer.

	Carsten.
