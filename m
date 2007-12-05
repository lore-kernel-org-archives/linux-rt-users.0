From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] OMAP GPIO IRQ rework for generic IRQ subsystem
Date: Tue,  4 Dec 2007 22:00:33 -0800
Message-ID: <1196834437-19223-1-git-send-email-khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
	Russell King <linux@arm.linux.org.uk>,
	Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org
To: linux-omap@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:60180 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750969AbXLEGKU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 01:10:20 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patchset aims to cleanup OMAP GPIO IRQ handling and use the
generic IRQ framework where possible.  In the process it fixes a
couple bugs and enables correct behavior when GPIO IRQ handlers are
threaded by the -rt patch.

Tested on OMAP3430SDP and 2430SDP with and without -rt patch.

Needs some testing on platforms using edge-triggered IRQs with and
without IRQ patch.

Comments welcome,

Kevin
