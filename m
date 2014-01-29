From: Michael Haberler <mail17@mah.priv.at>
Subject: Q: signal on file descriptor from RT to non-RT thread
Date: Wed, 29 Jan 2014 15:07:56 +0100
Message-ID: <F7B01BA9-19EF-4395-82C6-238BCC63B74E@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mah2.mah.priv.at ([86.59.12.251]:52577 "EHLO mah.priv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbaA2ORR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jan 2014 09:17:17 -0500
Received: from extern-177.stiwoll.mah.priv.at (extern-177.stiwoll.mah.priv.at [193.228.47.177])
	by mah.priv.at (Postfix) with ESMTPSA id 6E5F12C007E
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2014 15:07:49 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I need to event-notify a non-RT thread with a poll(2) compatible mechanism from an RT thread, meaning the event must come via a file descriptor.

I cannot use eventfd() since there's no common parent process. 

what would be a low-overhead method on the RT thread side? writing a socket? a pipe? 
Or should I rather not bother about the cost of the operation to start with?

thanks in advance for any suggestions.

- Michael


