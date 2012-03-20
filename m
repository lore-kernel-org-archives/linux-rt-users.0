From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Wed, 21 Mar 2012 00:58:44 +0100
Message-ID: <CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2CTX6p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 19:58:45 -0400
Received: by vcqp1 with SMTP id p1so573982vcq.19
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Mar 2012 16:58:44 -0700 (PDT)
In-Reply-To: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
> Accept user supplied CFLAGS and LDFLAGS, overwriting the
> Makefile supplied versions. This can cause the build to
> fail if the user does not provide at least what the Makefile
> defines, but so be it.
>
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> CC: Clark Williams <williams@redhat.com>
> CC: John Kacur <jkacur@redhat.com>
> CC: Denys Dmytriyenko <denis@denix.org>
> ---

I was just wondering what you need LDFLAGS for? Chatting with Darren
on IRC, it seems like you're using -Wl to pass options via gcc to the
linker, and we don't have loadable libs either. Maybe you could resend
the patch with just the CFLAGS change until we have a real world
reason for LDFLAGS

Thanks
