From: Thomas Schauss <schauss@tum.de>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Fri, 02 Dec 2011 18:41:29 +0100
Message-ID: <4ED90DC9.9090206@tum.de>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>  <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>  <4ED35D9A.7090401@tum.de>  <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>  <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>  <1322620613.17003.110.camel@frodo>  <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>  <1322651681.2921.247.camel@twins> <1322662465.17003.117.camel@frodo>  <1322662578.2921.275.camel@twins> <1322663502.17003.121.camel@frodo>  <4ED646B1.4020508@tum.de> <1322666431.24563.2.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:46434 "EHLO
	mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932083Ab1LBRll (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Dec 2011 12:41:41 -0500
Received: from scan5.mail.lrz.de (scan5.mail.lrz.de [10.156.6.39]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Fri, 2 Dec 2011 18:41:31 +0100
Received: from mailrelay1.lrz-muenchen.de ([10.156.6.201])
	by scan5.mail.lrz.de (scan5.mail.lrz.de [10.156.6.25]) (amavisd-new, port 10024)
	with ESMTP id Ha6ohN5WJqLM for <linux-rt-users@vger.kernel.org>;
	Fri,  2 Dec 2011 18:41:31 +0100 (CET)
Received: from robusta.lsr.ei.tum.de (robusta.lsr.ei.tum.de [129.187.147.176]) by mailrelay1.lrz-muenchen.de with ESMTP for linux-rt-users@vger.kernel.org; Fri, 2 Dec 2011 18:41:30 +0100
Received: from mail.lsr.ei.tum.de (mail.lsr.ei.tum.de [129.187.147.212])
	by robusta.lsr.ei.tum.de (Postfix) with ESMTP id C3BF0150CB00
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Dec 2011 18:41:30 +0100 (CET)
In-Reply-To: <1322666431.24563.2.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/30/2011 04:20 PM, Steven Rostedt wrote:
> On Wed, 2011-11-30 at 16:07 +0100, Thomas Schauss wrote:
>
>> On 3.0.9-rt25 (which I have been using here) patch 30765b92 is already
>> applied. And it is also present in patch-3.0.10-rt27.patch.
>
> I'm such a fscking idiot!
>
> I've been working on a port of a patch in 2.6.33-rt, and I didn't
> realize that I was still in that kernel, applying these patches. As I
> said, I thought the one Peter had was already applied. It was, I'm the
> idiot that didn't realize I was in the wrong kernel!
>
>>
>> So the original patch from Peter
>> (http://article.gmane.org/gmane.linux.kernel.mm/70863/match=) applies
>> cleanly here.
>
> Yeah, thanks. That's the patch you want.
>
> -- Steve
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hello,

this patch does indeed get rid of the lockdep-splat.

Regarding the original subject of the post:

Running startx with the nvidia binary driver fails on 3.0.9-rt25 and 
3.2-rc2-rt3 when CONFIG_PREEMPT_RT_FULL=y and works fine for 
CONFIG_PREEMPT_RTB=y. There is no lockdep-warning, kernel oops/bug, 
etc., neither in any log-files nor on the serial console.

This happens on several machines which ran fine with 2.6.33-rt29.

I know many people here are no big fans of the nvidia driver (and 
rightly so). Unfortunately we really need this.

If anyone has any further ideas on debugging this issue I would be 
really thankful.

Best Regards,
Thomas
