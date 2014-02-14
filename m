From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/1] Re: [PATCH RT] latency-hist: mostly checkpatch cleanup
Date: Fri, 14 Feb 2014 20:46:23 +0100
Message-ID: <52FE728F.3060908@linutronix.de>
References: <20140214171641.048899133@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44228 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaBNTq2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 14:46:28 -0500
In-Reply-To: <20140214171641.048899133@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/14/2014 06:16 PM, Carsten Emde wrote:
> Hi Sebastian,

Hi Carsten,

> you submitted a patch of a patch - it's not funny and very difficult to read.
> I allowed myself to transform it to a normal separate patch on top of the one
> that you patched. It can be merged lateron.
> 
> Isn't this better? (We always did it this way.)

Yes, we always did that way. This time it is different.
I received 20 patches from Nicholas dealing with checkpatch issues. It
contained code changes like fixes of white space and other changes that
fall into the category cosmetic - code change at all. Others change the
body of the patch because checkpatch did not like a twice the same
person in a signed-of-by line or Toasted-by was not a valid tag and so
on.
I did not want any of this patches to extend unnecessary the -RT queue
so I want them merged right in the first patch where the problem occurs.
I also did not want to deal with fallout when I merge the
patches back into the original and a following patch does no longer
apply. So I asked Nicholas do it this way.
This patch did a little more because it replaced NR_CPUS with something
else and therefore I considered it important enough to send it to the
mailing list. The other will be mentioned in the announcement email
will be part of the incremental patch.

> 
> 	-Carsten.

Sebastian
