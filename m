From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Fedora 10 as basis for RT?
Date: Thu, 9 Apr 2009 07:45:50 -0700
Message-ID: <5bdc1c8b0904090745k675acde6v51df7dae4ac433d9@mail.gmail.com>
References: <loom.20090409T134400-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Al Dorrington <albert.dorrington@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:20855 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbZDIOpw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 10:45:52 -0400
Received: by rv-out-0506.google.com with SMTP id f9so644888rvb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Apr 2009 07:45:51 -0700 (PDT)
In-Reply-To: <loom.20090409T134400-381@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 9, 2009 at 6:49 AM, Al Dorrington
<albert.dorrington@lmco.com> wrote:
> Hi,
>
> I am working on a proof of concept project where we are going to try moving an
> application that runs on VxWorks to Linux. I believe with what I've read on this
> mailing list, and the RTwiki site that Linux is definitely up to the task with
> these kernel patches.
>
> However, I am not really sure which distribution of Linux we should use as the
> base, nor am I sure if it would be better to stick with the 'i386' distribution
> or go with the x86_64 variant.
>
> I am considering Fedora 10, either i386 or x86_64.
>
> Does anyone have any comments or recommendations for which might be better to
> use, or if we would be better off using another distribution?
>
> Thanks!
> - Al Dorrington
>

I personally don't think the distro is all that important in this
respect. I'd pick the distro based on other things like how it gets
installed, how does it's package management, how often you want to
update it, whether you want configuration through GUI apps or whether
you're comfortable working at the command line, and probably most
important how well the user lists are run and whether the folks who
answer questions tend to be gentle or demanding.

I run the rt-kernel on Gentoo and have had relatively great success. I
don't know of any distro that won't run it, and if there is one then I
suspect that the rt-devel team would want to know that. I'm sure
Fedora is a well tested distro. The PlanetCCRMA audio distro is
Fedora-based and it has always worked pretty well.

As for i386 vs x86_64 my only input would be that if your app needs to
interface to a lot of Windows multimedia data then you're likely
better off with i386. I run the rt-kernel on both under Gentoo and
have an easier time with the i386 boxes decoding what are generally
Windows only media types.

Good luck with whatever decision you take.

Cheers,
Mark
