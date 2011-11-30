From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 10:20:31 -0500
Message-ID: <1322666431.24563.2.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322651681.2921.247.camel@twins> <1322662465.17003.117.camel@frodo>
	 <1322662578.2921.275.camel@twins> <1322663502.17003.121.camel@frodo>
	 <4ED646B1.4020508@tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Schauss <schauss@tum.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36277 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1K3PUe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 10:20:34 -0500
In-Reply-To: <4ED646B1.4020508@tum.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-11-30 at 16:07 +0100, Thomas Schauss wrote:

> On 3.0.9-rt25 (which I have been using here) patch 30765b92 is already 
> applied. And it is also present in patch-3.0.10-rt27.patch.

I'm such a fscking idiot!

I've been working on a port of a patch in 2.6.33-rt, and I didn't
realize that I was still in that kernel, applying these patches. As I
said, I thought the one Peter had was already applied. It was, I'm the
idiot that didn't realize I was in the wrong kernel!

> 
> So the original patch from Peter 
> (http://article.gmane.org/gmane.linux.kernel.mm/70863/match=) applies 
> cleanly here.

Yeah, thanks. That's the patch you want.

-- Steve


