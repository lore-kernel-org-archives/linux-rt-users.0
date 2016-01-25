From: Josh Cartwright <joshc@ni.com>
Subject: Re: [RT-Tests] pmqtest on ARM
Date: Mon, 25 Jan 2016 09:19:53 -0600
Message-ID: <20160125151953.GI27463@jcartwri.amer.corp.natinst.com>
References: <CANKSX+G0tePQNFw8uH+RYrFEKanTsHmiqSzd1y5aGq1gwms17Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: "$rik@nth " <srikanth007m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:45550 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757291AbcAYPT4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2016 10:19:56 -0500
In-Reply-To: <CANKSX+G0tePQNFw8uH+RYrFEKanTsHmiqSzd1y5aGq1gwms17Q@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 25, 2016 at 05:31:50PM +0530, $rik@nth  wrote:
> Hi All,

Hey Srikanth-

> I am having dragonboard 410c with Android kernel. Tried successfully
> cross compile rt-tests for ARM using cross tool-chain.
>
> pmqtest is showing error "could not open POSIX message queue #1"
>
> Do i need to compile rt-tests with any additional/specific flags
> inorder to work on ARM platform as well? Request someone to share
> pointers to unblock my debugging.

I doubt this is an ARM problem, but it's probably rather a configuration
problem.  Have you ensured that you've enabled POSIX message queue
support in your kernel configuration (CONFIG_POSIX_MQUEUE)?  You may
also need to mount the mqueue pseudofilesystem, or tweak with the procfs
knobs.  I'd suggest taking a look at man 7 mq_overview.

Hope that helps,
  Josh
