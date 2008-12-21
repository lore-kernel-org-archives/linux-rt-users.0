From: Amir Aharon <amira@waves.com>
Subject: Network packet reordering.
Date: Sun, 21 Dec 2008 02:25:25 -0500
Message-ID: <A58BC43ACBDDA54393A506C9A68AB8B403035BC98C@maxx.waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from maxx.waves.com ([12.34.136.4]:44328 "EHLO maxx.waves.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbYLUHZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Dec 2008 02:25:28 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,
Assuming raw Ethernet packets arrives on the correct order to the networks HW, How can I avoid packet reordering on the application level?
I'm experiencing packet reorder (only on Multi core platforms), using 2.6.24.7-rt21.

What module reorder them, is it the Network stack (ieee80211)? Or is it the e1000 driver implementation?
Is there away to workaround this?

Amir.

