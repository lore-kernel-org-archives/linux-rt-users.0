From: Tim Blechmann <tim@klingt.org>
Subject: scheduling latency & CONFIG_HZ
Date: Wed, 11 Nov 2009 19:44:44 +0100
Message-ID: <hdf0mo$6gj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35727 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757862AbZKKSo6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Nov 2009 13:44:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N8IBj-0001uX-91
	for linux-rt-users@vger.kernel.org; Wed, 11 Nov 2009 19:45:03 +0100
Received: from 85-127-251-84.dynamic.xdsl-line.inode.at ([85.127.251.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Nov 2009 19:45:03 +0100
Received: from tim by 85-127-251-84.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Nov 2009 19:45:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

i am curious, do the values of CONFIG_HZ and CONFIG_NO_HZ somehow affect 
the scheduling latency (as reported by cyclictest) of a 
real-time/vanilla kernel, especially when CONFIG_HIGH_RES_TIMERS is enabled?

thnx, tim

-- 
tim@klingt.org
http://tim.klingt.org

The price an artist pays for doing what he wants is that he has to do
it.
   William S. Burroughs


