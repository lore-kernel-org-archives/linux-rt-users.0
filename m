From: Joachim Achtzehnter <joachima@netacquire.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Wed, 09 May 2012 15:13:07 -0700
Message-ID: <4FAAEBF3.10907@netacquire.com>
References: <joemui$6v0$1@dough.gmane.org> <joepd0$e4f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from penguin.kraut.ca ([209.53.201.119]:48749 "EHLO penguin.kraut.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab2EIWzE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 18:55:04 -0400
Received: from s216-232-14-254.bc.hsia.telus.net ([216.232.14.254] helo=[205.159.216.152])
	by penguin.kraut.ca with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <joachima@netacquire.com>)
	id 1SSF8D-0006hZ-FG
	for linux-rt-users@vger.kernel.org; Wed, 09 May 2012 15:13:14 -0700
In-Reply-To: <joepd0$e4f$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Grant Edwards wrote:

> I've been loaned a clue by somebody on the OSADL mailing list: the RT
> patches are for improving _user_space_ reponse, and may do so at the
> expense of both CPU usage and interrupt latency.

The RT patches improve *worst case* latency. They are primarily intended 
for applications that must *always* meet their deadlines, not merely 
most of the time. In return you tend to get increased average latency as 
well as reduced throughput.

> As a result, I'm better off without the RT patch if what I care
> about is interrupt latency.

Yes, if you only care about *typical* interrupt latency but don't mind 
the occasional long delay.

Joachim

-- 
joachima@netacquire.com http://www.netacquire.com
