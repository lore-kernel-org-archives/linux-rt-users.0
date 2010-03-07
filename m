From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/2] [rt-tests] Add smp option to ptsematest and svsematest
Date: Sun, 07 Mar 2010 21:48:00 +0100
Message-ID: <20100307204800.456744470@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60222 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab0CGV3o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 16:29:44 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The -S (--smp) option of cyclictest has proven to be quite useful. Add it
to ptsematest and svsematest as well. 

