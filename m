From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 04:27:30 -0700
Message-ID: <1276514850.26993.4.camel@sven.thebigcorporation.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	 <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	 <alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sujit K M <sjt.kar@gmail.com>,
	Maksym Parkachov <lazy.gopher@gmail.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35474 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0FNL1p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 07:27:45 -0400
Received: by pvg16 with SMTP id 16so2782939pvg.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 04:27:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2010-06-14 at 13:05 +0200, John Kacur wrote:
> 
> On Mon, 14 Jun 2010, Sujit K M wrote:
> 
> > > CONFIG_PREEMPT_RCU=y
%<
> His problem is not with the config.
> --

Nope - the config is just fine.

Turn on the lock validator and
recompile the Kernel.

Then repeat the test that produced the latency spike.

If that doesn't produce any locking issues,
turn on latency tracing and repeat.

> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


