From: Mark Knecht <markknecht@gmail.com>
Subject: Re: [ANNOUNCE] [REALTIME] 2.6.33.8-rt30-jk
Date: Thu, 12 Aug 2010 08:24:53 -0700
Message-ID: <AANLkTikEm0=pp_CgBLHyUvnDjGiupADOnm3sOcmUR_hf@mail.gmail.com>
References: <AANLkTik1K3AMQhT+HA7z33A3BpE+UXPJ+a14qNT=mgz7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64942 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760237Ab0HLPYz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Aug 2010 11:24:55 -0400
In-Reply-To: <AANLkTik1K3AMQhT+HA7z33A3BpE+UXPJ+a14qNT=mgz7@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 12, 2010 at 8:05 AM, John Kacur <jkacur@redhat.com> wrote:
> I'm announcing the release of 2.6.33.8-rt30-jk
> The -jk indicates that it is my own -rt version, and not the official
> one that Thomas releases.
> However, it would be great if you tested it and reported your results.
>
> You can fetch it via git from
> git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/jk-2.6.git
> branch: rt/2.6.33-jk
>
> Thanks, enjoy!

;-) Any chance of you hacking out a 2.6.35 version? ;-)

I've got a new i980x 6-core, 12-thread machine that problems
recognizing all the disk drives on 2.6.34 without patches, but works
very well on 2.6.35. I'd love to play with the real-time kernel on it
doing audio.

Cheers,
Mark
