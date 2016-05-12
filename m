From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Thu, 12 May 2016 10:59:46 +0200
Message-ID: <20160512085946.GB19035@linutronix.de>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52338 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbcELI7s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2016 04:59:48 -0400
Content-Disposition: inline
In-Reply-To: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Brian Silverman | 2016-05-10 14:04:24 [-0400]:

>Without this, a realtime process which has called mlockall exiting
>causes large latencies for other realtime processes at the same or
>lower priorities. This seems like a fairly common use case too, because
>realtime processes generally want their memory locked into RAM.

Can please explain more detailed what exactly causes the high latencies?

Sebastian
