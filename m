From: Free Ekanayaka <free@64studio.com>
Subject: Re: v2.6.21-rt1
Date: Thu, 26 Apr 2007 22:53:54 +0200
Message-ID: <87mz0u502l.fsf@64studio.com>
References: <20070205065636.GA1652@elte.hu> <20070426135730.GA2116@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from serverina.hacknight.org ([80.68.90.101]:4122 "EHLO
	serverina.hacknight.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbXDZUyB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Apr 2007 16:54:01 -0400
In-Reply-To: <20070426135730.GA2116@elte.hu> (Ingo Molnar's message of "Thu, 26 Apr 2007 15:57:30 +0200")
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

|--==> Ingo Molnar writes:

  IM> i have released the v2.6.20-rt1 kernel, which can be downloaded from the 
  IM> usual place:

  IM>     http://redhat.com/~mingo/realtime-preempt/
 
  IM> more info about the -rt patchset can be found in the RT wiki:
 
  IM>     http://rt.wiki.kernel.org

  IM> This is a fixes-only release.

  IM> to build a 2.6.21-rt1 tree, the following patches should be applied:

  IM>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.tar.bz2
  IM>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.21-rt1

I've tested the patch on a Pavillon zv5000 laptop (amd64) and
apparently the kernel still hangs when one of the script in the
initramfs [0] tries to run udevsettle.

Booting with noapic doesn't seem to help, and differently from the
2.6.21-rc6-rt0 release [1] this time the kernel won't boot even with
qemu.

Here's the config I used:

http://people.64studio.com/~free/config-2.6.21-rt1

Ciao,

Free

[0] http://people.64studio.com/~free/udev
[1] http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00332.html
