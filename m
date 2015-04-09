From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Thu, 09 Apr 2015 15:46:12 +0200
Message-ID: <552682A4.4000309@osadl.org>
References: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de> <20150408123550.7dbd61b4@gandalf.local.home> <5526458E.5050202@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:57465 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbbDINuR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2015 09:50:17 -0400
In-Reply-To: <5526458E.5050202@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Daniel,

> BTW, are you also taking care of the latency-hist.patch patch?
I do.

However, the request (and the challenge) is not to simply rewrite the 
code. The idea is to provide a general histogram framework that can be 
used from anywhere in the kernel and to equip it with everything needed 
by the existing histograms. This framework should no longer be part of 
the RT patches but submitted directly to mainline Linux. In a second 
step, we will then rewrite the existing histogram code to use the new 
framework.

Any help is greatly appreciated!

	-Carsten.
