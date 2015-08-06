From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 1us latency?
Date: Thu, 6 Aug 2015 15:12:59 +0200
Message-ID: <20150806131259.GA7924@linutronix.de>
References: <55BF4CD7.8000007@pavlinux.ru>
 <20150803114422.0efbea1b@sluggy>
 <55BFAC1C.9020508@pavlinux.ru>
 <55BFB4AA.4020901@pavlinux.ru>
 <20150803135326.3fd23809@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pavel <pavel@pavlinux.ru>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45752 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbbHFNNB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Aug 2015 09:13:01 -0400
Content-Disposition: inline
In-Reply-To: <20150803135326.3fd23809@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Clark Williams | 2015-08-03 13:53:26 [-0500]:

>On Mon, 3 Aug 2015 21:36:26 +0300
>
>Interesting. Betting that's page faults and cache filling. 
>
>I don't think we want to arbitrarily pick some number of cycles for a
>"settle time" (i.e. a grace period for the application to reach steady
>state). Possibly we should add an option for that? Specify some number
>of cycles or some amount of time that where the measurement threads run
>before actual measurements start?
>
>  $ cyclictest --numa -p95 -m --settle=10ms
>
>That would say "run the measurement threads for ten milliseconds before
>actually starting the measurement period". That would allow them to
>fault in and fill cache lines before starting real work.
>
>Anyone else have an opinion?

Wouldn't you have everything in-memory after once cycle of each thread?

>Clark

Sebastian
