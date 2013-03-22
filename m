From: Tim Sander <tstone@krieglstein.org>
Subject: Re: Beginner's questions on userspace latency
Date: Fri, 22 Mar 2013 21:21:51 +0100
Message-ID: <2181419.yCSEbLiqDZ@virgo>
References: <514CB285.4050100@nittka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Oliver Nittka <oly@nittka.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:43724
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422904Ab3CVUac (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 16:30:32 -0400
In-Reply-To: <514CB285.4050100@nittka.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Oliver
> I read through the RT wiki, but I'm still unsure on how to proceed from
> here. Is there any way to determine what's causing the glitches?
> Anything I could do to improve the realtime behavior of my application?
Realtime has a lot to do with your computing hardware + the drivers. The worst 
driver determines your max latency. As you have not told on what hardware you 
are running it is hard to give some hints... other than do latency tracing if 
your hw is powerful enough. Also you might look at the nice latency charts 
from osadl.org. Find a similar system to yours and look at the  worst 
latencies recorded.

Also keep in mind that latency tracing needs some time. There are some 
recordings of talks available for example of Frank Rowand about latency 
tracing but they are probably a little bit dated as the don't acount to much 
for the much improved latency tracing infrastructure within the kernel.

Good luck
Tim
