From: David Hauck <davidh@netacquire.com>
Subject: v3.18-RT
Date: Tue, 31 May 2016 18:42:08 +0000
Message-ID: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gwo3.mbox.net ([165.212.64.25]:48493 "EHLO gwo3.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcEaSsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 May 2016 14:48:12 -0400
Received: from gwo3.mbox.net (localhost [127.0.0.1])
	by gwo3.mbox.net (Postfix) with ESMTP id 3rK2R26KD3z18WXDt
	for <linux-rt-users@vger.kernel.org>; Tue, 31 May 2016 18:42:22 +0000 (UTC)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

We've been working to integrate/support a new system board and have noticed boot-up stalls running 3.18.29-rt30 (in particular when the kernel is configured with PREEMPT_RT_FULL - as diagnostics markers, PREEMPT_RT_RTB and non-RT appear to be fine). The boot-up stalls appear fairly frequently - approximately once every 8-10 cold boots - and occur very early in the boot process. The SHB board houses dual Xeon E5-2680 v3 parts (i.e., 2x12 cores for a combined 24 cores).

My question is regarding the v3.18 tip (currently v3.18.34) and whether an RT release for this version might be worthwhile to try. We'd consider moving to a v4 test branch, but ultimately we'd like to test a new v3.18 in order to determine impact in the field. I hesitate to ask this but am wondering if anyone might have some feedback on the time frame for an RT refresh on the v3.18 tip?

Thanks in advance,
-David
