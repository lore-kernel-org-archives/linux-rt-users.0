From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH-rt 0/2] Fix up aio splats at reboot garbage collection
Date: Wed, 18 Feb 2015 14:33:53 +0100
Message-ID: <1424266433.7113.1.camel@gmail.com>
References: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com>
	 <20150218112823.GF28763@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
	Kent Overstreet <kmo@daterainc.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60016 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbBRNd5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 08:33:57 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so1199634wgh.3
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2015 05:33:56 -0800 (PST)
In-Reply-To: <20150218112823.GF28763@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2015-02-18 at 12:28 +0100, Sebastian Andrzej Siewior wrote:
> * Paul Gortmaker | 2015-02-15 15:52:37 [-0500]:
> 
> >We ran into a splat during reboot that was caused by the percpu_ref_kill
> >garbage collection in the fs/aio code.
> 
> Could you please check if
>     https://lkml.org/lkml/2015/2/16/391
> works for you?

I did not see a gripe with that and ltp.

	-Mike

