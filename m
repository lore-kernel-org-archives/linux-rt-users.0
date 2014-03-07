From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: nouveau crash due to missing channel (WAS: Re: [ANNOUNCE]
 3.12.12-rt19)
Date: Fri, 7 Mar 2014 12:53:57 +0100
Message-ID: <20140307115357.GB8637@linutronix.de>
References: <20140223184727.GA12442@linutronix.de>
 <53128DED.1000402@localhost>
 <20140307111848.GA8637@linutronix.de>
 <5319AF2D.2060004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Ben Skeggs <bskeggs@redhat.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36877 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaCGLyE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Mar 2014 06:54:04 -0500
Content-Disposition: inline
In-Reply-To: <5319AF2D.2060004@canonical.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Maarten Lankhorst | 2014-03-07 12:36:13 [+0100]:

>>I can't find any kind of locking so my question is what ensures that chan is
>>not set to NULL between nouveau_fence_done() and
>>nouveau_fence_wait_uevent()? There are just a few opcodes in between but
>>nothing that pauses nouveau_fence_signal().
>Absolutely nothing. :-) Worse still, there's no guarantee that channel isn't freed, but hopefully that is less likely to be an issue.

Okay, so I hit the correct spot. What do we do here? Do you want the
patch I posted without the WARN_ON() or do you prefer to fix this in an
other way?

>~Maarten

Sebastian
