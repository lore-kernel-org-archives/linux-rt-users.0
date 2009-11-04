From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 18:14:12 +0100
Message-ID: <20091104171412.GB1702@opentech.at>
References: <hcs6dr$235$1@ger.gmane.org> <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com> <4AF1A327.3040103@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Knecht <markknecht@gmail.com>, linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>, y@opentech.at
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:52109 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757063AbZKDRWN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 12:22:13 -0500
Content-Disposition: inline
In-Reply-To: <4AF1A327.3040103@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 04 Nov 2009, Tim Blechmann wrote:

> >    I'm not a developer and cannot really address your specific
> > question but for my use of the rt-kernel I put important rt-audio
> > files on a 1394 drive and give the 1394 driver higher priorities using
> > the IRQ scheduling tools. I don't have any trouble running 2 or 3 1394
> > drives recording and playing back 48 channels in Ardour.
> > 
> >    While I agree you should do everything the right way technically in
> > the code maybe part of your solution is outside of the app you are
> > writing and in the use of these support tools?
> 
> well, if i understand the rt howto correctly, _no_ disc access is
> allowed, neither from rt nor from non-rt threads, since it may produce
> page faults, which introduce latencies ...

I would be supprised if the rt howto states that page-faults in non-rt
threads is a critical problem - that would not significantly impact RT
performance - atelast not the worst case - it will (as every other system
load) impact the average case. so having a non-rt thread reading disk-files
to a buffer and a rt-thread processing this buffer should be perfectly fine.

hofrat
