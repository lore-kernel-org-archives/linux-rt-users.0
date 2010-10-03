From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] Add summary column to cyclictest histograms
Date: Sun, 03 Oct 2010 15:56:51 +0200
Message-ID: <20101003135651.176127086@osadl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60629 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab0JCOfT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Oct 2010 10:35:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark,

With this patch, a summary column is optionally displayed
to provide an overview of latency histograms when cyclictest
runs more than a single thread. For this purpose, the new
option -H/histofall was introduced. I am fully aware that
cyclictest does not suffer from too few options, but I did
not want to break existing scripts that rely on the number
of columns in cyclictest's output.

	Carsten.

