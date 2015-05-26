From: anna-maria@glx-um.de
Subject: [patch 0/3] cyclictest: Various fixes and a new option
Date: Tue, 26 May 2015 19:06:59 -0000
Message-ID: <20150526190333.510838769@glx-um.de>
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39452 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbEZTva (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 15:51:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This patch series addresses two shortcomings of the cyclictest code:

     - Calculation of the next wakeup time does not take latencies
       longer than the interval time into account, so the next
       scheduled event is already in the past.

     - The offset value of the --aligned option should be counted in
       microseconds, but the code lacks a conversion to nanoseconds

Aside of this, add a new option which allows to align the measurement
threads to the next full second with an optional offset.

     Anna-Maria



