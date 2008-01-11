From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: cyclictest?
Date: Thu, 10 Jan 2008 16:50:06 -0800
Message-ID: <5bdc1c8b0801101650x3984d726j7fb69c7405dd121f@mail.gmail.com>
References: <5bdc1c8b0801101634j583da294k319dbaa55405f26e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:42107 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbYAKAuI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 19:50:08 -0500
Received: by nz-out-0506.google.com with SMTP id s18so554276nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jan 2008 16:50:08 -0800 (PST)
In-Reply-To: <5bdc1c8b0801101634j583da294k319dbaa55405f26e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Jan 10, 2008 4:34 PM, Mark Knecht <markknecht@gmail.com> wrote:
> Hi,
>    I hadn't heard of cyclictest before an email today. I guess as a
> user instead of a developer I don't pay much attention.
>
>    Can someone point me toward directions for building this on a Gentoo machine?
>
> Thanks,
> Mark
>

Browsing around I found this link:

http://rt.wiki.kernel.org/index.php/Cyclictest

But the link to get the tarball is stale. When I trace it through and
get to the page it shows a

git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests.git

I found another email in Google that suggested running this command:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests.git

which does download some source code. make built it but I'm not sure
how to get any data.

I found a Live CD at OSADL. Would that be a recommended way for me to
look at my machine? I'm downloading it now.

Thanks,
Mark
