From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] Fix a small memory leak in latency histograms
Date: Fri, 14 Feb 2014 18:26:17 +0100
Message-ID: <20140214172617.382025623@osadl.org>
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51179 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaBNR2P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 12:28:15 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

while we are at it ...

Here comes a fix of a small memory leak in latency histograms.

	-Carsten.

