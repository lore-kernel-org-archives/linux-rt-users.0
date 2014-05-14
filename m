From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC v0] thermal: Protect schedule flag by raw spin
Date: Wed, 14 May 2014 12:23:42 +0200
Message-ID: <20140514102342.GH15049@linutronix.de>
References: <1397485347-2235-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
 <20140509120902.GB29014@linutronix.de>
 <53707BA0.60701@oss.bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41902 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbaENKXo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 06:23:44 -0400
Content-Disposition: inline
In-Reply-To: <53707BA0.60701@oss.bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Daniel Wagner | 2014-05-12 09:43:28 [+0200]:

>Hi Sebastian,
Hi Daniel,

>I overlooked that one. I tried to avoid using thread for this but it
>looks like there isn't a simpler way. I'll do 'x86/mce' version then.

as an exercise you could come up with a generic infrastructure which
fires up one task and can be re-used by mce and the old other users
which attempt schedule a workqueue in hard irq context. I think a simple
swait based workqueue like thingy should work.

Sebastian
