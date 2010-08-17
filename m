From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 13:24:15 -0700
Message-ID: <AANLkTik+s_gYa7JWPXGGNX4tMho+QksV1GaY+2wiXTff@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
	<AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
	<4C6AC4A6.4080407@redhat.com>
	<AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43753 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab0HQUYQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 16:24:16 -0400
Received: by wyb32 with SMTP id 32so7442893wyb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 13:24:15 -0700 (PDT)
In-Reply-To: <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 17, 2010 at 11:24 AM, Manikandan Ramachandran
<crmanik@gmail.com> wrote:
<SNIP>
>
> Thanks David & Mark for your valuable input!
>
> I'm not expecting RT kernel to be real fast. However I expect latency
> of higher priority task to be less in RT kernel. I'll run the tests
> that you have suggested and see if there is any inherent issue with my
> system.
>

It is not that the delay of a high priority task is less in the rt
kernel. It's more that it meets a maximum latency number more often.
It's more _dependable_ in meeting a known latency value than the
standard kernel.

> One more query, with RT patch is it possible for higher priority task
> to preempt a lower priority IRQ thread [For eg, IDE] ? If so when does
> that happen, during next timer interrupt [Assuming IRQ thread uses
> whole schedule slot and doesn't yield between]?

Yes, it is possible for higher priorities to interrupt low priorities.
In a __properly__ functioning system higher priority should always
trump lower priority. The higher runs and then the lower picks up
where it left off.

In your question it seems to me you are assuming a device or it's
software is not 'real time compliant' which has certainly been the
case a few times over the years. If a lower priority device won't
yield - maybe it's in some tight loop that doesn't pay attention to
the kernel? - then that software needs to be fixed or the system won't
produce predictable latencies. Over the years this has become much
less an issue but I'm not sure anything can be guaranteed without
testing.

Again, I'm not a programmer but I've used these kernels for years so I
speak from sort of a practical user POV and not necessarily the most
accurate software technical POV. (I'm a hardware guy)
