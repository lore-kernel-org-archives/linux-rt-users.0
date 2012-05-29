From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] RFC - rt-tools: Detect whether numa is available at build
 time
Date: Mon, 28 May 2012 17:49:36 -0700
Message-ID: <4FC41D20.1010105@am.sony.com>
References: <1337989189-17563-1-git-send-email-jkacur@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:8696 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423Ab2E2AuE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 May 2012 20:50:04 -0400
In-Reply-To: <1337989189-17563-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/25/12 16:39, John Kacur wrote:
> This is a preliminary hack, I need to clean it up a little, but incase you
> want to give it a try, here is the alpha version.
> 
> Note - I stole this methodology from tools/perf
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

I knew I would regret suggesting this fix.

It works fine on my fedora 12 x86_64 system for native build.

It works fine on my fedora 12 x86_64 system for crossbuild for ARM.

The NUMA=0 option is still useful (thank you for leaving that
in place).  I have a second ARM target board, where the cross
linker does not complain about libnuma, so cyclictest is
build with libnuma.  But my run time environment does not have
a libnuma.  Ah the joy of pre-release file systems.  The NUMA=0
option allowed me to properly build cyclictest to run on this
not quite yet finished file system.

Tested-by: Frank Rowand <frank.rowand@am.sony.com>

-Frank

