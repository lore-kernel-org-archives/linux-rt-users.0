From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT]  hwlat-detector: Don't ignore threshold module
 parameter
Date: Fri, 4 Oct 2013 12:30:26 +0200
Message-ID: <20131004103026.GA19953@linutronix.de>
References: <20130819213324.405942342@goodmis.org>
 <1377842245.5422.7.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52896 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab3JDKa1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 06:30:27 -0400
Content-Disposition: inline
In-Reply-To: <1377842245.5422.7.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-08-30 07:57:25 [+0200]:

>--- a/drivers/misc/hwlat_detector.c	2013-08-30 07:16:05.387959392 +0200
>+++ b/drivers/misc/hwlat_detector.c	2013-08-30 07:10:52.958670183 +0200
>@@ -413,7 +413,7 @@ static int init_stats(void)
> 		goto out;
> 
> 	__reset_stats();
>-	data.threshold = DEFAULT_LAT_THRESHOLD;	    /* threshold us */
>+	data.threshold = threshold ?: DEFAULT_LAT_THRESHOLD;	    /* threshold us */
> 	data.sample_window = DEFAULT_SAMPLE_WINDOW; /* window us */
> 	data.sample_width = DEFAULT_SAMPLE_WIDTH;   /* width us */

Interresting. According to my history the parameter has been used
before.
Applied, thanks.

Sebastian
