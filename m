From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.18.7-rt: BUG: sleeping function called from invalid context
 (snd_pcm_stream_lock+0x29/0x70)
Date: Thu, 26 Feb 2015 21:10:13 +0100
Message-ID: <20150226201013.GH12992@linutronix.de>
References: <20150226200815.GM4111@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50564 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321AbbBZUKQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 15:10:16 -0500
Content-Disposition: inline
In-Reply-To: <20150226200815.GM4111@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2015-02-26 17:08:15 [-0300]:

>Right after boot I start seeing these messages to:
>
>[   44.046458] BUG: sleeping function called from invalid context at /home/lclaudio/SANDBOX/kernel-rt/kernel/locking/rtmutex.c:915
>[   44.046459] in_atomic(): 0, irqs_disabled(): 1, pid: 2515, name: pulseaudio
>[   44.046497]  [<ffffffffa0323c69>] snd_pcm_stream_lock+0x29/0x70 [snd_pcm]

Mike sent this: "[patch-3.18.7-rt1] snd/pcm: fix snd_pcm_stream_lock*()
irqs_disabled() splats"

Sebastian
