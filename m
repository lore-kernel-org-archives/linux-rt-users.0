From: Tracey Hytry <shakti@bayarea.net>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Fri, 15 Apr 2011 01:22:05 -0700
Message-ID: <20110415012205.d9110367.shakti@bayarea.net>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>
	<497D1168CB2F407F9005845B39FEF144@e1705>
	<alpine.LFD.2.00.1104111806021.4501@localhost6.localdomain6>
	<BANLkTi=6UnfiOwwdwgJvW0kZyJ7OoE0dpg@mail.gmail.com>
	<4DA32E16.8090807@osadl.org>
	<alpine.LFD.2.00.1104111846140.6190@localhost6.localdomain6>
	<369290E6B58D4A3BAC211B6A4BB73E0B@e1705>
	<BANLkTinKyw0d56USqVwJgVCsehpyVdMHVw@mail.gmail.com>
	<4DA5F178.4080705@autostatic.com>
	<4DA633DC.8060800@gmail.com>
	<4DA69C1F.8010908@autostatic.com>
	<BANLkTi=OpNAnBhc5zxjsk6ehuv9TMxVbPA@mail.gmail.com>
	<DA0DD8D5A6A24EB18D6507114F539115@e1705>
	<BANLkTikb3cZZFACUsfF8vo0UWy1v4tO5HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bayarea.net ([209.128.87.230]:53301 "EHLO mail.bayarea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab1DOIeZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Apr 2011 04:34:25 -0400
In-Reply-To: <BANLkTikb3cZZFACUsfF8vo0UWy1v4tO5HA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Using Fernando's latest build for fedora14,  this one seems to work quite well.

I threw a lot at it while testing the audio, it's a very good low latency kernel.

The only problem is after waking up after a suspend to ram, the sound is hosed.
But that's not something new here because I'm using a m-audio audiophile 24/96,
and this happens on any kernel.

Tracey.
