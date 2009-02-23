From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 2.6.27-11-eeepc
Date: Mon, 23 Feb 2009 13:49:19 -0500
Message-ID: <7d1d9c250902231049m66713b3v20816983a43c04b9@mail.gmail.com>
References: <286e6b7c0902230844r7d6677e7tca6deef859866c3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dan <danstowell+rt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:27179 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZBWStV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 13:49:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2053313rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 10:49:19 -0800 (PST)
In-Reply-To: <286e6b7c0902230844r7d6677e7tca6deef859866c3c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 23, 2009 at 11:44 AM, Dan <danstowell+rt@gmail.com> wrote:
> Hi -
>
> I am trying to find the best way to get an rt kernel going on my Eee
> PC - in particular, I'm hoping I can base it on the "Array kernel"
> which is set up nicely for the hardware.
>
> The released versions of the -eeepc kernel [1] don't match up with the
> versions for which rt patches are available [2]. I found an
> announcement which included a mention that 2.6.27 was being skipped
> [3] which suggests my hopes might be disappointed.

I've got some updates for my previously released 2.6.27 RT patchset
that I should be able to get out this week.  (This is a forward port
based on Steven's 2.6.26.8-rt16 patches.)  Interestingly enough, I
have been running it on an eeePC as part of testing (as well as
testing on some big iron, x86_64, ppc, etc).  I'd hoped to have the
updates out way way earlier, but a nasty TLB bug that caused things to
catch fire took me quite a while to track down.

I'll send a note to this list once I've pushed the changes.  Stay tuned.

Paul.

>
> I'd be grateful for any suggestions about the best way to go.
>
> Thanks
> Dan
> --
> http://www.mcld.co.uk
>
> [1] http://www.array.org/ubuntu/
> [2] http://www.kernel.org/pub/linux/kernel/projects/rt/
> [3] http://marc.info/?l=linux-rt-users&m=122883923514197&w=2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
