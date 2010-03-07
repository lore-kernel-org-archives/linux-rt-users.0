From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/2] [rt-tests] Two minor fixes of cyclictest
Date: Sun, 07 Mar 2010 21:39:55 +0100
Message-ID: <20100307203955.895980022@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60222 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab0CGV3n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 16:29:43 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These patches prevent a priority < 1 and fix an incorrect help message
in cyclictest.

