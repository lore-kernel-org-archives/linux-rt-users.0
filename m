From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: changes to task_blocks_on_rt_mutex between 18-rt6 and 20-rc5-rt3
Date: Tue, 16 Jan 2007 16:46:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:46041 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbXAPQGb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jan 2007 11:06:31 -0500
Received: from localhost (unknown [127.0.0.1])
	by mail.dsa-ac.de (Postfix) with ESMTP id 8B4A63D5FD
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jan 2007 15:46:05 +0000 (UTC)
Received: from pcgl.dsa-ac.de (PCGL.dsa-ac.de [172.29.17.23])
	by mail.dsa-ac.de (Postfix) with ESMTP id CBF033D5FB
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jan 2007 16:46:04 +0100 (CET)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

I noticed that the above function in kernel/rtmutex.c has changed a lot, 
and I do have a problem in that function under some realtime load. Is 
there a way to check why and when it has been changed? Like git or 
something? Detailed Changelogs?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
