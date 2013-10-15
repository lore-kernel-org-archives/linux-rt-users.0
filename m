From: "Frederich, Jens" <Jens.Frederich@vector.com>
Subject: workqueue realtime priority
Date: Tue, 15 Oct 2013 13:04:22 +0000
Message-ID: <9B7F15AA4177464A8FAB5BE79B14288B889580FE@vistrex4.vi.vector.int>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vistrem1.vector-informatik.com ([217.89.139.138]:45541 "EHLO
	vistrem1.vector-informatik.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758567Ab3JONMB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Oct 2013 09:12:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by vistrem1.vector-informatik.com (Postfix) with ESMTP id 4DA8D3DC009
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Oct 2013 15:04:24 +0200 (CEST)
Received: from vistrem1.vector-informatik.com ([127.0.0.1])
	by localhost (vistrem1.vector-informatik.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDDwStFKZyt5 for <linux-rt-users@vger.kernel.org>;
	Tue, 15 Oct 2013 15:04:23 +0200 (CEST)
Received: from vistrex5.vi.vector.int (unknown [10.49.3.65])
	by vistrem1.vector-informatik.com (Postfix) with ESMTPS
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Oct 2013 15:04:23 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

is there any way to set the global workqueue priority to real
time or setup a workqueue with real time priority on Linux RT
3.x? I want to setup a kernel worker thread with real time
priority. What's the best way? Should I better use tasklets?

Thanks
Jens
