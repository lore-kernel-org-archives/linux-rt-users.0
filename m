From: Free Ekanayaka <free@64studio.com>
Subject: Re: patch-2.6.21-rc6-rt0 hangs on boot on amd64
Date: Wed, 25 Apr 2007 14:52:19 +0200
Message-ID: <87irbk7h18.fsf@64studio.com>
References: <200704141531.l3EFVppX013708@cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Burgess <aab@cichlid.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from serverina.hacknight.org ([80.68.90.101]:1241 "EHLO
	serverina.hacknight.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965589AbXDYMwe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Apr 2007 08:52:34 -0400
In-Reply-To: <200704141531.l3EFVppX013708@cichlid.com> (Andrew Burgess's message of "Sat, 14 Apr 2007 08:31:51 -0700")
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

|--==> Andrew Burgess writes:

  >>I've built the 2.6.21-rc6 kernel release and it seems to work fine on
  >>an amd64 HP Pavillon zv5000 laptop, using this config:
  >>http://people.64studio.com/~free/config-2.6.21-rc6
  >>However the system hangs on boot if I try to apply the 2.6.21-rc6-rt0
  >>realtime patch, with this config:
  >>http://people.64studio.com/~free/config-2.6.21-rc6-rt0
  AB> ..
  >>The systems hangs when the on of the script contained in the standard
  >>Debian ramfs image tries to launch udevsettle. 

  AB> My AMD64 X2 non-laptop hangs as well. The screen blanks so I'm guessing it was
  AB> in the middle of switching to X11. Vanilla rc6 works fine. Compiled as SMP x86_64.

Hi all,

I've just tested 2.6.21-rc7 plus patch-2.6.21-rc6-rt0, it still hangs
when the boot scripts try to run udevtrigger. Please let me know if
there are traces/logs I could provide to help the developers debug
this problem.

Thanks,

Free
