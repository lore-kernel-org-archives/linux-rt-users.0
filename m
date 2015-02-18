From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH-rt 0/2] Fix up aio splats at reboot garbage collection
Date: Wed, 18 Feb 2015 12:28:23 +0100
Message-ID: <20150218112823.GF28763@linutronix.de>
References: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Kent Overstreet <kmo@daterainc.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47499 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbBRL20 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 06:28:26 -0500
Content-Disposition: inline
In-Reply-To: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2015-02-15 15:52:37 [-0500]:

>We ran into a splat during reboot that was caused by the percpu_ref_kill
>garbage collection in the fs/aio code.

Could you please check if
    https://lkml.org/lkml/2015/2/16/391
works for you?

Sebastian
