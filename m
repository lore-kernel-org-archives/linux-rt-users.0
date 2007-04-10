From: Free Ekanayaka <free@64studio.com>
Subject: patch-2.6.21-rc6-rt0 hangs on boot on amd64
Date: Tue, 10 Apr 2007 17:27:06 +0200
Message-ID: <873b38i71x.fsf__17103.0844947838$1176296977$gmane$org@64studio.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from serverina.hacknight.org ([80.68.90.101]:3406 "EHLO
	serverina.hacknight.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbXDKIWp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Apr 2007 04:22:45 -0400
Received: from localhost.localdomain (unknown [89.196.63.149])
	by serverina.hacknight.org (Postfix) with ESMTP id 39CCB14122
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Apr 2007 08:56:48 +0100 (BST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
I'm new to the list.
I've built the 2.6.21-rc6 kernel release and it seems to work fine on
an amd64 HP Pavillon zv5000 laptop, using this config:
http://people.64studio.com/~free/config-2.6.21-rc6
However the system hangs on boot if I try to apply the 2.6.21-rc6-rt0
realtime patch, with this config:
http://people.64studio.com/~free/config-2.6.21-rc6-rt0
(diffing the two configs shows a lot of differences, but as far as I
can tell what I did was simply to run makeconfig from the first config
after having applied the patch).
The systems hangs when the on of the script contained in the standard
Debian ramfs image tries to launch udevsettle. 
The script is /scripts/init-premount/udev, inside the ramfs image, you
find a copy here:
http://people.64studio.com/~free/udev
If I try to boot the patch kernel using qemu, than everything works,
so it might also be a problem specific to this hardware.
Hints?
Ciao!
Free
