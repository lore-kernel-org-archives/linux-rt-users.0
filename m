From: Andrew Burgess <aab@cichlid.com>
Subject: Re: patch-2.6.21-rc6-rt0 hangs on boot on amd64
Date: Sat, 14 Apr 2007 08:31:51 -0700
Message-ID: <200704141531.l3EFVppX013708@cichlid.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dsl-63-249-106-23.cruzio.com ([63.249.106.23]:53697 "EHLO
	cichlid.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbXDNP7B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Apr 2007 11:59:01 -0400
Received: from cichlid.com (cichlid.com [127.0.0.1])
	by cichlid.com (8.13.8/8.13.1) with ESMTP id l3EFVpvY013712
	for <linux-rt-users@vger.kernel.org>; Sat, 14 Apr 2007 08:31:52 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>I've built the 2.6.21-rc6 kernel release and it seems to work fine on
>an amd64 HP Pavillon zv5000 laptop, using this config:
>http://people.64studio.com/~free/config-2.6.21-rc6
>However the system hangs on boot if I try to apply the 2.6.21-rc6-rt0
>realtime patch, with this config:
>http://people.64studio.com/~free/config-2.6.21-rc6-rt0
..
>The systems hangs when the on of the script contained in the standard
>Debian ramfs image tries to launch udevsettle. 

My AMD64 X2 non-laptop hangs as well. The screen blanks so I'm guessing it was
in the middle of switching to X11. Vanilla rc6 works fine. Compiled as SMP x86_64.
